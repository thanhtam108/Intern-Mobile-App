import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';
import { MailService } from './mail/mail.service';
import { MailModule } from './mail/mail.module';
import { UserModule } from './users/user.module';
import { CategoryModule } from './categories/category.module';
import { ConfigModule } from '@nestjs/config';
import { CommentModule } from './comment/cmt.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    MongooseModule.forRoot(process.env.MONGO_URI!),
    AuthModule,
    MailModule,
    UserModule,
    CategoryModule,
    CommentModule,
  ],
  controllers: [AppController],
  providers: [AppService, MailService],
})
export class AppModule {}
