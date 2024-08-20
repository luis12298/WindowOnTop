#Persistent
#SingleInstance Force  ; Evita que se ejecute más de una instancia del script

; Ruta al archivo de bloqueo
lockFile := A_Temp "\ahk_lock_file.lock"

; Crear un archivo de bloqueo para evitar múltiples instancias
FileAppend,, %lockFile%, UTF-8
if ErrorLevel
{
    MsgBox, El script ya está en ejecución.
    ExitApp
}

^!t::  ; Ctrl + Alt + T
    ; Obtener el estado "Always on Top" de la ventana activa
    WinGet, ExStyle, ExStyle, A
    if (ExStyle & 0x8)  ; Si la ventana ya es "Always on Top"
    {
        ; Desactivar "Always on Top"
        Winset, Alwaysontop, Off, A
        TrayTip,, "Always on Top desactivado"
    }
    else  ; Si la ventana no es "Always on Top"
    {
        ; Activar "Always on Top"
        Winset, Alwaysontop, On, A
        TrayTip,, "Always on Top activado"
    }
return

OnExit, Cleanup  ; Llamar a Cleanup cuando el script se cierre

Cleanup:
    ; Eliminar el archivo de bloqueo al salir
    FileDelete, %lockFile%
return
