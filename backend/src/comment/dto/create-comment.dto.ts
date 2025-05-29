import { IsString, IsNotEmpty } from 'class-validator';

export class CreateCommentDto {
  @IsString({ message: 'recipe_id must be a string' })
  @IsNotEmpty({ message: 'recipe_id is required' })
  recipe_id: string;

  @IsString({ message: 'cmt_content must be a string' })
  @IsNotEmpty({ message: 'cmt_content is required' })
  cmt_content: string;
}
