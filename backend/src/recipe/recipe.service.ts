import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Recipe } from './schema/recipe.schema';
import { RecipeDto } from './dto/recipe.dto';
import { Stepper } from 'src/stepper/schema/stepper.schema';
import { StepperService } from 'src/stepper/stepper.service';
import { Types } from 'mongoose';

@Injectable()
export class RecipeService {
  constructor(
    @InjectModel(Recipe.name) private recipeModel: Model<Recipe>,
    @InjectModel(Stepper.name) private stepperModel: Model<Stepper>,
    private stepperService: StepperService,
  ) {}

  async create(dto: RecipeDto, para_userId: string): Promise<Recipe> {
    const { steps, ...recipeData } = dto;

    const recipe = new this.recipeModel({
      ...recipeData,
      userId: para_userId,
    });

    await recipe.save();

    const recipeId = (recipe._id as Types.ObjectId).toString();

    if (steps?.length > 0) {
      await this.stepperService.createSteps(recipeId, steps);
    }

    return recipe;
  }

  async findAll(): Promise<Recipe[]> {
    return this.recipeModel.find().populate('category').populate('userId');
  }

  async findOne(id: string): Promise<Recipe & { steps: Stepper[] }> {
    const recipe = await this.recipeModel
      .findById(id)
      .populate('category')
      .populate({ path: 'userId', select: '-password -email' });
    if (!recipe) throw new NotFoundException('Recipe not found');
    const steps = await this.stepperModel
      .find({ recipeID: id })
      .sort({ createdAt: 1 });

    return Object.assign(recipe.toObject(), { steps });
  }

  async update(id: string, dto: Partial<RecipeDto>): Promise<Recipe> {
    const { steps, ...updateData } = dto;

    const updated = await this.recipeModel.findByIdAndUpdate(id, updateData, {
      new: true,
    });
    if (!updated) throw new NotFoundException('Recipe not found');

    if (steps) {
      await this.stepperModel.deleteMany({ recipeID: id });
      await this.stepperService.createSteps(id, steps);
    }
    const populatedRecipe = await this.recipeModel
      .findById(id)
      .populate('category')
      .populate({ path: 'userId', select: '-password -email' });
    const allSteps = await this.stepperModel
      .find({ recipeID: id })
      .sort({ createdAt: 1 });
    if (!populatedRecipe) throw new NotFoundException('Recipe not found');
    return Object.assign(populatedRecipe.toObject(), { steps: allSteps });
  }

  async delete(id: string): Promise<Recipe> {
    const deleted = await this.recipeModel.findByIdAndDelete(id);
    if (!deleted) throw new NotFoundException('Recipe not found');
    await this.stepperModel.deleteMany({ recipeID: id });
    return deleted;
  }
}
