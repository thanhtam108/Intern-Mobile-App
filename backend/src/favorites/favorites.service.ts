// favorite.service.ts
import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Favorite } from './schema/favorites.schema';
import { Model, Types } from 'mongoose';
import { FavoriteDto } from './dto/favorites.dto';

@Injectable()
export class FavoriteService {
  constructor(
    @InjectModel(Favorite.name) private favoriteModel: Model<Favorite>,
  ) {}

  async addFavorite(userId: string, dto: FavoriteDto): Promise<Favorite> {
    const exists = await this.favoriteModel.findOne({
      userId: new Types.ObjectId(userId),
      recipeId: new Types.ObjectId(dto.recipeId),
    });

    if (exists) {
      throw new BadRequestException('Đã thích công thức này rồi');
    }

    const favorite = new this.favoriteModel({
      userId: new Types.ObjectId(userId),
      recipeId: new Types.ObjectId(dto.recipeId),
    });

    return favorite.save();
  }

  async findUserFavorites(userId: string) {
    return this.favoriteModel.find({ userId }).populate('recipeId').exec();
  }

  async removeFavorite(userId: string, recipeId: string) {
    return this.favoriteModel.deleteOne({
      userId: new Types.ObjectId(userId),
      recipeId: new Types.ObjectId(recipeId),
    });
  }

  async isFavorite(userId: string, recipeId: string): Promise<boolean> {
    const favorite = await this.favoriteModel.findOne({
      userId: new Types.ObjectId(userId),
      recipeId: new Types.ObjectId(recipeId),
    });
    return !!favorite;
  }
}
