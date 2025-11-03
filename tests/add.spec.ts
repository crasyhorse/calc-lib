import { add } from "@/add";
import { describe, it, expect } from "vitest";

describe("add", () => {
  it("adds positive numbers", () => {
    expect(add(2, 3)).toBe(5);
  });

  it("adds negatives", () => {
    expect(add(-5, 2)).toBe(-3);
  });
});
