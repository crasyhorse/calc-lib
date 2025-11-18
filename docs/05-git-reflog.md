# Übungsblatt: Benutzung des Reflog

1. Führe das Skript `scripts/fix-readme.sh` aus, so wie unten abgebildet. Am Ende des Skripts wird angezeigt, welches Problem vorliegt. *Tipp:* Wurde ein Branch gelöscht, muss für dessen Wiederherstellung ein neuer Branch ausgehend vom gleichen Commit angelegt werden.

    ```bash
    cd scripts
    chmod 755 fix-readme.sh
    ./fix-readme.sh
    ```

<details><summary>Antwort</summary>
<code><pre>
  git switch main
  git reflog
  git branch bugfix/readme 58499c5
  git switch bugfix/readme
</pre></code>
Um den Branch bugfix/readme wiederherstellen zu können, muss im Reflog nach einem Eintrag gesucht werden, der die Beschreibung <strong>commit: B1 - fix: Typo in readme</strong> hat. Dessen Id verweist auf das Commit, in welchem der Inhalt der Datei <code>READEME.md</code> geändert wurde.
</details>

2. Führe das Skript `scripts/rebase-modulo.sh` aus, so wie unten abgebildet. Am Ende des Skripts wird angezeigt, welches Problem vorliegt. Recherchiere, welche Bedeutung der Pointer `ORIG_HEAD` in Bezug auf `HEAD` hat. *Tipp:* Möchte man ein `git rebase` rückgängig machen, muss man die Id des Commits herausfinden, auf welches der Pointer <code>HEAD</code> unmitellbar vor der Rebase-Operation gezeigt hat.

    ```bash
    cd scripts
    chmod 755 rebase-modulo.sh
    ./rebase-modulo.sh
    ```

<details><summary>Antwort</summary>
<code><pre>
  git switch feature/modulo
  git reflog --date=iso -n 1 --grep-reflog 'rebase (start)'
  git reset --hard 406c19d
  git merge-base --is-ancestor 406c19d feature/modulo && echo "OK: 406c19d ist wieder die Branch-Basis"
</pre></code>

<code><pre>
  git switch feature/modulo
  git reset --hard ORIG_HEAD
  git merge-base --is-ancestor 406c19d feature/modulo && echo "OK: 406c19d ist wieder die Branch-Basis"
</pre></code>
<p>
Hier werden zwei verschiedene Lösungsmöglichkeiten gezeigt. In der ersten Antwort wird mit Hilfe des Reflog die Id des Commits gesucht, welche den Startpunkt der Rebase-Operation markiert. Ausgehend von dieser Id kann nun ein Commit gesucht werden, welches zum Zurücksetzen des Branches genutzt werden kann. Im obigen Beispiel ist dies <code>406c19d</code>.
</p>
<p>
Der Parameter <code>--grep-reflog</code> durchsucht die Beschreibungsspalte des Reflog. Mit <code>--grep</code> hingegen, können die Commit-Messages der Reflog-Einträge durchsucht werden.
</p>
<p>
In der zweiten Lösung wird davon ausgegangen, dass das <code>git merge</code> die letzte Operation gewesen ist, d. h. seit dem Merge wurde nicht weitergearbeitet. In diesem Fall kann der Pointer <code>ORIG_HEAD</code> zur Hilfe genommen werden. Er zeigt auf das Commit, auf welches <code>HEAD</code> vor dem <code>git merge</code> gezeigt hat. Möchte man wissen, auf welches Commit der Pointer <code>ORIG_HEAD</code> zeigt, kann man dies mit <code>git show --format="%h %s" ORIG_HEAD</code> erfahren.
</p>
</details>

3. Führe das Skript `scripts/break-modulo.sh` aus, so wie unten abgebildet. Am Ende des Skripts wird angezeigt, welches Problem vorliegt.

    ```bash
    cd scripts
    chmod 755 break-modulo.sh
    ./break-modulo.sh
    ```

<details><summary>Antwort</summary>
<code><pre>
  git switch feature/modulo
  git reflog --grep-reflog "reset: moving"
  git reset --hard 406c19d
</pre></code>
Um dieses Problem zu lösen, muss im Reflog nach einem Eintrag mit der Beschreibung <strong>reset: moving to HEAD~2</strong> gesucht werden. Dies ist der Eintrag, der Dokumentiert, dass der <code>HEAD</code>-Pointer des Branches um zwei Commits, von M4 nach M2, versetzt wurde. Im obigen Beispiel ist dies <code>35a1cd4</code>. Ausgehend von dieser Id kann nun ein Commit gesucht werden, welches zum Zurücksetzen des Branches genutzt werden kann. Im obigen Beispiel ist dies <code>406c19d</code>. Das könnte z. B. ein Eintrag mit der Beschreibung <strong>checkout: moving from main to feature/modulo</strong> sein. Das <code>git reset --hard</code> setzt den <code>HEAD</code>-Pointer wieder zurück auf das Commit M4.
</details>

4. Führe das Skript `scripts/merge-rounding-option.sh` aus, so wie unten abgebildet. Am Ende des Skripts wird angezeigt, welches Problem vorliegt.

  a. Suche eine Lösung für den Fall, dass das Merge nur lokal vorliegt

  b. Suche nun eine Lösung für den Fall, dass der Branch `main` nach dem `git merge` bereits gepushed wurde.

    ```bash
    cd scripts
    chmod 755 merge-rounding-option.sh
    ./merge-rounding-option.sh
    ```

<details><summary>Antwort</summary>
<code><pre>
  git switch main
  git log --oneline --merges -n 1
  git show --no-patch --format="%h %s" f62658e^1
  git reset --merge 3badfab
</pre></code>

<code><pre>
  git switch main
  git log --oneline --merges -n 1
  git revert -m 1 f62658e
</pre></code>
<p>
In der ersten Lösung wird <code>git log</code> mit dem Parameter <code>--merges</code> genutzt, um nur Einträge anzuzeigen, die sich auf ein <code>git merge</code> beziehen. Mit <code>git show --format="%h %s" f62658e^1</code> werden dann Hash und Commit-Message des Commits angezeigt, welches eine Position weiter zurück im Log steht. Dessen Id wurde nun für das Zurücksetzen des Branchs genutzt. Alternativ könnte auch die Angabe <code>f62658e^1</code> genutzt werden. Der Parameter <code>--merge</code> des Kommandos <code>git reset</code> sorgt dafür, dass Dateien, welche geändert aber noch nicht committed wurden (Unterschiede zwischen Working Directory und Staging Area), nicht zurückgesetzt werden bzw. das deren Änderungen beibehalten werden. Mit <code>git reset --hard</code> wurde das gesamt Working Directory zurückgesetzt werden.
</p>
<p>
Die zweite Lösung benutzt das Kommando <code>git revert</code>, um ein neues Commit zu erzeugen, welches die Änderungen, die durch das <code>git merge</code> enstanden sind, rückgängig zu machen. Mit Hilfe der Angabe <code>-m 1 f62658e</code> wird auf das Parent Commit (ours) von <code>f62658e</code> verweisen. Dies ist das Commit, auf das der <code>HEAD</code>-Pointer im <code>main</code>-Branch vor dem <code>git merge</code> gezeigt hat. Würde statt dessen <code>-m 2 f62658e</code> benutzt, wäre dies das Commit, auf das der <code>feature/rounding-option</code> gezeigt hat (theirs).
</details>