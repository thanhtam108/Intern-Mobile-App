import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { Recipe, RecipeSchema } from './schema/recipe.schema';
import { RecipeService } from './recipe.service';
import { RecipeController } from './recipe.controller';
import { Stepper, StepperSchema } from 'src/stepper/schema/stepper.schema';
import { StepperService } from 'src/stepper/stepper.service';
import { Review, ReviewSchema } from 'src/review/schema/review.schema';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: Recipe.name, schema: RecipeSchema }]),
    MongooseModule.forFeature([{ name: Stepper.name, schema: StepperSchema }]),
    MongooseModule.forFeature([{ name: Review.name, schema: ReviewSchema }]),
  ],
  controllers: [RecipeController],
  providers: [RecipeService, StepperService],
})
export class RecipeModule {}
