import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Comment } from './cmt.chema';

@Injectable()
export class CommentService {
  constructor(
    @InjectModel(Comment.name) private commentModel: Model<Comment>,
  ) {}

  async create(comment: {
    user_id: string;
    recipe_id: string;
    cmt_content: string;
  }) {
    try {
      const created = await this.commentModel.create(comment);
      return {
        message: 'Tạo bình luận thành công',
        data: created,
      };
    } catch (err) {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      throw new BadRequestException('Không thể tạo bình luận: ' + err.message);
    }
  }

  async findByRecipe(recipe_id: string) {
    try {
      const comments = await this.commentModel
        .find({ recipe_id })
        .sort({ created_at: -1 });

      return {
        message: 'Lấy danh sách bình luận thành công',
        data: comments,
      };
    } catch (err) {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      throw new BadRequestException('Không thể lấy bình luận: ' + err.message);
    }
  }

  async remove(cmt_id: string, user_id: string) {
    const comment = await this.commentModel.findById(cmt_id);

    if (!comment) {
      throw new NotFoundException('Bình luận không tồn tại');
    }

    if (comment.user_id.toString() !== user_id) {
      throw new ForbiddenException('Không có quyền xoá bình luận này');
    }

    await this.commentModel.deleteOne({ _id: cmt_id });

    return {
      message: 'Xoá bình luận thành công',
      data: {
        deleted_id: cmt_id,
        user_id: user_id,
        recipe_id: comment.recipe_id,
        cmt_content: comment.cmt_content,
      },
    };
  }
}
