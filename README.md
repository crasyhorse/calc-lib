# Calc-Lib

Ein einfache JavaScript-Bibliothek, welche die vier Grundrechenarten abbildet.

## Funktionen
- `add(a, b, { roundTo })`
  - Beispiel: `add(0.1, 0.2, { roundTo: 2 }) // => 0.3`
- `subtract(a, b)`
- `multiply(a, b)`
- `divide(a, b)` (wirft Error bei Division durch 0)

## Tests
npm test