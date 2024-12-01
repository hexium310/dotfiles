#Requires AutoHotkey v2.0

#include ".\IMEv2.ahk\IMEv2.ahk"

; 無変換 on zh-cn layout
$vkEB:: {
    if (Get_languege_name() = "zh-cn") {
        SetDefaultKeyboard(0x0411)
        IME_SET(0)
    } else {
        SendInput("{vk1D}")
    }
}

; 変換 on zh-cn layout
$vkFF:: {
    if (Get_languege_name() = "zh-cn") {
        SetDefaultKeyboard(0x0411)
        IME_SET(1)
    } else {
        SendInput("{vk1C}")
    }
}

; https://github.com/avin/ahk-toys/blob/1baf712c7c6c75e775820403aa7b3ca01b175ff4/run-apps/run-apps.ahk#L32-L45
SetDefaultKeyboard(localeID) {
    static SPI_SETDEFAULTINPUTLANG := 0x005A
    static SPIF_SENDWININICHANGE := 2


    Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
    binaryLocaleID := Buffer(4, 0)
    NumPut("UInt", LocaleID, binaryLocaleID)
    DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "Ptr", binaryLocaleID, "UInt", SPIF_SENDWININICHANGE)
    for hwnd in WinGetList() {
        try {
            PostMessage 0x50, 0, Lan, , hwnd
        }
    }
}
