# Übungsblatt: Restore files

1. Füge der Datei `src/multiply.ts` in Zeile 1 den Kommentar **This function multiplies two numbers** hinzu und speichere die Datei. Mache diese Änderung mit Hilfe von Git rückgängig (der Kommentar soll wieder verschwinden).

<details><summary>Antwort</summary>
<code><pre>
  git restore src/multiply.ts
</pre></code>
Dieses Kommando setzt den Inhalt der Datei <code>multiply.ts</code> auf den Inhalt des Index / der Staging Area zurück. Dies funktioniert also nur, wenn <code>multiply.ts</code> bereits im Repository enthalten ist (mind. einmal committed wurde).
</details>

2. Prüfe, ob die Datei `src/add.ts` noch immer die beiden unten angezeigten Kommentarzeilen enthält und ob diese Änderungen gestaged wurden. Falls nicht, benutze `git add src/add.ts` um die Änderungen in den Index zu übernehmen. Wie kann das Staging der Änderungen wieder rückgängig gemacht werden?

```javscript
// This function adds two numbers
// This comment has a second line.
```

<details><summary>Antwort</summary>
<code><pre>
  git restore --staged src/add.ts
</pre></code>
</details>

3. Führe erneut `git add src/add.ts` aus. Was passiert, wenn du jetzt das Kommando `git restore --staged --worktree src/add.ts` ausführst?

<details><summary>Antwort</summary>
<code><pre>
  git restore --staged --worktree src/add.ts
</pre></code>
Der Parameter <code>--staged</code> entfernt die Änderungen aus dem Index und <code>--worktree</code> bereinigt das Working Directory. D. h. die Kommentare werden aus <code>src/add.ts</code> entfernt.
</details>

4. Hole den Inhalt der Datei `src/multiply.ts` aus dem Branch `experiment/precision` in den Branch `main`. *Tipp:* Benutze Google um nach dem Parameter `--source` zu suchen.

<details><summary>Antwort</summary>
<code><pre>
  git restore --source=experiment/precision --worktree src/multiply.ts
</pre></code>
Der Parameter <code>--source</code> gibt ein Commit, einen Tag oder auch einen Branch als Quelle an.
</details>

5. Welche Referenzen (z. B. Branches, Tags, ...) können dazu benutzt werden, um den Inhalt der Datei `multiply.ts` wieder auf den im Branch `main` gespeicherten Zustand zurück zusetzen (die Aktion aus Aufgabe 4. rückgängig zu machen).

<details><summary>Antwort</summary>
<code><pre>
  git restore --source=main --worktree src/multiply.ts
  git restore --source=HEAD --worktree src/multiply.ts
  git restore --source=c8-cli-clean --worktree src/multiply.ts
  git restore --source=0131da1d --worktree src/multiply.ts
</pre></code>
Die Referenz <code>HEAD</code> funktioniert nur, wenn sich der Benutzer aktuell im Branch <code>main</code> befindet.
</details>

6. Führe erneut das Kommando `git restore --source=experiment/precision --worktree src/multiply.ts`. Was passiert, wenn du jetzt `git restore --source=main --worktree -p src/multiply.ts` ausführst?

<details><summary>Antwort</summary>
Der Parameter <code>-p</code> bewirkt, dass <code>git restore</code> interaktiv abläuft, d. h. der Benutzer kann einzelne Änderungen rückgängig machen, während er andere bestehen lässt.
</details>