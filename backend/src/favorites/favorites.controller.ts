import {
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Body,
  UseGuards,
  Req,
} from '@nestjs/common';
import { FavoriteService } from './favorites.service';
import { AuthGuard } from '@nestjs/passport';
import { FavoriteDto } from './dto/favorites.dto';

@Controller('favorites')
@UseGuards(AuthGuard('jwt'))
export class FavoriteController {
  constructor(private favoriteService: FavoriteService) {}

  @Post()
  addFavorite(
    @Body() dto: FavoriteDto,
    @Req() req: Request & { user: { userId: string } },
  ) {
    return this.favoriteService.addFavorite(req.user.userId, dto);
  }

  @Get()
  getMyFavorites(@Req() req: Request & { user: { userId: string } }) {
    return this.favoriteService.findUserFavorites(req.user.userId);
  }

  @Delete(':recipeId')
  removeFavorite(
    @Param('recipeId') recipeId: string,
    @Req() req: Request & { user: { userId: string } },
  ) {
    return this.favoriteService.removeFavorite(req.user.userId, recipeId);
  }
  @Get('is-favorite/:recipeId')
  isFavorite(
    @Param('recipeId') recipeId: string,
    @Req() req: Request & { user: { userId: string } },
  ): Promise<boolean> {
    return this.favoriteService.isFavorite(req.user.userId, recipeId);
  }
}
