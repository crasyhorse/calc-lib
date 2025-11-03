import { add } from "@/add";
import { describe, it, expect } from "vitest";

describe("add", () => {
  it("adds positive numbers", () => {
    expect(add(2, 3)).toBe(5);
  });

  it("adds negatives", () => {
    expect(add(-5, 2)).toBe(-3);
  });

  it("rounds to given decimal places", () => {
    // 0.1 + 0.2 -> 0.30000000000000004 normalerweise
    expect(add(0.1, 0.2, { roundTo: 2 })).toBe(0.3);
  });
});
