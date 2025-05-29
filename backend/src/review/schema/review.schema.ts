import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema({ timestamps: true })
export class Review extends Document {
  @Prop({ required: true, ref: 'Recipe' })
  recipeId: string;

  @Prop({ required: true, ref: 'User' })
  userId: string;

  @Prop({ required: true, min: 1, max: 5 })
  rating: number;

  @Prop({ required: true, trim: true })
  content: string;
}

export const ReviewSchema = SchemaFactory.createForClass(Review);
