export function add(
  a: number,
  b: number,
  options?: { roundTo?: number }
): number {
  const sum = a + b;
  if (options?.roundTo != null) {
    const factor = Math.pow(10, options.roundTo);
    return Math.round(sum * factor) / factor;
  }
  return sum;
}
