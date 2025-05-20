import { MongooseModule } from '@nestjs/mongoose';

export const MongoConfig = MongooseModule.forRoot(
  process.env.MONGO_URI ||
    'mongodb+srv://rootUser:1@cluster0.pcye9v0.mongodb.net/FoodApp?retryWrites=true&w=majority&appName=Cluster0',
);
