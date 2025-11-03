export function multiply(a: number, b: number): number {
  const result = BigInt(a) * BigInt(b);
  return Number(result);
}
