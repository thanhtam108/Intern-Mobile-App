import {
  IsMongoId,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';

export class ReviewDto {
  @IsMongoId()
  recipeId: string;

  @IsNotEmpty()
  userId: string;

  @IsNumber()
  @IsNotEmpty()
  rating: number;

  @IsString()
  @IsOptional()
  content: string;
}
