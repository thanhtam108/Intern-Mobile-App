import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from './user.schema';

@Injectable()
export class UserService {
  constructor(@InjectModel(User.name) private userModel: Model<User>) {}

  async findById(id: string) {
    const user = await this.userModel.findById(id).select('-password');
    if (!user) throw new NotFoundException('Người dùng không tồn tại');
    return user;
  }

  async findAll() {
    return this.userModel.find().select('-password');
  }
}
