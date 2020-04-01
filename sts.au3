#include <IE.au3>
$last_lowest = 0
main()


Func login($oIE)
_IELoadWait($oIE)
Local $oInputs = _IETagNameGetCollection($oIE, "Input")
For $oInput In $oInputs
   If $oInput.name = 'username' Then $oInput.value = 'login'
   If $oInput.id = 'txtPasswd-password' Then $oInput.value = 'haslo'
   if $oInput.name= '_submit' Then _IEAction($oInput, 'click')
   Next
EndFunc

Func kursy($oIE)
   ConsoleWrite("kursy" & @CRLF)
Sleep(3000)
$tmp = ""
$num = 0
$lowest = 4
$hand = 0
For $nb = 1 To 6 Step 1
   $oCollection = $oIE.document.getElementsByClassName("PokerOdd-Component hand_"&String($nb))
   for $a in $oCollection
	  $tmp = $a.innertext
	  StringReplace($tmp, @CRLF, "")
	  StringReplace($tmp, " ", "")
	  $num = Number($tmp)
	  If $num < $lowest and $num > 0 Then
		 $lowest = $num
		 $hand = $nb
	  EndIf
   Next
Next
If $last_lowest = $lowest Then
   return 0
Else
   $last_lowest = $lowest
   return $hand
EndIf
EndFunc

Func klik($oIE,$hand)
ConsoleWrite("klik" & @CRLF)
If $hand == 1 Then
MouseClick("left",1493, 924,1,0)
EndIf
If $hand == 2 Then
MouseClick("left",1320, 965,1,0)
EndIf
If $hand == 3 Then
MouseClick("left",1144, 1004,1,0)
EndIf
If $hand == 4 Then
MouseClick("left",953, 1004,1,0)
EndIf
If $hand == 5 Then
MouseClick("left",771, 961,1,0)
EndIf
If $hand == 6 Then
MouseClick("left",622, 913,1,0)
EndIf
if $hand > 0 and $hand <7 Then
   MouseClick("left",1659, 490,1,0)
   Sleep(500)
   Send("^a2")
   MouseClick("left",1809, 585,1,0)
EndIf
EndFunc

func main()
 Local $oIE = _IECreate("https://www.sts.pl/pl/betgames/poker/", 0,0,1,0)
;WinSetState("[CLASS:IEFrame]","",@SW_MAXIMIZE )
;login($oIE)
While 1
   ConsoleWrite("main" & @CRLF)
$hand = kursy($oIE)

klik($oIE, $hand)

WEnd
_IEQuit($oIE)
EndFunc
