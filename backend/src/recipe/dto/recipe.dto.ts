import {
  IsArray,
  ArrayNotEmpty,
  IsMongoId,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import { StepperDto } from '../../stepper/dto/stepper.dto';

export class RecipeDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsOptional()
  @IsString()
  description?: string;

  @Type(() => Number)
  @IsNumber()
  view: number;

  @IsArray()
  @ArrayNotEmpty()
  @IsString({ each: true })
  ingredients: string[];

  @IsOptional()
  @IsString()
  duration?: string;

  @IsMongoId()
  category: string;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => StepperDto)
  steps: StepperDto[];

  @IsOptional()
  @IsString()
  imageUrl?: string;
}
