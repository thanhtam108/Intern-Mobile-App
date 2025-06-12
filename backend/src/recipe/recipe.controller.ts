import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Req,
  UseGuards,
  UseInterceptors,
  UsePipes,
  ValidationPipe,
} from '@nestjs/common';
import { RecipeService } from './recipe.service';
import { RecipeDto } from './dto/recipe.dto';
import { ResponseInterceptor } from 'src/common/interceptors/response.interceptor';
import { AuthGuard } from '@nestjs/passport';

@Controller('recipes')
@UseInterceptors(ResponseInterceptor)
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
  findAll() {
    return this.recipeService.findAll();
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
}
