class Interfase
{
	; Object Massives
	static MainMenu, Content, ContentName, ContX, ContY, ContentText
	; Main parameters
	static InterfaseWidth,InterfaseHeight,Intx, Inty, LineCount := 0, Topic
	; Events
	static Move := false
	static Resize := false
	static IsMove := false
	static IsResize := false
	static IsShow := false
	static ButtonHover := false
	static ButtonClick := false
	__new()
	{
		this.MainMenu[1] := -1 
		this.MainMenu[2] := -1 
		this.MainMenu[3] := -1 
		this.MainMenu[4] := -1 
		return this
	}
	__delete()
	{
		BoxDestroy(this.MainMenu[1])
		BoxDestroy(this.MainMenu[2])
		TextDestroy(this.MainMenu[3])
		ImageDestroy(this.MainMenu[4])
		return
	}
	SaveCoords(X:=0,Y:=0,W:=0,H:=0) {
		if(X) {
			this.Intx := X
		}
		if(Y) {
			this.Inty := Y
		}
		if(W) {
			this.InterfaseWidth := W
		}
		if(H) {
			this.InterfaseHeight := H
		}
		return
	}
	GetCoods(ByRef X, ByRef Y, ByRef W, ByRef H) {
		X := this.Intx
		Y := this.Inty
		W := this.InterfaseWidth
		H := this.InterfaseHeight
		return
	}
	GetContent( Number ,ByRef X, ByRef Y, ByRef Text, ByRef Name) {
		X := this.Intx
		Y := this.Inty
		W := this.InterfaseWidth
		H := this.InterfaseHeight
		return
	}
	CreateDialog(X,Y,W,H, Topic) {
		this.Intx := X
		this.Inty := Y
		this.InterfaseWidth := W
		this.InterfaseHeight := H
		this.Topic := Topic
		this.MainMenu[1] := BoxCreate(X, Y, W, H, 0xCC212121, false)
		this.MainMenu[2] := BoxCreate(X, Y, W, 20, 0xEE212121, false)
		this.MainMenu[3] := TextCreate("Tahoma", 6, true, false, X+5, Y+5, 0xFFFFFFFF, Topic, true, false)
		this.MainMenu[4] := ImageCreate("MovePount.png", X+W-16, Y+H-16, 0,  0, false)
		return
	}
	
	ShowDialog(ByRef MainID, Show) {
		BoxSetShown(this.MainMenu[1],Show)
		BoxSetShown(this.MainMenu[2],Show)
		TextSetShown(this.MainMenu[3],Show)
		ImageSetShown(this.MainMenu[4],show)
		Loop, % this.LineCount
		{
			if (this.ContentName[A_Index] == "label") {
				TextSetShown(this.Content[A_Index],Show)
			} if (this.ContentName[A_Index] == "line") {
				LineSetShown(this.Content[A_Index],Show)
			} if (this.ContentName[A_Index] == "button" ) {
				BoxSetShown(this.Content[A_Index],Show)
				TextSetShown(this.ContentText[A_Index],Show)
			}
		}
		InterfaseShown := Show
		return
	}
	
	IsClicked(Index) {
		if(this.ButtonClick) {
			BoxSetColor(this.Content[Index],0xFF74ABDD)
		} else {
			BoxSetColor(this.Content[Index],0xFF348EE1)
		}
		return
	}
	
	IsHovered(Index) {
		if(this.ButtonHover) {
			BoxSetColor(this.Content[Index],0xFF2D7EC9)
		} else {
			BoxSetColor(this.Content[Index],0xFF348EE1)
		}
		return
	}
	
	IsMoved(IsMoved) {
		if(IsMoved) {
			BoxSetColor(this.MainMenu[1],0xDD212121)
		} else {
			BoxSetColor(this.MainMenu[1],0xCC212121)
		}
		return
	}
	
	MoveInterfase(MainMenu, PosX, PosY) {
		BoxSetPos(this.MainMenu[1], PosX, PosY)
		BoxSetPos(this.MainMenu[2], PosX,  PosY)
		TextSetPos(this.MainMenu[3], PosX+5, PosY+5)
		ImageSetPos(this.MainMenu[4],PosX+this.InterfaseWidth-16, PosY+this.InterfaseHeight-16)
		Loop, % this.LineCount
		{
			if (this.ContentName[A_Index] == "label") {
				TextSetPos(this.Content[A_Index], PosX+5, PosY+15+(10*A_Index))
				this.ContX[A_Index] := PosX+5
				this.ContY[A_Index] := PosY+15+(10*A_Index)
			} if (this.ContentName[A_Index] == "line") {
				LineSetPos(this.Content[A_Index], PosX+5, PosY+20+(10*A_Index), PosX+this.InterfaseWidth-5, PosY+20+(10*A_Index))
				this.ContX[A_Index] := PosX+5
				this.ContY[A_Index] := PosY+20+(10*A_Index)
			} if (this.ContentName[A_Index] == "button") {
				BoxSetPos(this.Content[A_Index], PosX+25, PosY+15+(10*A_Index))
				TextSetPos(this.ContentText[A_Index], PosX+25+(this.InterfaseWidth/4), PosY+15+(10*A_Index))
				this.ContX[A_Index] := PosX+25
				this.ContY[A_Index] := PosY+15+(10*A_Index)
			}
		}
		return
	}
	ResizeInterfase(MainMenu, Size1, Size2) {
		BoxSetWidth(this.MainMenu[1],Size1)
		BoxSetWidth(this.MainMenu[2],Size1)
		BoxSetHeight(this.MainMenu[1],Size2)
		ImageSetPos(this.MainMenu[4],Size1+this.Intx-16, Size2+this.Inty-16)
		Loop, % this.LineCount
		{
			if (this.ContentName[A_Index] == "line") {
				LineSetPos(this.Content[A_Index], this.Intx+5, this.ContY[A_Index], this.Intx+this.InterfaseWidth-5, this.ContY[A_Index])
				if (this.ContY[A_Index]+10 >= this.Inty+Size2) {
					LineSetShown(this.Content[A_Index], false )
				} else {
					LineSetShown(this.Content[A_Index], true )
				}
			} if (this.ContentName[A_Index] == "label") {
				if (this.ContY[A_Index]+10 >= this.Inty+Size2) {
					TextSetShown(this.Content[A_Index], false )
				} else {
					TextSetShown(this.Content[A_Index], true )
				}
			} if (this.ContentName[A_Index] == "button") {
				BoxSetWidth(this.Content[A_Index], Size1-50)
				TextSetPos(this.ContentText[A_Index], this.ContX[A_Index]+(Size1/4), this.ContY[A_Index]+1)
				if (this.ContY[A_Index]+10 >= this.Inty+Size2) {
					BoxSetShown(this.Content[A_Index], false )
					TextSetShown(this.ContentText[A_Index], false )
				} else {
					BoxSetShown(this.Content[A_Index], true )
					TextSetShown(this.ContentText[A_Index], true )
				}
			}
		}
		return
	}
	AddContent(Type,Text := "") {
		if (type == "label") {
			this.LineCount++
			X := this.Intx
			Y := this.Inty
			this.ContX[this.LineCount] := X+5
			this.ContY[this.LineCount] := Y+15+(10*this.LineCount)
			this.Content[this.LineCount] := TextCreate("Tahoma", 6, false, false, this.ContX[this.LineCount], this.ContY[this.LineCount], 0xFFFFFFFF, Text, true, false)
			this.ContentText[this.LineCount] := Text
			this.ContentName[this.LineCount] := "label"
		} if (type == "line") {
			this.LineCount++
			X := this.Intx
			Y := this.Inty
			this.ContX[this.LineCount] := X+5
			this.ContY[this.LineCount] := Y+20+(10*this.LineCount)
			this.Content[this.LineCount] := LineCreate(this.ContX[this.LineCount], this.ContY[this.LineCount], X+this.InterfaseWidth-5, Y+20+(10*this.LineCount), 1, 0xFFFFFFFF, false)
			this.ContentText[this.LineCount] := -1
			this.ContentName[this.LineCount] := "line"
		} if (type == "button") {
			this.LineCount++
			X := this.Intx
			Y := this.Inty
			this.ContX[this.LineCount] := X+25
			this.ContY[this.LineCount] := Y+15+(10*this.LineCount)
			this.Content[this.LineCount] := BoxCreate(this.ContX[this.LineCount], this.ContY[this.LineCount], this.InterfaseWidth-50, 10, 0xFF348EE1, false)
			this.ContentText[this.LineCount] := TextCreate("Tahoma", 5, true, false, this.ContX[this.LineCount]+(this.InterfaseWidth/4), this.ContY[this.LineCount], 0xFFFFFFFF, Text, true, false)
			this.ContentName[this.LineCount] := "button"
		}
		return
	}
	ChangeContent(contentNum, text := "") {
		this.ContentText[ContentNum] := text
		TextSetString(this.Content[ContentNum], text)
		return
	}
	ChangeContentColor(contentNum, type, color) {
		if (type == "label") {
			TextSetColor(this.Content[ContentNum], color)
		} if (type == "line") {
			LineSetColor(this.Content[ContentNum], color)
		} if (type == "button") {
			BoxSetColor(this.Content[ContentNum], color)
		} if (type == "buttonText") {
			TextSetColor(this.Content[ContentNum], color)
		}
		return
	}
}
