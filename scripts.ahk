;Writes e-mail address (ctrl + 2)
^2::write("Your email address here")

;Opens cmd at "C:\Users\there\" (Win + c)
#c::cmd()

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
    ifwinactive, ahk_class CabinetWClass
        ControlGetText, address , edit1, ahk_class CabinetWClass
    else
        address =

    ;Exclude specific windows
    ;ifwinactive, My Computer
        ;address =

    if (address <> "") {
        Run, cmd.exe, %address%
    } else {
        Run, cmd.exe, C:\Users\there\
    }
    Return
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
