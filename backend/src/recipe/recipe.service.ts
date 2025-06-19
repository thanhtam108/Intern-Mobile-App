import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { HydratedDocument, Model } from 'mongoose';
import { Recipe } from './schema/recipe.schema';
import { RecipeDto } from './dto/recipe.dto';
import { Stepper } from 'src/stepper/schema/stepper.schema';
import { StepperService } from 'src/stepper/stepper.service';
import { Review } from 'src/review/schema/review.schema';
import { Types } from 'mongoose';

@Injectable()
export class RecipeService {
  constructor(
    @InjectModel(Recipe.name) private recipeModel: Model<Recipe>,
    @InjectModel(Stepper.name) private stepperModel: Model<Stepper>,
    @InjectModel(Review.name) private reviewModel: Model<Review>,
    private stepperService: StepperService,
  ) {}

  async create(dto: RecipeDto, para_userId: string): Promise<Recipe> {
    const { steps, ...recipeData } = dto;

    const recipe = new this.recipeModel({
      ...recipeData,
      userId: new Types.ObjectId(para_userId),
    });

    await recipe.save();

    const recipeId = (recipe._id as Types.ObjectId).toString();

    if (steps?.length > 0) {
      await this.stepperService.createSteps(recipeId, steps);
    }

    return recipe;
  }

  async findAll(page: number = 1, limit: number = 10): Promise<any[]> {
    const skip = (page - 1) * limit;

    const recipes = await this.recipeModel
      .find()
      .populate('category')
      .populate({ path: 'userId', select: '-password -email -avatarUrl' })
      .skip(skip)
      .limit(limit);

    const result = await Promise.all(
      recipes.map(async (recipe) => {
        const steps = await this.stepperModel
          .find({ recipeID: recipe._id })
          .sort({ createdAt: 1 });
        const reviews = await this.reviewModel
          .find({ recipeId: recipe._id })
          .sort({ createdAt: -1 });
        return Object.assign(recipe.toObject(), { steps, reviews });
      }),
    );

    return result;
  }

  async findOne(
    id: string,
  ): Promise<Recipe & { steps: Stepper[]; reviews: Review[] }> {
    const recipe = await this.recipeModel
      .findById(id)
      .populate('category')
      .populate({ path: 'userId', select: '-password -email -avatarUrl' });

    if (!recipe) throw new NotFoundException('Recipe not found');

    const steps = await this.stepperModel
      .find({ recipeID: id })
      .sort({ createdAt: 1 });

    const reviews = await this.reviewModel
      .find({ recipeId: id })
      .sort({ createdAt: -1 });

    return Object.assign(recipe.toObject(), { steps, reviews });
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
    await this.reviewModel.deleteMany({ recipeId: id });
    return deleted;
  }

  async findByUserId(userId: string): Promise<any[]> {
    const recipes = await this.recipeModel
      .find({ userId })
      .populate('category')
      .populate({ path: 'userId', select: '-password -email -avatarUrl' })
      .populate('reviews');

    const result = await Promise.all(
      recipes.map(async (recipe) => {
        const steps = await this.stepperModel
          .find({ recipeID: recipe._id })
          .sort({ createdAt: 1 });
        return Object.assign(recipe.toObject(), { steps });
      }),
    );

    return result;
  }

  async findByCategoryId(categoryId: string): Promise<any[]> {
    const recipes = await this.recipeModel
      .find({ category: categoryId })
      .populate('category')
      .populate({ path: 'userId', select: '-password -email -avatarUrl' })
      .populate('reviews');

    if (!recipes.length) throw new NotFoundException('No recipes found');

    const result = await Promise.all(
      recipes.map(async (recipe) => {
        const steps = await this.stepperModel
          .find({ recipeID: recipe._id })
          .sort({ createdAt: 1 });
        return Object.assign(recipe.toObject(), { steps });
      }),
    );

    return result;
  }

  async findByCategoryName(categoryName: string): Promise<any[]> {
    const category = await this.recipeModel.db
      .collection('categories')
      .findOne({ name: categoryName });

    if (!category) throw new NotFoundException('Category not found');

    return this.findByCategoryId(category._id.toString());
  }

  async findByMostRated(limit: number = 10): Promise<any[]> {
    const recipes = await this.recipeModel.aggregate([
      {
        $lookup: {
          from: 'reviews', // Tên collection của Review
          localField: '_id', // ID của Recipe
          foreignField: 'recipeId', // Liên kết với recipeID trong Review
          as: 'reviews', // Kết quả join sẽ lưu trong reviews
        },
      },
      {
        $addFields: {
          averageRating: { $avg: '$reviews.rating' }, // Tính trung bình điểm đánh giá
        },
      },
      {
        $sort: { averageRating: -1 }, // Sắp xếp giảm dần theo điểm đánh giá
      },
      {
        $limit: limit, // Giới hạn số lượng công thức trả về
      },
      {
        $project: {
          _id: 1,
          name: 1,
          description: 1,
          averageRating: 1,
          reviews: 1,
          category: 1,
          userId: 1,
        },
      },
    ]);

    return recipes;
  }

  async findByMostRecent(): Promise<any[]> {
    const recipes = await this.recipeModel
      .find()
      .populate('category')
      .populate({ path: 'userId', select: '-password -email -avatarUrl' })
      .populate('reviews')
      .sort({ createdAt: -1 });

    if (!recipes.length) throw new NotFoundException('No recipes found');

    const result = await Promise.all(
      recipes.map(async (recipe) => {
        const steps = await this.stepperModel
          .find({ recipeID: recipe._id })
          .sort({ createdAt: 1 });
        return Object.assign(recipe.toObject(), { steps });
      }),
    );

    return result;
  }
  async findMostPopularRecipes(): Promise<Recipe[]> {
    const recipes = await this.recipeModel
      .find()
      .populate('category')
      .populate({ path: 'userId', select: '-password -email -avatarUrl' })
      .populate('reviews');

    if (!recipes.length) throw new NotFoundException('No recipes found');

    const sortedRecipes = recipes.sort((a, b) => {
      return b.view - a.view;
    });

    const result = await Promise.all(
      sortedRecipes.map(async (recipe) => {
        const steps = await this.stepperModel
          .find({ recipeID: recipe._id })
          .sort({ createdAt: 1 });
        return Object.assign(recipe.toObject(), { steps });
      }),
    );

    return result;
  }

  async incrementViewCount(id: string): Promise<Recipe> {
    const recipe = await this.recipeModel.findByIdAndUpdate(
      id,
      { $inc: { view: 1 } },
      { new: true },
    );
    if (!recipe) throw new NotFoundException('Recipe not found');
    return recipe;
  }

  async findMostRatedByCategory(categoryId: string): Promise<Recipe[]> {
    const recipes = await this.recipeModel
      .find({ category: categoryId })
      .populate('category')
      .populate({ path: 'userId', select: '-password -email -avatarUrl' })
      .populate('reviews');
    if (!recipes.length) throw new NotFoundException('No recipes found');
    const sortedRecipes = recipes.sort((a, b) => {
      const aRating = a.reviews.reduce((sum, review) => sum + review.rating, 0);
      const bRating = b.reviews.reduce((sum, review) => sum + review.rating, 0);
      return bRating - aRating;
    });
    const result = await Promise.all(
      sortedRecipes.map(async (recipe) => {
        const steps = await this.stepperModel
          .find({ recipeID: recipe._id })
          .sort({ createdAt: 1 });
        return Object.assign(recipe.toObject(), { steps });
      }),
    );
    return result;
  }
}
