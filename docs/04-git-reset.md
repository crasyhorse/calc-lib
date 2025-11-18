# Übungsblatt: Reset Commits

1. Wechsle in den `main` Branch. Die Commit Message von **D6 - doc: Add scripts for exercises** soll in **D6 - doc: Add scripts** geändert werden.

<details><summary>Antwort</summary>
<code><pre>
  git switch main
  git reset --soft HEAD~1
  git commit -m "D6 - doc: Add scripts"
</pre></code>
Alternativ könnte diese Aufgabe auch mit <code>git commit --amend -m "D6 - doc: Add scripts"</code> durchgeführt werden.
</details>

2. Bearbeite folgendes Szenario:

    a. Finde mit Hilfe von `git branch` heraus, zu welchem Branch das Commit mit der ID 847d6e9 gehört. Wechsle anschließend in diesen Branch.

    b. Lasse dir die Metadaten (Commit Message, Author, ...), ohne Diff bzw. ohne **Patch**, zu dem Commit mit der ID 847d6e9 anzeigen. *Tipp:* Hier hilft `git show`.

    c. Benutze `get reset` um die Änderungen der beiden Commits **M4 - fix: implement mathematical modulo (normalize negatives, throw on zero) and export** und **M3 - test: cover modulo negatives normalization and zero divisor** neu zu verteilen. Die beiden Dateien `src/modulo.ts` und `tests/modulo.spec.ts` sollen in ein neues Commit **M3 - fix: implement mathematical modulo (normalize negatives, throw on zero) and export** geschrieben werden. Die restlichen Änderung soll in ein neues Commit **M4 - Add modulo operation to the library** geschrieben werden.

<details><summary>Antwort</summary>
<code><pre>
  git branch --contains 847d6e9
  git switch feature/modulo
  git show 847d6e9 --no-patch
  git reset --mixed 847d6e9
  git add src/modulo.ts tests/modulo.spec.ts
  git commit -m "M3 - test: cover modulo negatives normalization and zero divisor"
  git add src/cli.ts src/divide.ts
  git commit -m "M4 - Add modulo operation to the library"
</pre></code>
<p>
Der Parameter <code>--contains</code> des Kommandos <code>git branch</code> ist dazu da, um zu prüfen, zu welchem Branch ein Commit gehört. Ein Commit kann prinzipiell zu mehreren Branches gehören.
</p>
<p>
Hier wird die Option <code>--mixed</code> (Standard) für <code>git reset</code> gewählt, da so die Änderungen aus der Commit History und aus dem Index verworfen werden. Die geänderten Dateien selbst bleiben aber im Working Directory enthalten und können nach und nach per <code>git add</code> und <code>git commit</code> neu verarbeitet werden.
</p>
</details>

3. Im Branch `feature/rounding-option` sollen die beiden Commits **F2 - fix: correct rounding logic and add rounding test** und **F3 - docs: document add() rounding option with examples** zu einem neuen Commit **F2 - fix: correct roundig logic, add test and docs** zusammengefasst werden.

<details><summary>Antwort</summary>
<code><pre>
  git switch feature/rounding-option
  git rev-parse --short ":/F1"
  git reset --soft 9db134f
  git commit -m "F2 - fix: correct roundig logic, add test and docs"
</pre></code>
</details>