import { modulo } from "@/modulo";
import { describe, it, expect } from "vitest";

describe("modulo (math semantics)", () => {
  it("handles positive numbers", () => {
    expect(modulo(10, 3)).toBe(1);
    expect(modulo(14, 5)).toBe(4);
  });
});
