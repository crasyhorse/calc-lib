# Übungsblatt: Git Pickaxe (Gruppe B)

Für die folgenden Übungen wird angenommen, dass sich der Benutzer im `main`-Branch befindet.

1. Füge in der Datei `src/add.ts` in Zeile 1 den Kommentar **This function adds two numbers** ein und speichere die Datei. Wie kann jetzt der Unterschied zwischen der geänderten Datei `src/add.ts` und der Staging Area bzw. dem Branch-HEAD des `main`-Branches angezeigt werden? Was genau ist der HEAD eines Branches? *Tipp:* Für die Beantwortung dieser Frage soll das Kommando `git diff` herangezogen werden?

<details><summary>Antwort</summary>
<code><pre>
  git diff -- src/add.ts
</pre></code>
Solange die Datei <code>src/add.ts</code> nicht gestaged wurde, entspricht die Staging Area dem aktuellen Branch-HEAD. <code>git diff</code> zeigt die Unterschiede zwischen Working Directory und der Staging Area.
</details>

2. Füge nun die Änderungen an der Datei `src/add.ts` der Staging Area hinzu. Nach dem du dies getan hast, füge jetzt in der Datei `src/add.ts` in Zeile 2 einen weiteren Kommentar ein und speichere die Datei: **This comment has a second line.** Wie kann der Unterschied zwischen der Staging Area und dem aktuellen Branch-HEAD des `main`-Branches angezeigt werden.

<details><summary>Antwort</summary>
<code><pre>
  git diff --staged -- src/add.ts
</pre></code>
Mit Hilfe von <code>--staged</code> oder <code>--cached</code> wird explizit der Inhalt der Staging Area mit dem aktuellen Branch-HEAD verglichen.
</details>

Anmerkung: Eine Grafik, welche `git diff` gut erläutert ist auf [Stackoverflow](https://stackoverflow.com/a/3293804) zu finden.

3. Wie kann der Unterschied zwischen 

    a. der Datei `src/add.ts` im Commit **C3 - feat: add multiply() and safe divide() with tests** und dem aktuellen Branch-HEAD des `main`-Branches angezeigt werden?

    b. der Datei `tests/divide.spec.ts` im Commit **C3 - feat: add multiply() and safe divide() with tests** zur Datei `tests/divide.spec.ts` im Commit **C7 - Revert "C5 - perf: optimize divide() by removing zero check"** angezeigt werden?

<details><summary>Antwort</summary>
<code><pre>
  git diff c3-mul-div -- src/add.ts
</pre></code>
<code><pre>
  git diff c3-mul-div..c7-bug-divide-fixed -- tests/divide.spec.ts
</pre></code>
Mit der Syntax <code>c3-mul-div..c7-bug-divide-fixed</code> wird der Unterschied zwischen allen Dateien des Commits/Tags <code>c3-mul-div</code> und des Commits/Tags <code>c7-bug-divide-fixed</code> angezeigt (d. h. was ist in <code>c7-bug-divide-fixed</code> enthalten, was in <code>c3-mul-div</code> nicht enthalten ist). Der Rest der Zeile <code>-- tests/divide.spec.ts</code> schränkt die Anzeige auf den Inhalt der Datei <code>tests/divide.spec.ts</code>.
</details>

4. In welchem Commit wurde die Datei `./src/add.ts` dem Repository hinzugefügt? Zeige den Commit als Oneliner an. *Tipp:* Google die Optionen `--diff-filter` und `--oneline`.

<details><summary>Antwort</summary>
<code><pre>
  git log --diff-filter=A --oneline -- src/add.ts
</pre></code>
</details>

5. Wie findest du den Commit, in dem der String `DEBUG start calc` erstmals in `src/cli.ts` eingefügt wurde, und zeigst den Diff/Patch dazu an? *Tipp:* Für die Beantwortung dieser Frage werden die Optionen `--reverse` und `-n 1` benötigt. Warum ist das so? Was passiert ohne diese Optionen?

<details><summary>Antwort</summary>
<code><pre>
  git log -S "DEBUG start calc" --reverse -n 1 -p -- src/cli.ts
</pre></code>
Ohne die Optionen <code>-n</code> und <code>reverse</code> zeigt <code>git log</code> die neuesten passenden Commits zuerst.&nbsp;<code>--reverse -n 1</code> kehrt die Reihenfolge um und zeigt den allerersten Treffer.
</details>

6. Füge in die Datei `src/cli.ts` den Kommentar **This is the main file** ein

    a. Führe das Kommando `git show :src/cli.ts` aus. Was zeigt es an?

    b. Füge den neuen Inhalt von `src/cli.ts` der Staging Area hinzu und führe `git show :src/cli.ts` erneut aus. Was zeigt es jetzt an?

<details><summary>Antwort</summary>
<code>git show :src/cli.ts</code> oder <code>git show :0:/src/cli.ts</code> zeigt die Datei <code>src/cli.ts</code> so an, wie sie im Index bzw. der Staging Area steht.
</details>
