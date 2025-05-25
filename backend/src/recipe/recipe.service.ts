import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Recipe } from './schema/recipe.schema';
import { RecipeDto } from './dto/recipe.dto';

@Injectable()
export class RecipeService {
  constructor(@InjectModel(Recipe.name) private recipeModel: Model<Recipe>) {}

  async create(dto: RecipeDto): Promise<Recipe> {
    return this.recipeModel.create(dto);
  }

  async findAll(): Promise<Recipe[]> {
    return this.recipeModel.find().populate('category').populate('userId');
  }

  async findOne(id: string): Promise<Recipe> {
    const recipe = await this.recipeModel
      .findById(id)
      .populate('category')
      .populate({ path: 'userId', select: '-password -email' });
    if (!recipe) throw new NotFoundException('Recipe not found');
    return recipe;
  }

  async update(id: string, dto: Partial<RecipeDto>): Promise<Recipe> {
    const updated = await this.recipeModel.findByIdAndUpdate(id, dto, {
      new: true,
    });
    if (!updated) throw new NotFoundException('Recipe not found');
    return updated;
  }

  async delete(id: string): Promise<Recipe> {
    const deleted = await this.recipeModel.findByIdAndDelete(id);
    if (!deleted) throw new NotFoundException('Recipe not found');
    return deleted;
  }
}
