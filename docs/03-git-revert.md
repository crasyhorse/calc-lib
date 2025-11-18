# Übungsblatt: Revert commits

1. Wechsle in den Branch `feature/modulo` und mache dort das aktuellste Commit **M4 - fix: implement mathematical modulo (normalize negatives, throw on zero) and export** rückgängig.

<details><summary>Antwort</summary>
<code><pre>
  git switch feature/modulo
  git revert HEAD
</pre></code>
</details>

2. Wechsle in den `main`-Branch und erzeuge ein Revert-Commit für **C6 - test: add safety test for divide() zero denominator**.

    a. Versuche mit Hilfe von `git log --pretty=format` die Commit-Id von **C6 - test: add safety test for divide() zero denominator** auszugeben. Die Ausgabe soll in etwa so aussehen:

    ```
    bd845cb
    ```

    b. Was macht das folgende Kommando: `git rev-parse --short ":/C6"`?

    c. Das Kommando `git rev-parse` wird als **plumbin command** bezeichnet. Was versteht Git unter **plumbing commands** bzw. unter **porcelain commands**? 

<details><summary>Antwort</summary>
<code><pre>
  git switch main
  git log --all --grep="C6" --pretty=format:"%h"
  git revert bd845cb
</pre></code>
<p>
Mit Hilfe von <code>git rev-parse</code> kann man die ID zu einer Referenz (Branch, Tag, Commit, ...) ausgeben. Mit der Option <code>--short</code> werden nur die ersten 7 Stellen der ID ausgegeben. Der String <strong>":/C6"</strong> stellt eine RegEx dar und Hilfe dabei das Commit zu identifizieren, dessen ID hier gebraucht wird.
</p>
<p>
Git unterscheidet zwischen <strong>Porcelain Commands</strong> und <strong>Plumbing Commands</strong>. Unter <strong>Plumbing Commands</strong> versteht Git Kommandos, mit deren Hilfe das Repository manipuliert wird. Diese Kommands sind meist kompliziert und wenig benutzerfreundlich. Als Ergänzung zu den <strong>Plumbing Commands</strong> wurden sehr bald schon die <strong>Porcelain Commands</strong> eingeführt (erste Erwähnungen von in Version 0.99), welche eine vereinfachte Bedienung für die Nutzer von Git erlauben. 
</p>
</details>

3. Bearbeite folgendes Szenario:

    a. Mache die Änderungen aus Aufgabe Nummer 2 rückgängig mit `git reset --hard HEAD~1`.

    b. Erstelle Revert-Commits für die beiden Commits **C7 - Revert "C5 - perf: optimize divide() by removing zero check"** und **C6 - test: add safety test for divide() zero denominator**.

    c. Mach die Änderungen von b. rückgängig mit `git reset --hard HEAD~2`. Erstelle jetzt *genau ein* Revert-Commit für die beiden Commits **C7 - Revert "C5 - perf: optimize divide() by removing zero check"** und **C6 - test: add safety test for divide() zero denominator**. *Tipp:* `git revert` kennt den Parameter `--no-commit`. Prüfe ob bzw. wie dir dieser Parameter helfen kann.
    
<details><summary>Antwort</summary>
<code><pre>
  git reset --hard HEAD~1
  git log --all --grep="C6" --pretty=format:"%h"
  git log --all --grep="C7" --pretty=format:"%h"
  git revert bd845cb
  git revert 34169e9
  git reset --hard HEAD~2
  git revert --no-commit bd845cb
  git revert --no-commit 34169e9
  git commit -m "Reverted commits C6 and C7"
</pre></code>
Der Parameter <code>--no-commit</code> verhindert, dass ein Kommando wie z. B. <code>git revert</code> die durchgeführten Änderungen committed. Somit können mehrere Operation hintereinander durchgeführt und dann manuell in einem Commit zusammengefasst werden.
</details>

4. Bearbeite folgendes Szenario: 

    a. Mache die Änderung aus Aufgabe 3 rückgängig (`git reset --hard HEAD~1`). 

    b. Wechsle in den Branch `feature/rounding-option`.

    c. Mache die Änderungen aus dem Commit **F2 - fix: correct rounding logic and add rounding test** teilweise rückgängig. D. h. der Test in der Datei `tests/add.spec.ts` soll bestehen bleiben, während in der Datei `src/add.ts` von `Math.round` auf `Math.floor` gewechselt werden soll. Diese Änderungen sollen in einem einzigen Commit zusammengefasst werden.

<details><summary>Antwort</summary>
<code><pre>
  git reset --hard HEAD~1
  git switch feature/rounding-option
  git log --all --grep="F2" --pretty=format:"%h"
  git revert --no-commit a9759e0
  git restore --staged --worktree src/add.ts
  git commit -m "Revert from Math.round to Math.floor"
</pre></code>
</details>

5. Bearbeite folgendes Szenario: 

    a. Mache die Änderung aus Aufgabe 4 rückgängig (`git reset --hard HEAD~1`). 

    b. Falls noch nicht geschehen, wechsle in den Branch `feature/rounding-option`.

    c. Erstelle ein Revert-Commit von **F1 - feat: add optional rounding to add() via { roundTo }**. Es entsteht ein Revert-Konflikt.

    d. Lasse dir die Änderung, die im Konflikt zueinander stehen, anzeigen.

    e. Führe die drei folgenden `git show` Kommandos aus. Was siehst du?

        git show :1:src/add.ts

        git show :2:src/add.ts

        git show :3:src/add.ts

    f. Nutze `git restore` um die **Incoming changes** zu akzeptieren. *Tipp:* Prüfe, was die Parameter `--ours` und `--theirs` bei `git restore` bedeuten.

    g. Prüfe den Status deines Working Directories bzw. deiner Staging Area.

    h. Führe das Staging der Änderungen in `src/add.ts` durch.

    i. Führe das `git revert` Kommando fort.

    j. Mache die gerade durchgeführten Änderungen wieder rückgängig mit `git reset --hard HEAD~1`

<details><summary>Antwort</summary>
<code><pre>
  git reset --hard HEAD~1
  git switch feature/rounding-option
  git log --all --grep="F1" --pretty=format:"%h"
  git revert --no-commit 9db134f
  git diff --name-only --diff-filter=U --relative
  git diff
  git show :1:src/add.ts
  git show :2:src/add.ts
  git show :3:src/add.ts 
  git restore --theirs src/add.ts
  git status
  git add src/add.ts
  git revert --continue
  git reset --hard HEAD~1
</pre></code>
<p>
<code>git show :1:src/cli.ts</code> und die beiden weiteren Kommandos sind Spezialfälle, die nur im Falles eines Konflikts zum Tragen kommen. <code>git show :1:src/cli.ts</code> zeigt die Basisversion der Datei an. <code>git show :2:src/cli.ts</code> zeigt die lokal vorliegende Version an (ours) und <code>git show :3:src/cli.ts</code> zeigt die neue Version (theirs) an.
</p>
<p>
Mit Hilfe der Parameter <code>--ours</code> und <code>--theirs</code> kann <code>git restore</code> im Falle eines Merge/Revert/Rebase-Konflikts eine der beiden konkurierenden Änderungen übernehmen. Mit <code>git restore --ours</code> werden die <strong>Current Changes</strong> übernommen. <strong>git restore --theirs</strong> hingegen übernimmt die <strong>Incoming changes</strong>. Die gewählten Änderungen müssen dann noch mit <code>git add</code> in den Index übernommen werden.
</p>
</details>