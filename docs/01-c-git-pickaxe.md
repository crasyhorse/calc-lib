# Übungsblatt: Git Pickaxe (Gruppe C)

Für die folgenden Übungen wird angenommen, dass sich der Benutzer im `main`-Branch befindet.

1. Erkläre den Unterschied zwischen den drei folgenden Kommandos:

  a. `git grep -n "divide by zero"`

  b. `git grep -n --cached "divide by zero"`

  c. `git grep -n "divide by zero" 9ad92da5`

<details><summary>Antwort</summary>
Kommando a. zeigt Zeilennummer und Name einer jeden Datei an, in der der String <strong>divide by zero</strong> vorkommt. Es wird das Working Directory und die Staging Area (staged und unstraged Changes) durchsucht. Kommando b. zeigt ebenfalls Zeilennummern und Namen von Dateien an, in denen der String "divide by zero" vorkommt. Allerdings wird hier nur noch die Staging Area durchsucht (staged changes). Kommando c. zeigt das gleiche an, jedoch wird hier nur der Inhalt des Commits mit der Id <code>9ad92da5</code> durchsucht.
</details>

2. Finde alle Commits, deren Message das Wort **divide** enthält (case-insensivite) un in denen `src/divide.ts` verändert wurde. *Tipp:* Hier kommt `git log` mit der Option `--grep` zum Einsatz.

<details><summary>Antwort</summary>
<code><pre>
  git log --grep="divide" -i -- src/divide.ts
</pre></code>
</details>

3. Wie findest du den Commit, in dem der String `DEBUG start calc` erstmals in `src/cli.ts` eingefügt wurde, und zeigst den Diff/Patch dazu an? *Tipp:* Für die Beantwortung dieser Frage werden die Optionen `--reverse` und `-n 1` benötigt. Warum ist das so? Was passiert ohne diese Optionen?

<details><summary>Antwort</summary>
<code><pre>
  git log -S "DEBUG start calc" --reverse -p -- src/cli.ts
</pre></code>
Ohne die Optionen <code>-n</code> und <code>reverse</code> zeigt <code>git log</code> die neuesten passenden Commits zuerst.&nbsp;<code>--reverse -n 1</code> kehrt die Reihenfolge um und zeigt den allerersten Treffer.
</details>

4. In welchem Commit wurde die Datei `./src/add.ts` dem Repository hinzugefügt? Zeige den Commit als Oneliner an. *Tipp:* Google die Optionen `--diff-filter` und `--oneline`.

<details><summary>Antwort</summary>
<code><pre>
  git log --diff-filter=A --oneline -- src/add.ts
</pre></code>
</details>

5. Wechsle in den Branch `main`. Zeige nun die letzten beiden Commits des Autors *JohnDoe*, die `src/divide.ts` verändert haben, als Oneliner. *Tipp:* Google nach einer Option, die nach dem Autor filtern kann. Wie verändert sich die Antwort, wenn die Option `--source` hinzugefügt wird?

<details><summary>Antwort</summary>
<code><pre>
  git switch main
  git log --author="JohnDoe" --oneline -n 2 -- src/divide.ts
  git log --author="JohnDoe" --oneline --source -n 2 -- src/divide.ts
</pre></code>
Durch die Option <code>--source</code> wird vor jedem Commit die Ref (Tag/Branch) angezeigt, wo der Commit gefunden wurde.
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
