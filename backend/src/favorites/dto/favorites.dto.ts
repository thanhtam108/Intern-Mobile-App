import { IsMongoId } from 'class-validator';

export class FavoriteDto {
  @IsMongoId()
  recipeId: string;
}
