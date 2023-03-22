#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
CoordMode, Pixel, Screen

imageFiles := ["시간 설정_1.png", "설정 버튼_1.png", "인코딩 시작 버튼_1.png"]
imageFiles_First := ["시작 시간 체크 박스.png", "시간 설정_1.png", "재생 정지 버튼.png"]
imageFiles_Second := ["종료 시간 체크 박스.png", "설정 버튼_1.png", "인코딩 시작 버튼_1.png"]
imageFiles_Third := ["파일 제목 MP4 이미지.png"]
Paused := false

global x := 0
global y := 0

ImageCheck(imageFile)
{
    WinGetPos, start_X, start_Y, end_width, end_height, A
    end_X := start_X + end_width
    end_Y := start_Y + end_height
    ImageSearch, x, y, %start_X%, %start_Y%, %end_X%, %end_Y%,*50 %imageFile%
    x := x - start_X
    y := y - start_Y 
}
ImageClick()
{
    y := y+5
    Click, %x%, %y%
}
ImageClick_Right()
{
    y := y+5
    Click Right, %x%, %y%
}
ImageClick_AB(A,B)
{
    x := x+A
    y := y+A
    Click, %x%, %y%
}

DoubleClick_Copy(A,B)
{
    x := x+A
    y := y+B
    Click, %x%, %y%
    Sleep, 20
    Click
    Sleep, 20
    Send, ^c
}

DoubleClick_Paste(A,B)
{
    x := x+A
    y := y+B
    Click, %x%, %y%
    Sleep, 20
    Click
    Sleep, 20
    Send, ^v
}

Z::
Loop, % imageFiles.MaxIndex()
{
    imageFile := imageFiles[A_Index]
    if (!Paused) 
    {
        Loop
        {
            
            ImageCheck(imageFile)
            if !ErrorLevel 
            {
                if(imageFile == "시간 설정_1.png") ;가로 94 세로 63 추가적으로 50으로 하는게좋을듯
                {
                    ImageClick_AB(47,50)
                    break                
                }
                ImageClick()
                break
            }
        }
    }
}
return
X::
Loop, % imageFiles_First.MaxIndex()
{
    imageFile := imageFiles_First[A_Index]
    if (!Paused) 
    {
        Loop, % imageFiles_First.MaxIndex()
        {
            ImageCheck(imageFile)
            if !ErrorLevel 
                {
                    if(imageFile == "시간 설정_1.png") 
                    {
                        ;가로 -60 세로 -60
                        ;더블클릭 복사 
                        ;가로 0 세로 +40 
                        ;더블클릭 붙여넣기
                        ;가로 -60 세로 -40
                        ;더블클릭 복사
                        ;가로 0 세로 +40 
                        ;더블클릭 붙여넣기
                        ;가로 -60 세로 -40
                        ;더블클릭 복사
                        ;가로 0 세로 +40 
                        ;더블클릭 붙여넣기
                        DoubleClick_Copy(-60,60)
                        DoubleClick_Paste(0,-40)
                        DoubleClick_Copy(-60,40)
                        DoubleClick_Paste(0,-40)
                        DoubleClick_Copy(-60,40)
                        DoubleClick_Paste(0,-40)
                        break                
                    }
                    ImageClick_AB(9,9) ;가로 9 세로 9
                    if(imageFile == "재생 정지 버튼.png")
                    {
                        Sleep, 100
                        Send {Space}
                    }
                    break
                }
        }
    }
}
Return
C::
Loop, % imageFiles_Second.MaxIndex()
{
    imageFile := imageFiles_Second[A_Index]
    if (!Paused) 
    {
        Loop
        {
            
            ImageCheck(imageFile)
            if !ErrorLevel 
            {
                ImageClick_AB(9,9)
                break
            }
        }
    }
}
Return
A::
Loop, % imageFiles_Third.MaxIndex()
{
    imageFile := imageFiles_Third[A_Index]
    Loop
        {
            ImageCheck(imageFile)
            if !ErrorLevel 
            {
                ImageClick_Right()
                send {q}
                break
            }
        }
}
return
F11::Pause
Return