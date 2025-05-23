import {
  Injectable,
  BadRequestException,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { User } from '../users/user.schema';
import { PendingUser } from '../users/pending-user.schema';
import { MailService } from 'src/mail/mail.service';

@Injectable()
export class AuthService {
  constructor(
    @InjectModel(User.name) private userModel: Model<User>,
    @InjectModel(PendingUser.name) private pendingUserModel: Model<PendingUser>,
    private jwtService: JwtService,
    private mailService: MailService,
  ) {}

  private async generateAndSendOtp(
    email: string,
    hashedPassword?: string,
    fullName?: string,
  ) {
    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const otpExpiresAt = new Date(Date.now() + 5 * 60 * 1000);

    await this.pendingUserModel.findOneAndUpdate(
      { email },
      {
        email,
        ...(hashedPassword && { password: hashedPassword }),
        ...(fullName && { name: fullName }),
        otp,
        otpExpiresAt,
      },
      { upsert: true, new: true },
    );

    await this.mailService.sendOtp(email, otp);
  }

  async register(email: string, password: string, fullName: string) {
    const existing = await this.userModel.findOne({ email });
    if (existing) throw new BadRequestException('Email đã được sử dụng');

    const hashed = await bcrypt.hash(password, 10);
    await this.generateAndSendOtp(email, hashed, fullName);

    return {
      message: 'OTP đã gửi tới email',
      data: {
        user: { email: email },
      },
    };
  }

  async resendOtp(email: string) {
    const pending = await this.pendingUserModel.findOne({ email });
    if (!pending) {
      throw new BadRequestException(
        'Email chưa được đăng ký hoặc không hợp lệ',
      );
    }

    await this.generateAndSendOtp(email);

    return {
      message: 'OTP đã được gửi lại vào email',
      data: {
        user: { email: email },
      },
    };
  }

  async verifyOtp(email: string, otp: string) {
    const pending = await this.pendingUserModel.findOne({ email });
    if (!pending || pending.otp !== otp)
      throw new UnauthorizedException('OTP không đúng');
    if (pending.otpExpiresAt < new Date())
      throw new UnauthorizedException('OTP đã hết hạn');

    const user = await this.userModel.create({
      email: pending.email,
      password: pending.password,
      name: pending.name,
    });

    await this.pendingUserModel.deleteOne({ email });

    const access_token = this.jwtService.sign({
      sub: user._id,
      email: user.email,
    });
    return {
      message: 'Đăng ký tài khoản thành công',
      data: {
        access_token,
        user: {
          id: user._id,
          name: user.name,
          email: user.email,
          bio: user.bio,
          avatar: user.avatarUrl,
        },
      },
    };
  }

  async login(email: string, password: string) {
    const user = await this.userModel.findOne({ email });
    console.log('>> User:', user);
    if (!user) {
      throw new UnauthorizedException('Không tìm thấy người dùng!');
    }
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      throw new UnauthorizedException('Sai mật khẩu!');
    }
    const access_token = this.jwtService.sign({
      sub: user._id,
      email: user.email,
    });
    return {
      message: 'Đăng nhập thành công',
      data: {
        access_token,
        user: {
          id: user._id,
          name: user.name,
          email: user.email,
          bio: user.bio,
          avatar: user.avatarUrl,
        },
      },
    };
  }

  logout() {
    return { message: 'Đăng xuất thành công (client xóa token)' };
  }
}
