;Writes e-mail address (ctrl + 2)
^2::write("Your email address here")

;Opens cmd at the user profile directory (Win + c)
#c::cmd()

;Opens cmd at the current File Explorer directory (Win + ctrl + c)
^#c::cmdExplorer()

;Unzips file to new folder (ctrl + shift + LMB)
+^LButton::7zip()


write(txt) {
    #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
    ;#Warn  ; Enable warnings to assist with detecting common errors.
    SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
    SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

    Send, %txt%
    Return
}


cmd() {
    SetTitleMatchMode, 2
    Run, cmd.exe, C:\Users\there\  ; Change this to your user profile
    return
}

cmdExplorer() {
    #IfWinActive ahk_class CabinetWClass  ; for use in explorer.
    SetTitleMatchMode, 2
    ClipSaved := ClipboardAll
    Send !d
    Sleep 10
    Send ^c
    Run, cmd /K "cd `"%clipboard%`"" := ClipSaved7
    ClipSaved =
    return
    #IfWinActive
}


7zip() {
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
    }

    getdir(input) {
        SplitPath, input,,parentdir,,filenoext
        final = %parentdir%\%filenoext%
        return final
    }
