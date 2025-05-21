import {
  Injectable,
  BadRequestException,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { User } from './schemas/user.schema';
import { PendingUser } from './schemas/pending-user.schema';
import { MailService } from 'src/mail/mail.service';

@Injectable()
export class AuthService {
  constructor(
    @InjectModel(User.name) private userModel: Model<User>,
    @InjectModel(PendingUser.name) private pendingUserModel: Model<PendingUser>,
    private jwtService: JwtService,
    private mailService: MailService,
  ) {}

  async register(email: string, password: string) {
    const existing = await this.userModel.findOne({ email });
    if (existing) throw new BadRequestException('Email đã được sử dụng');

    const hashed = await bcrypt.hash(password, 10);
    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const otpExpiresAt = new Date(Date.now() + 5 * 60 * 1000);

    await this.pendingUserModel.findOneAndUpdate(
      { email },
      { email, password: hashed, otp, otpExpiresAt },
      { upsert: true, new: true },
    );

    await this.mailService.sendOtp(email, otp);
    return { message: 'OTP đã gửi tới email' };
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
    });

    await this.pendingUserModel.deleteOne({ email });

    const token = this.jwtService.sign({ sub: user._id, email: user.email });
    return { access_token: token };
  }

  async login(email: string, password: string) {
    const user = await this.userModel.findOne({ email });
    if (!user || !(await bcrypt.compare(password, user.password))) {
      throw new UnauthorizedException('Sai email hoặc mật khẩu');
    }
    const token = this.jwtService.sign({ sub: user._id, email: user.email });
    return { access_token: token };
  }

  logout() {
    return { message: 'Đăng xuất thành công (client xóa token)' };
  }
}
