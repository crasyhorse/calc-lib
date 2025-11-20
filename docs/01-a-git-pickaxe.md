# Übungsblatt: Git Pickaxe (Gruppe A)

1. Wie findest du den Commit, in dem der String `DEBUG start calc` erstmals in `src/cli.ts` eingefügt wurde, und zeigst den Diff/Patch dazu an? *Tipp:* Für die Beantwortung dieser Frage werden die Optionen `--reverse` und `-n 1` benötigt. Warum ist das so? Was passiert ohne diese Optionen?

<details><summary>Antwort</summary>
<code><pre>
  git log -S "DEBUG start calc" --reverse -p -- src/cli.ts
</pre></code>
Ohne die Optionen <code>-n</code> und <code>reverse</code> zeigt <code>git log</code> die neuesten passenden Commits zuerst.&nbsp;<code>--reverse -n 1</code> kehrt die Reihenfolge um und zeigt den allerersten Treffer.
</details>

2. In welchem Commit wurde die Datei `./src/divide.ts` dem Repository hinzugefügt? Zeige den Commit als Oneliner an. *Tipp:* Google die Optionen `--diff-filter` und `--oneline`.

<details><summary>Antwort</summary>
<code><pre>
  git log --diff-filter=A --oneline -- src/divide.ts
</pre></code>
</details>

3. Wechsle in den Branch `main`. Zeige nun die letzten beiden Commits des Autors *JohnDoe*, die `src/divide.ts` verändert haben, als Oneliner. *Tipp:* Google nach einer Option, die nach dem Autor filtern kann. Wie verändert sich die Antwort, wenn die Option `--source` hinzugefügt wird?

<details><summary>Antwort</summary>
<code><pre>
  git switch main
  git log --author="JohnDoe" --oneline -n 2 -- src/divide.ts
  git log --author="JohnDoe" --oneline --source -n 2 -- src/divide.ts
</pre></code>
Durch die Option <code>--source</code> wird vor jedem Commit die Ref (Tag/Branch) angezeigt, wo der Commit gefunden wurde.
</details>

4. Worin unterscheiden sich die beiden Kommandos?

   a. `git show c5-bug-divide-introduced:src/divide.ts`

   b. `git show c5-bug-divide-introduced -- src/divide.ts`

<details><summary>Antwort</summary>
Kommando a. zeigt den Inhalt der Datei <code>src/divide.ts</code> aus dem angegebenen Commit/Tag an.
<code><pre>
  git show c5-bug-divide-introduced:src/divide.ts
</pre></code>
Mit Kommando b. wird das komplette Commit mit all seinen Metadaten angezeigt.
<code><pre>
  git show c5-bug-divide-introduced -- src/divide.ts
</pre></code>
</details>

5. Suche nach Commits, in deren Message die Zeichenfolge `cli demo` vorkommt. Gestalte die Suche case-insensitive. *Tipp:* Google die Option `--grep` und frage Google außerdem nach einer Option für eine case-insensitive Suche.

<details><summary>Antwort</summary>
<code><pre>
  git log --all --grep="cli demo" -i --oneline
</pre></code>
</details>

6. Worin besteht der Unterschied bei den drei folgenden Kommandos?

   a. `git log --oneline main feature/rounding-option`

   b. `git log --oneline main..feature/rounding-option`

   c. `git log --oneline main...feature/rounding-option`

<details><summary>Antwort</summary>
Kommando a. zeigt die Vereinigung beider branches an, d. h. den Kompletten weg von <strong>C1</strong> bis <strong>F3</strong>.
<code><pre>
  git log --oneline main feature/rounding-option
</pre></code>
Kommando b. zeigt alle Commits an, die sich in <code>feature/rounding-option</code> befinden, nicht aber in <code>main</code>.
<code><pre>
  git log --oneline main..feature/rounding-option
</pre></code>
Kommando c. zeigt die symmetrische Differenz der beiden branches <code>main</code> und <code>feature/rounding-option</code> an. D. h. es werden die Commits angezeigt, die sich nur in einem der beiden branches befinden angezeigt (<strong>C4</strong> bis <strong>C8</strong>, weil diese sich nur in <code>main</code> nicht aber in <code>feature/rounding-option</code> befinden und <strong>F1</strong> bis <strong>F3</strong>, wie diese sich nur in <code>feature/rounding-option</code> aber nicht in <code>main</code> befinden.)
<code><pre>
  git log --oneline main...feature/rounding-option
</pre></code>
</details>