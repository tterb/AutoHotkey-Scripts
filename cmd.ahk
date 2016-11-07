;Opens cmd at the user profile directory (Win + c)
#c::cmd()

;Opens cmd at the current File Explorer directory (Win + ctrl + c)
^#c::cmdExplorer()

cmd() {
    SetTitleMatchMode, 2
    Run, cmd.exe, C:\Users\there\
    return
}

cmdExplorer() {
	#IfWinActive ahk_class CabinetWClass  ; for use in explorer.
	ClipSaved := ClipboardAll
	Send !d
	Sleep 10
	Send ^c
	Run, cmd /K "cd `"%clipboard%`"" := ClipSaved
	ClipSaved =
	return
	#IfWinActive
}
