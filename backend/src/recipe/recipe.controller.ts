import {
  Controller,
  Post,
  Get,
  Put,
  Delete,
  Param,
  Body,
  Req,
  UseGuards,
  UsePipes,
  ValidationPipe,
  Query,
} from '@nestjs/common';
import { RecipeService } from './recipe.service';
import { RecipeDto } from './dto/recipe.dto';
import { AuthGuard } from '@nestjs/passport';
import { Request } from 'express';

@Controller('recipes')
export class RecipeController {
  constructor(private readonly recipeService: RecipeService) {}

  @UseGuards(AuthGuard('jwt'))
  @Post('insert')
  @UsePipes(new ValidationPipe({ whitelist: true }))
  create(
    @Body() dto: RecipeDto,
    @Req() req: Request & { user: { userId: string } },
  ) {
    return this.recipeService.create(dto, req.user.userId);
  }

  @Get('all')
  findAll(@Query('page') page?: number, @Query('limit') limit?: number) {
    return this.recipeService.findAll(Number(page) || 1, Number(limit) || 10);
  }

  @Get('most-rated')
  findByMostRated(@Query('limit') limit?: number) {
    return this.recipeService.findByMostRated(Number(limit) || 10);
  }

  @Get('most-recent')
  findByMostRecent() {
    return this.recipeService.findByMostRecent();
  }

  @Get('most-popular')
  findMostPopularRecipes() {
    return this.recipeService.findMostPopularRecipes();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.recipeService.findOne(id);
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() dto: Partial<RecipeDto>) {
    return this.recipeService.update(id, dto);
  }

  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.recipeService.delete(id);
  }

  @Get('category/name/:categoryName')
  findByCategoryName(@Param('categoryName') categoryName: string) {
    return this.recipeService.findByCategoryName(categoryName);
  }

  @Get('category/id/:categoryId')
  findByCategoryId(@Param('categoryId') categoryId: string) {
    return this.recipeService.findByCategoryId(categoryId);
  }

  @Get('user/:userId')
  findByUserId(@Param('userId') userId: string) {
    return this.recipeService.findByUserId(userId);
  }

  @Put('view/:id')
  incrementViewCount(@Param('id') id: string) {
    return this.recipeService.incrementViewCount(id);
  }

  @Get('most-rated/category/:categoryId')
  findMostRatedByCategory(@Param('categoryId') categoryId: string) {
    return this.recipeService.findMostRatedByCategory(categoryId);
  }
}
