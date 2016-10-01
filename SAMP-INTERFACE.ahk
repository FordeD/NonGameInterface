#include SAMPMAXnew.ahk
#Include intManager.ahk
#Persistent
#MaxThreads 11
#MaxThreadsPerHotkey 11
SendMessage, 0x50,, 0x4190419,, A
IntTopic := -1
IntBox := -1
IntMoveBox := -1
DestroyAllVisual()
global int := new Interfase()
global int2 := new Interfase()

MouseGetPos, PosX, PosY
global Width := 800
global Height := 600
global InterfaseWidth
global InterfaseHeight
global PosXProc
global PosYProc
global SAMPPOSX
global SAMPPOSY
global RasnX
global RasnY
global IntX
global Inty
global ResizeY
global ResizeX

;InterfaseWidth := 150
;InterfaseHeight := 280
;Intx := Width/2-InterfaseWidth/2
;Inty := Height/2-InterfaseHeight/2

int.CreateDialog(300,200,150,280, "Interfase Topic")
int.AddContent("label", "My thirst text1")
int.AddContent("line")
int.AddContent("label", "My thirst text2")
int.AddContent("label", "My thirst text3")
int.AddContent("label", "My thirst text4")
int.AddContent("button", "Click Me! 1" )
int.AddContent("line")
int.AddContent("button", "Click Me! 2")
int.AddContent("label", "My thirst text5")
int.AddContent("label", "My thirst text6")
int.AddContent("label", "My thirst text7")
int.AddContent("label", "My thirst text8")
int.AddContent("label", "My thirst text9")
int.AddContent("line")
int.AddContent("button", "Click Me! 3")

int2.CreateDialog(300,200,150,280, "Interfase Topic2")
int2.AddContent("label", "My thirst text1")
int2.AddContent("line")
int2.AddContent("label", "My thirst text2")
int2.AddContent("label", "My thirst text3")
int2.AddContent("label", "My thirst text4")
int2.AddContent("button", "Click Me! 1" )
int2.AddContent("line")
int2.AddContent("button", "Click Me! 2")
int2.AddContent("label", "My thirst text5")
int2.AddContent("label", "My thirst text6")
int2.AddContent("label", "My thirst text7")
int2.AddContent("label", "My thirst text8")
int2.AddContent("label", "My thirst text9")
int2.AddContent("line")
int2.AddContent("button", "Click Me! 3")

;Функция открытия второго окна
^0::
Sleep, 10
if ( WinActive("GTA:SA:MP"))
{
	if (!IsPlayerInMenu()) {
		if (!int2.IsShow) {
			int2.ShowDialog(MainMenu, true)
			int2.IsShow := true
		} else {
			int2.ShowDialog(MainMenu, false)
			int2.IsShow := false
		}
	}
}
return

!0::
int2.ChangeContent(1, "Thirst stroke")
return
!AppsKey::
int.ChangeContent(1, "This Is McFree!")
return
;Функция открытия первого окна
AppsKey::
Sleep, 10
if ( WinActive("GTA:SA:MP"))
{
	if (!IsPlayerInMenu()) {
		if (!int.IsShow) {
			int.ShowDialog(MainMenu, true)
			int.IsShow := true
		} else {
			int.ShowDialog(MainMenu, false)
			int.IsShow := false
		}
	}
}
return

; Закрытие диалогов на кнопку Esc
~Esc::
if (int.IsShow) {
	int.ShowDialog(MainMenu, false)
	int.IsShow := false
}
if (int2.IsShow) {
	int2.ShowDialog(MainMenu, false)
	int2.IsShow := false
}
return

; Действие на правую кнопку мыши
~vk02::
While GetKeyState("vk02", "P") {
	GetCoords(SAMPPOSX, SAMPPOSY)
	int.GetCoods(XPos, YPos, IntWidth, IntHeight)
	if (SAMPPOSX >= XPos && SAMPPOSY >= YPos && SAMPPOSX <= XPos+IntWidth && SAMPPOSY <= YPos+20) {
		if (!int.Move) {
			RasnX := SAMPPOSX-XPos
			RasnY := SAMPPOSY-YPos
			int.IsMove := true
		}
		int.Move := true
		int.IsMoved(int.Move)
	} else if (SAMPPOSX >= XPos+IntWidth-20 && SAMPPOSY >= YPos+IntHeight-20 && SAMPPOSY <= YPos+IntHeight+20 && SAMPPOSX <= XPos+IntWidth+20 ) {
		if (!int.IsResize) {
			int.IsResize := true
		}
		ResizeX := SAMPPOSX-XPos
		ResizeY := SAMPPOSY-YPos
		int.Resize := true
	}
	If(int.IsShow) {
		Loop, % int.LineCount
		{
			if (int.ContentName[A_Index] == "button") {
				if (SAMPPOSX >= int.ContX[A_Index] && SAMPPOSY >= int.ContY[A_Index] && SAMPPOSY <= int.ContY[A_Index]+10 && SAMPPOSX <= XPos+IntWidth-25 ) {
					if (!int.ButtonClick) {
						int.ButtonClick := true
						int.IsClicked( A_Index)
					}
				} else {
					int.ButtonClick := false
					int.IsClicked(A_Index)
				}
			}
		}
	}
	int2.GetCoods(XPos2, YPos2, IntWidth2, IntHeight2)
	if (SAMPPOSX >= XPos2 && SAMPPOSY >= YPos2 && SAMPPOSX <= XPos2+IntWidth2 && SAMPPOSY <= YPos2+20) {
		if (!int2.Move) {
			RasnX := SAMPPOSX-XPos2
			RasnY := SAMPPOSY-YPos2
			int2.IsMove := true
		}
		int2.Move := true
		int2.IsMoved(int2.Move)
	} else if (SAMPPOSX >= XPos2+IntWidth2-20 && SAMPPOSY >= YPos2+IntHeight2-20 && SAMPPOSY <= YPos2+IntHeight2+20 && SAMPPOSX <= XPos2+IntWidth2+20 ) {
		if (!int2.IsResize) {
			int2.IsResize := true
		}
		ResizeX := SAMPPOSX-XPos2
		ResizeY := SAMPPOSY-YPos2
		int2.Resize := true
	}
	If(int2.IsShow) {
		Loop, % int2.LineCount
		{
			if (int2.ContentName[A_Index] == "button") {
				if (SAMPPOSX >= int2.ContX[A_Index] && SAMPPOSY >= int2.ContY[A_Index] && SAMPPOSY <= int2.ContY[A_Index]+10 && SAMPPOSX <= XPos2+IntWidth2-25 ) {
					if (!int2.ButtonClick) {
						int2.ButtonClick := true
						int2.IsClicked( A_Index)
					}
				} else {
					int2.ButtonClick := false
					int2.IsClicked(A_Index)
				}
			}
		}
	}
}

int.Move := false
int.Resize := false
int.IsMove := false
int.IsResize := false
int.IsMoved(int.Move)
int.ButtonClick := false

int2.Move := false
int2.Resize := false
int2.IsMove := false
int2.IsResize := false
int2.IsMoved(int2.Move)
int2.ButtonClick := false
return

; Рестарт скрипта с диалогами
^1:: 
int.IsShow := false
int2.IsShow := false
Reload
return

; 
GetCoords(ByRef ResX, ByRef ResY) {
	MouseGetPos, PosX, PosY
	PosXProc := (PosX*100)/A_ScreenWidth
	PosYProc := (PosY*100)/A_ScreenHeight
	ResX := PosXProc*8
	ResY := PosYProc*6
}



; Главный цикл работы интерфейса

SetTimer, Main, 1 ; запуск таймера на 1 миллисекунду

Main:
if (!IsPlayerInMenu()) {
	; Если открыт первый диалог
	if (int.IsShow) {
		if (int.Move) {
			if (RasnX != SAMPPOSX-int.Intx || RasnY != SAMPPOSY-int.Inty) {
				IntX := SAMPPOSX-RasnX
				IntY := SAMPPOSY-RasnY
				int.SaveCoords(IntX,IntY)
				int.MoveInterfase(this.MainMenu, IntX, IntY)
			}
		} else if (int.Resize) {
			if (int.InterfaseHeight != ResizeY || int.InterfaseWidth != ResizeX) {
				if (ResizeY < 50 || ResizeX < 80) {
					int.Resize := false
					int.IsResize := false
				} else {
					int.SaveCoords(,,ResizeX,ResizeY)
					int.ResizeInterfase(this.MainMenu, int.InterfaseWidth, int.InterfaseHeight)
				}
			}
		}
		GetCoords(SAMPPOSX, SAMPPOSY)
		Loop, % int.LineCount
		{
			if (int.ContentName[A_Index] == "button") {
				if (SAMPPOSX >= int.ContX[A_Index] && SAMPPOSY >= int.ContY[A_Index] && SAMPPOSY <= int.ContY[A_Index]+10 && SAMPPOSX <= XPos+IntWidth-25 ) {
					if (!int.ButtonClick) {
						if (!int.ButtonHover) {
							int.ButtonHover := true
							int.IsHovered(A_Index)
						}
					} else {
						int.ButtonClick := true
					}
				} else {
					int.ButtonClick := false
					int.ButtonHover := false
					int.IsHovered(A_Index)
				}
			}
		}
	} else {
		int.ShowDialog(MainMenu, false)
	}
	
	;Если открыт второй диалог
	if (int2.IsShow) {
		if (int2.Move) {
			if (RasnX != SAMPPOSX-int2.Intx || RasnY != SAMPPOSY-int2.Inty) {
				IntX := SAMPPOSX-RasnX
				IntY := SAMPPOSY-RasnY
				int2.SaveCoords(IntX,IntY)
				int2.MoveInterfase(this.MainMenu, IntX, IntY)
			}
		} else if (int2.Resize) {
			if (int2.InterfaseHeight != ResizeY || int2.InterfaseWidth != ResizeX) {
				if (ResizeY < 50 || ResizeX < 80) {
					int2.Resize := false
					int2.IsResize := false
				} else {
					int2.SaveCoords(,,ResizeX,ResizeY)
					int2.ResizeInterfase(this.MainMenu, int2.InterfaseWidth, int2.InterfaseHeight)
				}
			}
		}
		GetCoords(SAMPPOSX, SAMPPOSY)
		Loop, % int2.LineCount
		{
			if (int2.ContentName[A_Index] == "button") {
				if (SAMPPOSX >= int2.ContX[A_Index] && SAMPPOSY >= int2.ContY[A_Index] && SAMPPOSY <= int2.ContY[A_Index]+10 && SAMPPOSX <= XPos+IntWidth-25 ) {
					if (!int2.ButtonClick) {
						if (!int2.ButtonHover) {
							int2.ButtonHover := true
							int2.IsHovered(A_Index)
						}
					} else {
						int2.ButtonClick := true
					}
				} else {
					int2.ButtonClick := false
					int2.ButtonHover := false
					int2.IsHovered(A_Index)
				}
			}
		}
	} else {
		int2.ShowDialog(MainMenu, false)
	}
} else {
	HideAllVisual()
}
return
