import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { User, UserSchema } from './user.schema';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { Recipe, RecipeSchema } from 'src/recipe/schema/recipe.schema';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]),
    MongooseModule.forFeature([{ name: Recipe.name, schema: RecipeSchema }]), // Import Recipe schema for user service
  ],
  providers: [UserService],
  controllers: [UserController],
})
export class UserModule {}
