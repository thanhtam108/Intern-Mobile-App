import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Put,
  UsePipes,
  ValidationPipe,
} from '@nestjs/common';
import { RecipeService } from './recipe.service';
import { RecipeDto } from './dto/recipe.dto';

@Controller('recipes')
export class RecipeController {
  constructor(private readonly recipeService: RecipeService) {}

  @Post('insert')
  @UsePipes(new ValidationPipe({ whitelist: true }))
  create(@Body() dto: RecipeDto) {
    return this.recipeService.create(dto);
  }

  @Get('all')
  findAll() {
    return this.recipeService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.recipeService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() dto: Partial<RecipeDto>) {
    return this.recipeService.update(id, dto);
  }

  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.recipeService.delete(id);
  }
}
