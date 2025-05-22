// import {
//   Injectable,
//   NestInterceptor,
//   ExecutionContext,
//   CallHandler,
// } from '@nestjs/common';
// import { Observable } from 'rxjs';
// import { map } from 'rxjs/operators';
// import { ApiResponse } from './api-response.dto';
// import { Response } from 'express';

// @Injectable()
// export class ResponseInterceptor<T>
//   implements NestInterceptor<T, ApiResponse<T>>
// {
//   intercept(
//     context: ExecutionContext,
//     next: CallHandler<T>,
//   ): Observable<ApiResponse<T>> {
//     const ctx = context.switchToHttp();
//     const res = ctx.getResponse<Response>();

//     return next.handle().pipe(
//       map((data) => {
//         if (
//           data &&
//           typeof data === 'object' &&
//           'message' in data &&
//           typeof data.message === 'string' &&
//           'statusCode' in data &&
//           typeof data.statusCode === 'number' &&
//           'data' in data
//         ) {
//           return data as ApiResponse<T>;
//         }
//         const statusCode =
//           typeof res.statusCode === 'number' ? res.statusCode : 200;

//         return new ApiResponse<T>(data, 'Thành công', statusCode);
//       }),
//     );
//   }
// }
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
      map((original) => {
        const defaultStatusCode = res.statusCode ?? 200;
        if (
          original &&
          typeof original === 'object' &&
          !Array.isArray(original)
        ) {
          const obj = original as Record<string, unknown>;

          const statusCode =
            typeof obj.statusCode === 'number'
              ? obj.statusCode
              : defaultStatusCode;

          const message =
            typeof obj.message === 'string' ? obj.message : 'Thành công';

          const data = 'data' in obj ? (obj.data as T) : (original as T);

          return new ApiResponse<T>(data, message, statusCode);
        }

        return new ApiResponse<T>(original, 'Thành công', defaultStatusCode);
        // const statusCode = original?.statusCode ?? res.statusCode ?? 200;
        // const message = original?.message ?? 'Thành công';
        // const data = 'data' in original ? original.data : original;

        // return new ApiResponse<T>(data, message, statusCode);
      }),
    );
  }
}
