import {
  Controller,
  Get,
  Param,
  Query,
  Req,
  UseGuards,
  UseInterceptors,
  BadRequestException,
  Put,
  Body,
} from '@nestjs/common';
import { UserService } from './user.service';
import { AuthGuard } from '@nestjs/passport';
import { ResponseInterceptor } from '../common/interceptors/response.interceptor';
import { UserDto } from './dto/user.dto';

@Controller('user')
@UseInterceptors(ResponseInterceptor)
export class UserController {
  constructor(private userService: UserService) {}

  @UseGuards(AuthGuard('jwt'))
  @Get('me')
  getCurrentUser(@Req() req: Request & { user: { userId: string } }) {
    return this.userService.findById(req.user.userId);
  }

  @Get('top')
  getTopUsersWithRecipes(@Query('limit') limit: number) {
    if (limit && isNaN(limit)) {
      throw new BadRequestException('Limit must be a number');
    }
    return this.userService.getTopUsersWithRecipes(limit || 10);
  }

  @Get('all')
  getAllUsers() {
    return this.userService.findAll();
  }
  @Get(':id')
  getUserById(@Param('id') id: string) {
    return this.userService.findById(id);
  }
  @Put(':id')
  update(@Param('id') id: string, @Body() dto: Partial<UserDto>) {
    return this.userService.update(id, dto);
  }
}
