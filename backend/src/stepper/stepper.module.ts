import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { Stepper, StepperSchema } from './schema/stepper.schema';
import { StepperService } from './stepper.service';
// import { FavoriteController } from './favorites.controller';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: Stepper.name, schema: StepperSchema }]),
  ],
  //   controllers: [FavoriteController],
  providers: [StepperService],
})
export class StepperModule {}
