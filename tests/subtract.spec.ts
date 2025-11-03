import { subtract } from "@/subtract";
import { describe, it, expect } from "vitest";

describe("subtract", () => {
  it("subtracts numbers", () => {
    expect(subtract(10, 4)).toBe(6);
  });

  it("handles negative results", () => {
    expect(subtract(2, 5)).toBe(-3);
  });
});
