import {
  IsMongoId,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';

export class CreateReviewDto {
  @IsMongoId()
  @IsNotEmpty()
  recipeId: string;

  //   @IsMongoId()
  //   userId: string;

  @IsNumber()
  @IsNotEmpty()
  rating: number;

  @IsString()
  @IsOptional()
  content?: string;
}

export class UpdateReviewDto {
  @IsNumber()
  @IsOptional()
  rating?: number;

  @IsString()
  @IsOptional()
  content?: string;
}
