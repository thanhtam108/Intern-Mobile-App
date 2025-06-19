import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from './user.schema';
import { Recipe } from 'src/recipe/schema/recipe.schema';

@Injectable()
export class UserService {
  constructor(
    @InjectModel(User.name) private userModel: Model<User>,
    @InjectModel(Recipe.name) private recipeModel: Model<Recipe>, // inject Recipe model
  ) {}

  async findById(id: string) {
    const user = await this.userModel.findById(id).select('-password');
    if (!user) throw new NotFoundException('Người dùng không tồn tại');
    return user;
  }

  async findAll() {
    return this.userModel.find().select('-password');
  }

  async update(id: string, updateData: Partial<User>) {
    const user = await this.userModel.findByIdAndUpdate(id, updateData, {
      new: true,
    });
    if (!user) throw new NotFoundException('Người dùng không tồn tại');
    return user;
  }

  async getTopUsersWithRecipes(limit: number = 10): Promise<any> {
    const topUsers = await this.recipeModel.aggregate([
      {
        $group: {
          _id: '$userId', // Nhóm theo userId
          recipeCount: { $sum: 1 }, // Đếm số lượng công thức
        },
      },
      {
        $sort: { recipeCount: -1 }, // Sắp xếp giảm dần theo số công thức
      },
      {
        $limit: limit, // Lấy top N
      },
      {
        $lookup: {
          from: 'users', // Tên collection MongoDB
          localField: '_id', // userId từ Recipe
          foreignField: '_id', // _id từ User
          as: 'userDetails',
        },
      },
      {
        $unwind: '$userDetails',
      },
      {
        $project: {
          _id: 0,
          userId: '$_id',
          recipeCount: 1,
          name: '$userDetails.name',
          email: '$userDetails.email',
        },
      },
    ]);
    return topUsers;
  }
}
