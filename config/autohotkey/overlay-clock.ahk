#Requires AutoHotkey v2.0

GroupAdd("TargetApps", "ahk_exe factorio.exe")

ClockBg := Gui()
ClockBg.Opt("-Caption +ToolWindow +AlwaysOnTop +E0x20")
ClockBg.BackColor := "White"
WinSetTransColor(" 100", ClockBg.Hwnd)

ClockFg := Gui()
ClockFg.Opt("-Caption +ToolWindow +AlwaysOnTop +E0x20")
ClockFg.BackColor := "010101"
WinSetTransColor(ClockFg.BackColor, ClockFg.Hwnd)
ClockFg.SetFont("cBlack s12 q5", "Inconsolata")
ClockText := ClockFg.Add("Text", , FormatTime(, "00:00"))

PaddingInline := 10
PaddingBlock := 5
ClockText.GetPos(, , &W, &H)
Width := W + PaddingInline * 2
Height := H + PaddingBlock * 2
ShowOptions := "x0 y0 w" Width " h" Height " NoActivate"

ClockText.Move(PaddingInline, PaddingBlock)

IsVisible := False

SetTimer(TimerHandler, 1000)

TimerHandler(*) {
    global ClockBg, ClockFg, ClockText, ShowOptions, IsVisible

    if WinActive("ahk_group TargetApps") {
        ClockText.Value := FormatTime(, "HH:mm")

        if !IsVisible {
            ClockBg.Show(ShowOptions)
            ClockFg.Show(ShowOptions)

            IsVisible := true
        }
    } else {
        if IsVisible {
            ClockBg.Hide()
            ClockFg.Hide()

            IsVisible := false
        }
    }
}
