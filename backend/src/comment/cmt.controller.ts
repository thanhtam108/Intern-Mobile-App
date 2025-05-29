import {
  Controller,
  Post,
  Get,
  Param,
  Delete,
  Body,
  Req,
  UseGuards,
} from '@nestjs/common';
import { CommentService } from './cmt.service';
import { AuthGuard } from '@nestjs/passport';
import { CreateCommentDto } from './dto/create-comment.dto';

@Controller('comments')
export class CommentController {
  constructor(private readonly commentService: CommentService) {}

  @UseGuards(AuthGuard('jwt'))
  @Post()
  create(@Body() body: CreateCommentDto, @Req() req: any) {
    console.log('BODY:', body);
    return this.commentService.create({
      user_id: req.user.userId,
      recipe_id: body.recipe_id,
      cmt_content: body.cmt_content,
    });
  }

  @Get(':recipe_id')
  findByRecipe(@Param('recipe_id') recipe_id: string) {
    return this.commentService.findByRecipe(recipe_id);
  }

  @UseGuards(AuthGuard('jwt'))
  @Delete(':cmt_id')
  remove(@Param('cmt_id') cmt_id: string, @Req() req: any) {
    return this.commentService.remove(cmt_id, req.user.userId);
  }
}
