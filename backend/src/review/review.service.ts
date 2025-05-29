import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model, Types } from 'mongoose';
import { Review } from './schema/review.schema';
import { CreateReviewDto } from './dto/review.dto';
import { UpdateReviewDto } from './dto/review.dto';

@Injectable()
export class ReviewService {
  constructor(@InjectModel(Review.name) private reviewModel: Model<Review>) {}

  async create(dto: CreateReviewDto, para_userId: string): Promise<Review> {
    const { ...reviewData } = dto;

    const review = new this.reviewModel({
      ...reviewData,
      userId: para_userId,
    });
    await review.save();

    return review;
  }

  async findByRecipe(recipeId: string): Promise<Review[]> {
    return await this.reviewModel
      .find({ recipeId })
      .populate('userId', '-password -email')
      .sort({ createdAt: -1 });
  }

  async update(id: string, dto: UpdateReviewDto): Promise<Review> {
    const review = await this.reviewModel.findByIdAndUpdate(id, dto, {
      new: true,
    });
    if (!review) throw new NotFoundException('Review not found');
    return review;
  }

  async delete(id: string): Promise<void> {
    const result = await this.reviewModel.findByIdAndDelete(id);
    if (!result) throw new NotFoundException('Review not found');
  }

  async getAverageRating(recipeId: string): Promise<number> {
    const result: { _id: Types.ObjectId; avgRating: number }[] =
      await this.reviewModel.aggregate([
        { $match: { recipeId: new Types.ObjectId(recipeId) } },
        { $group: { _id: '$recipeId', avgRating: { $avg: '$rating' } } },
      ]);

    return result[0]?.avgRating ?? 0;
  }
}
