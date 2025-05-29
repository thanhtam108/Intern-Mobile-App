import { Injectable, NotFoundException } from '@nestjs/common';
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
    return this.commentModel.create(comment);
  }

  async findByRecipe(recipe_id: string) {
    return this.commentModel.find({ recipe_id }).sort({ created_at: -1 });
  }

  async remove(cmt_id: string, user_id: string) {
    const comment = await this.commentModel.findById(cmt_id);
    if (!comment) throw new NotFoundException('Bình luận không tồn tại');
    if (comment.user_id !== user_id) throw new Error('Không có quyền xoá');

    return this.commentModel.deleteOne({ _id: cmt_id });
  }
}
