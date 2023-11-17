import { Injectable } from "@nestjs/common";

@Injectable()
export class AppService {
  getSalute(name: string): string {
    return `Hello ${name}, You're mostly welcome!`;
  }
  getHello(): string {
    return "Hello World! This is a test";
  }
}
