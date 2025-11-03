import { multiply } from "@/multiply";
import { describe, it, expect } from "vitest";

describe("multiply", () => {
  it("multiplies numbers", () => {
    expect(multiply(4, 6)).toBe(24);
  });
});
