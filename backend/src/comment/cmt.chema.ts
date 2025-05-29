import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema({ timestamps: { createdAt: 'created_at' } })
export class Comment extends Document {
  @Prop({ required: true })
  user_id: string;

  @Prop({ required: true })
  recipe_id: string;

  @Prop({ required: true })
  cmt_content: string;
}

export const CommentSchema = SchemaFactory.createForClass(Comment);
