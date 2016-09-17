blockinput on
send {LButton}{RButton}7eee{enter}
blockinput Off
return
temp = %clipboard%
KeyWait, LButton, D
send {LButton}
sleep,100
Send, {Ctrl Down}c{Ctrl Up}
file = %clipboard% ;get file address
clipboard = %temp% ;restore clipboard
outdir := getdir(file)
if (A_Is64bitOS = 1) {
    runwait, "C:\Program Files\7-Zip\7z.exe" x "%file%" -o"%outdir%" -y,,hide
} else {
    runwait, "C:\Program Files (x86)\7-Zip\7z.exe" x "%file%" -o"%outdir%" -y,,hide
}
msgbox, 7zip has finished extracting "%file%".
return