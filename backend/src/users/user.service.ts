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
    const user = await this.userModel
      .findByIdAndUpdate(id, updateData, {
        new: true,
      })
      .select('-password');
    if (!user) throw new NotFoundException('Người dùng không tồn tại');
    return user;
  }

  async getTopUsersWithRecipes(limit: number = 10): Promise<any> {
    const topUsers = await this.recipeModel.aggregate([
      {
        $group: {
          _id: '$userId',
          recipeCount: { $sum: 1 }, 
        },
      },
      {
        $sort: { recipeCount: -1 }, 
      },
      {
        $limit: limit, 
      },
      {
        $lookup: {
          from: 'users', 
          localField: '_id', 
          foreignField: '_id',
          as: 'userDetails',
        },
      },
      {
        $unwind: {
          path: '$userDetails',
          preserveNullAndEmptyArrays: true, 
        }
      },
      {
        $project: {
          _id: 0,
          userId: '$_id',
          recipeCount: 1,
          name: { $ifNull: ['$userDetails.name', null] },
          email: { $ifNull: ['$userDetails.email', null] },
          bio: { $ifNull: ['$userDetails.bio', null] },
          avatarUrl:{ $ifNull: ['$userDetails.avatarUrl', null] },
        },
      },
    ]);
    return topUsers;
  }

  async searchChefs(query: string): Promise<any> {
    const regex = new RegExp(query, 'i');
  
    const users = await this.userModel.aggregate([
      {
        $match: {
          $or: [
            { name: { $regex: regex } },
            { email: { $regex: regex } },
          ],
        },
      },
      {
        $lookup: {
          from: 'recipes',
          localField: '_id',
          foreignField: 'userId',
          as: 'userRecipes',
        },
      },
      {
        $project: {
          _id: 0,
          userId: '$_id',
          name: { $ifNull: ['$name', null] },
          email: { $ifNull: ['$email', null] },
          bio: { $ifNull: ['$bio', null] },
          avatarUrl: { $ifNull: ['$avatarUrl', null] },
          recipeCount: { $size: '$userRecipes' }, // = 0 nếu không có recipe
        },
      },
    ]);
    if (!users.length) {
      throw new NotFoundException('Không tìm thấy đầu bếp phù hợp');
    }
    return {
      message: 'Tìm kiếm thành công',
      data: users,
    };
  }
  

}
