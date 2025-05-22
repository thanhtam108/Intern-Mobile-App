import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema({ timestamps: true })
export class PendingUser extends Document {
  @Prop({ required: true, unique: true })
  email: string;

  @Prop({ required: true })
  password: string;

  @Prop({ required: true })
  otp: string;

  @Prop({ required: true })
  otpExpiresAt: Date;
}

export const PendingUserSchema = SchemaFactory.createForClass(PendingUser);
