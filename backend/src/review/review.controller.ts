import {
  Controller,
  Post,
  Get,
  Patch,
  Delete,
  Param,
  Body,
  Query,
  UseInterceptors,
  UseGuards,
  UsePipes,
  ValidationPipe,
  Req,
} from '@nestjs/common';
import { ReviewService } from './review.service';
import { CreateReviewDto } from './dto/review.dto';
import { UpdateReviewDto } from './dto/review.dto';
import { ResponseInterceptor } from 'src/common/interceptors/response.interceptor';
import { AuthGuard } from '@nestjs/passport';

@Controller('reviews')
@UseInterceptors(ResponseInterceptor)
export class ReviewController {
  constructor(private readonly reviewService: ReviewService) {}

  @UseGuards(AuthGuard('jwt'))
  @Post()
  @UsePipes(new ValidationPipe({ whitelist: true }))
  create(
    @Body() dto: CreateReviewDto,
    @Req() req: Request & { user: { userId: string } },
  ) {
    return this.reviewService.create(dto, req.user.userId);
  }

  @Get()
  findByRecipe(@Query('recipeId') recipeId: string) {
    return this.reviewService.findByRecipe(recipeId);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() dto: UpdateReviewDto) {
    return this.reviewService.update(id, dto);
  }

  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.reviewService.delete(id);
  }
}
