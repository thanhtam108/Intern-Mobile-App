import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Schema as MongooseSchema, Types } from 'mongoose';
import { Recipe } from '../../recipe/schema/recipe.schema';

@Schema({ timestamps: true })
export class Stepper {
  @Prop({
    type: MongooseSchema.Types.ObjectId,
    ref: Recipe.name,
    required: true,
  })
  recipeID: Types.ObjectId;

  @Prop({ required: true })
  stepName: string;

  @Prop({ required: true })
  stepDescription: string;

  @Prop()
  imageUrl?: string;
}

export const StepperSchema = SchemaFactory.createForClass(Stepper);
