import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Stepper } from './schema/stepper.schema';
import { Model } from 'mongoose';
import { StepperDto } from './dto/stepper.dto';

@Injectable()
export class StepperService {
  constructor(
    @InjectModel(Stepper.name) private stepperModel: Model<Stepper>,
  ) {}

  async createSteps(recipeID: string, steps: StepperDto[]) {
    const docs = steps.map((step) => ({
      ...step,
      recipeID,
    }));
    return this.stepperModel.insertMany(docs);
  }
}
