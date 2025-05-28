import { IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class StepperDto {
  @IsString()
  @IsNotEmpty()
  stepName: string;

  @IsString()
  @IsNotEmpty()
  stepDescription: string;

  @IsOptional()
  @IsString()
  imageUrl?: string;
}
