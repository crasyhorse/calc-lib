import { modulo } from "@/modulo";
import { describe, it, expect } from "vitest";

describe("modulo (math semantics)", () => {
  it("handles positive numbers", () => {
    expect(modulo(10, 3)).toBe(1);
    expect(modulo(14, 5)).toBe(4);
  });

  it("normalizes negatives to a non-negative remainder", () => {
    // Mathematische Modulo-Definition: Ergebnis in [0, |b|)
    expect(modulo(-10, 3)).toBe(2);  // -10 ≡ 2 (mod 3)
    expect(modulo(10, -3)).toBe(1);  // 10 ≡ 1 (mod 3)
    expect(modulo(-10, -3)).toBe(2);
  });

  it("throws on zero divisor", () => {
    expect(() => modulo(5, 0)).toThrow(/modulo by zero/i);
  });
});
