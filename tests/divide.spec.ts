import { divide } from "@/divide";
import { describe, it, expect } from "vitest";

describe("divide", () => {
  it("divides numbers", () => {
    expect(divide(8, 4)).toBe(2);
  });

  it("throws on divide by zero", () => {
    expect(() => divide(4, 0)).toThrowError(/divide by zero/i);
  });
});
