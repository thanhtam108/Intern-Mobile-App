export class ApiResponse<T> {
  message: string;
  statusCode: number;
  data: T;

  constructor(data: T, message = 'Thành công', statusCode = 200) {
    this.message = message;
    this.statusCode = statusCode;
    this.data = data;
  }
}
