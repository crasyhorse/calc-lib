export function modulo(a: number, b: number): number {
  if (b === 0) {
    throw new Error("modulo by zero");
  }
  const m = Math.abs(b);
  
  const r = a % m;
  return (r + m) % m;
}
