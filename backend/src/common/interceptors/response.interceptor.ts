import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { ApiResponse } from './api-response.dto';
import { Response } from 'express';

@Injectable()
export class ResponseInterceptor<T>
  implements NestInterceptor<T, ApiResponse<T>>
{
  intercept(
    context: ExecutionContext,
    next: CallHandler<T>,
  ): Observable<ApiResponse<T>> {
    const ctx = context.switchToHttp();
    const res = ctx.getResponse<Response>();

    return next.handle().pipe(
      map((data) => {
        if (
          data &&
          typeof data === 'object' &&
          'message' in data &&
          typeof data.message === 'string' &&
          'statusCode' in data &&
          typeof data.statusCode === 'number' &&
          'data' in data
        ) {
          // Ép kiểu chắc chắn là ApiResponse<T>
          return data as ApiResponse<T>;
        }
        const statusCode =
          typeof res.statusCode === 'number' ? res.statusCode : 200;

        return new ApiResponse<T>(data, 'Thành công', statusCode);
      }),
    );
  }
}
