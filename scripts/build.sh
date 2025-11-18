#!/bin/bash

rm -rf /workspaces/new-repo
mkdir -p /workspaces/new-repo
cd /workspaces/new-repo

git init -q
git config user.name "Git Workshop"
git config user.email "gitworkshop@example.com"
git branch -m main

cat <<EOF > .gitignore
node_modules
EOF

cat <<EOF > package.json
{
  "name": "calc-lib",
  "version": "1.0.0",
  "description": "Eine kleine TypeScript-Library, welche die vier Grundrechenarten abbildet.",
  "keywords": [
    "git",
    "workshop",
    "advanced"
  ],
  "homepage": "https://github.com/crasyhorse/calc-lib#readme",
  "bugs": {
    "url": "https://github.com/crasyhorse/calc-lib/issues"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/crasyhorse/calc-lib.git"
  },
  "license": "ISC",
  "author": "Florian Weidinger",
  "type": "module",
  "main": "main.ts",
  "scripts": {
    "demo": "tsx ./src/cli.ts",
    "test": "vitest"
  },
  "devDependencies": {
    "@tsconfig/node22": "^22.0.2",
    "@types/node": "^22.18.13",
    "tsx": "^4.20.6",
    "typescript": "^5.9.3",
    "vite": "^7.1.12",
    "vitest": "^4.0.5"
  }
}
EOF

cat <<EOF > README.md
# Calc-Lib

Ein einfache JavaScript-Bibliothek, welche die vier Grundrechenarten abbildet.

## Build
npm run build

## Test
npm test
EOF

cat <<EOF > tsconfig.app.json
{
  "compilerOptions": {
    "tsBuildInfoFile": "./node_modules/.tmp/tsconfig.app.tsbuildinfo",
    "target": "ES2023",
    "useDefineForClassFields": true,
    "lib": [
      "ES2023",
      "DOM",
      "DOM.Iterable"
    ],
    "module": "ESNext",
    "types": [
      "vite/client"
    ],
    "skipLibCheck": true,
    "baseUrl": ".",
    "paths": {
      "@/*": [
        "./src/*"
      ]
    },
    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "verbatimModuleSyntax": true,
    "moduleDetection": "force",
    "noEmit": true,
    "jsx": "react-jsx",
    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "erasableSyntaxOnly": false,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedSideEffectImports": true,
  },
  "include": [
    "src",
    "tests"
  ]
}
EOF

cat <<EOF > tsconfig.json 
{
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ]
}
EOF

cat <<EOF > tsconfig.node.json
{
  "compilerOptions": {
    "tsBuildInfoFile": "./node_modules/.tmp/tsconfig.node.tsbuildinfo",
    "target": "ES2023",
    "lib": ["ES2023"],
    "module": "ESNext",
    "types": ["node"],
    "skipLibCheck": true,
    "baseUrl": ".",
    "paths": {
      "@/*": [
        "./src/*"
      ]
    },

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "verbatimModuleSyntax": true,
    "moduleDetection": "force",
    "noEmit": true,

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "erasableSyntaxOnly": true,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedSideEffectImports": true
  },
  "include": ["vitest.config.ts"]
}
EOF

cat <<EOF > vite.config.ts
import { defineConfig } from "vite";
import { fileURLToPath } from "node:url";

export default defineConfig({
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
});
EOF

cat <<EOF > vitest.config.ts
import { defineConfig, mergeConfig } from "vitest/config";
import viteConfig from "./vite.config.ts";

export default mergeConfig(
  viteConfig,
  defineConfig({
    test: {
      include: ["./tests/**"]
    },
  })
);
EOF

git add .
git commit -m "C1 - The dawning of a repo :-)"

mkdir src tests

cat <<EOF > src/add.ts
export function add(a: number, b: number): number {
  return a + b;
}

EOF

cat <<EOF > src/subtract.ts
export function subtract(a: number, b: number): number {
  return a - b;
}

EOF

cat <<EOF > src/main.ts
export { add } from "@/add";
export { subtract } from "@/subtract";
EOF

cat <<EOF > tests/add.spec.ts
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
EOF

cat <<EOF > tests/subtract.spec.ts
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
EOF

git add .
git commit -m "C2 - feat: add add() and subtract() with tests"

cat <<EOF > src/divide.ts
export function divide(a: number, b: number): number {
  if (b === 0) {
    throw new Error("divide by zero");
  }
  return a / b;
}

EOF

cat <<EOF > src/multiply.ts
export function multiply(a: number, b: number): number {
  return a * b;
}

EOF

cat <<EOF > tests/divide.spec.ts
import { divide } from "@/divide";
import { describe, it, expect } from "vitest";

describe("divide", () => {
  it("divides numbers", () => {
    expect(divide(8, 4)).toBe(2);
  });
});
EOF

cat <<EOF > tests/multiply.spec.ts
import { multiply } from "@/multiply";
import { describe, it, expect } from "vitest";

describe("multiply", () => {
  it("multiplies numbers", () => {
    expect(multiply(4, 6)).toBe(24);
  });
});
EOF

tmp=$(mktemp)
file="./src/main.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
export { add } from "@/add";
export { subtract } from "@/subtract";
export { multiply } from "@/multiply";
export { divide } from "@/divide";

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m "C3 - feat: add multiply() and safe divide() with tests"
git tag c3-mul-div

cat <<EOF > src/cli.ts
import { add, subtract, multiply, divide } from "@/main";

console.log("DEBUG start calc");

console.log("2 + 3 =", add(2, 3));
console.log("5 - 2 =", subtract(5, 2));
console.log("4 * 6 =", multiply(4, 6));
console.log("8 / 4 =", divide(8, 4));

EOF

tmp=$(mktemp)
file="./README.md"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
# Calc-Lib

Ein einfache JavaScript-Bibliothek, welche die vier Grundrechenarten abbildet.

## Funktionen
- add(a, b)
- subtract(a, b)
- multiply(a, b)
- divide(a, b) // wirft Error bei Division durch 0

## Build
npm run build

## Test
npm test

## Demo
npm run demo
EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m "C4 - chore: add CLI demo with debug logging"
git tag c4-cli-debug

tmp=$(mktemp)
file="./src/divide.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
export function divide(a: number, b: number): number {
  // TODO: assume caller validated denominator (performance improvement)
  return a / b;
}

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m "C5 - perf: optimize divide() by removing zero check"

tmp=$(mktemp)
file="./tests/divide.spec.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
import { divide } from "@/divide";
import { describe, it, expect } from "vitest";

describe("divide", () => {
  it("divides numbers", () => {
    expect(divide(8, 4)).toBe(2);
  });

  it("throws on divide by zero", () => {
    expect(() => divide(4, 0)).toThrowError(/divide by zero/i);
  });
});
EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m "C6 - test: add safety test for divide() zero denominator"

tmp=$(mktemp)
file="./src/divide.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
export function divide(a: number, b: number): number {
  if (b === 0) {
    throw new Error("divide by zero");
  }
  return a / b;
}

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m 'C7 - Revert "C5 - perf: optimize divide() by removing zero check"'

tmp=$(mktemp)
file="./src/cli.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
import { add, subtract, multiply, divide } from "@/main";

console.log("Calculator demo start");

console.log("2 + 3 =", add(2, 3));
console.log("5 - 2 =", subtract(5, 2));
console.log("4 * 6 =", multiply(4, 6));
console.log("8 / 4 =", divide(8, 4));

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m "C8 - chore: remove debug logging from CLI"

git switch -c feature/rounding-option c3-mul-div

tmp=$(mktemp)
file="./src/add.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
export function add(
  a: number,
  b: number,
  options?: { roundTo?: number }
): number {
  const sum = a + b;
  if (options?.roundTo != null) {
    const factor = Math.pow(10, options.roundTo);
    // buggy: floor statt "richtig" runden
    return Math.floor(sum * factor) / factor;
  }
  return sum;
}

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m "F1 - feat: add optional rounding to add() via { roundTo }"

tmp=$(mktemp)
file="./src/add.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
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

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

tmp=$(mktemp)
file="./tests/add.spec.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
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

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m "F2 - fix: correct rounding logic and add rounding test"
git tag f2-fix-round

tmp=$(mktemp)
file="./README.md"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
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

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m "F3 - docs: document add() rounding option with examples"

git switch -c experiment/precision f2-fix-round

tmp=$(mktemp)
file="./src/multiply.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
export function multiply(a: number, b: number): number {
  const result = BigInt(a) * BigInt(b);
  return Number(result);
}

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m "P1 - experiment: use BigInt in multiply() for integer precision"

git switch -c feature/modulo c4-cli-debug

cat <<EOF > ./tests/modulo.spec.ts
import { modulo } from "@/modulo";
import { describe, it, expect } from "vitest";

describe("modulo (math semantics)", () => {
  it("handles positive numbers", () => {
    expect(modulo(10, 3)).toBe(1);
    expect(modulo(14, 5)).toBe(4);
  });
});

EOF

git add .
git commit -m "M1 - test: add basic modulo tests (positive numbers)"

cat <<EOF > ./src/modulo.ts
export function modulo(a: number, b: number): number {
  return a % b as number;
}

EOF

git add .
git commit -m "M2 - WIP: implement modulo() naively (no zero/negative handling yet)"

tmp=$(mktemp)
file="./tests/modulo.spec.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
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

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m "M3 - test: cover modulo negatives normalization and zero divisor"

tmp=$(mktemp)
file="./src/main.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
export { add } from "@/add";
export { subtract } from "@/subtract";
export { multiply } from "@/multiply";
export { divide } from "@/divide";
export { modulo } from "@/modulo";

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

tmp=$(mktemp)
file="./src/modulo.ts"
trap 'rm -rf "$tmp"' EXIT
cat <<EOF > "$tmp"
export function modulo(a: number, b: number): number {
  if (b === 0) {
    throw new Error("modulo by zero");
  }
  const m = Math.abs(b);
  
  const r = a % m;
  return (r + m) % m;
}

EOF

diff -u --label "$file" --label "$file" -- "$file" "$tmp" | patch -p0 -N -r -

git add .
git commit -m "M4 - fix: implement mathematical modulo (normalize negatives, throw on zero) and export"

git tag -d c3-mul-div
git tag -d c4-cli-debug
git tag -d f2-fix-round
