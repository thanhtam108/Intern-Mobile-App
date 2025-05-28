import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import mongoose, { Document, Types } from 'mongoose';
import { Stepper } from 'src/stepper/schema/stepper.schema';

@Schema({ timestamps: true })
export class Recipe extends Document {
  @Prop({ required: true })
  name: string;

  @Prop()
  description: string;

  @Prop({ type: [String], required: true })
  ingredients: string[];

  @Prop({ default: 0 })
  view: number;

  @Prop({ type: Types.ObjectId, ref: 'User', required: true })
  userId: Types.ObjectId;

  @Prop({ type: Types.ObjectId, ref: 'Category', required: true })
  category: Types.ObjectId;

  @Prop({ type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Steppers' }] })
  steps: Stepper[];
}

export const RecipeSchema = SchemaFactory.createForClass(Recipe);
