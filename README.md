myExclusionCls := WinWaitExclusionClass() ; this will initialize the Class and the Exclusions. Recommended to do so right before running your Apps.
; myExclusionCls.Exclusions := WinGetList() ; This is basically what it does to initialize itself. It just grabs all your current windows to not match with them by accident.

Run "Notepad" ; run your aoos
Run "Notepad"
Run "Chrome"

; Grabs the ID of the WinTitles that will be showing up.
myNotepadIDArray := myExclusionCls.WinWaitArray("ahk_exe Notepad.exe", 2) ; Waits for 2 of these Windows and then returns their ID in an Array then shoves it into Exclusions.
myChromeID := myExclusionCls.WinWait("ahk_exe Chrome.exe") ; Returns the ID of this Window and shoves it into Exclusions.

; Do whatever action with those IDs now that we have them.
For Index, Value in myNotepadIDArray {
    Sleep 1000
    WinClose Value
}
Sleep 1000
WinClose myChromeID

; We can copy values into an Array.
myNewArray := []
myExclusionCls.CopyArrayValues(myNewArray, myChromeID, myNotepadIDArray) ; The 1st Parameter's Array will receive the values from all the next Parameters Array/Values.

; I have a Method to remove values from the Exclusions property directly and another Method that removes values from Array placed in the 1st Parameter.
myExclusionCls.DeleteExclusionValues(myChromeID, myNotepadIDArray) ; shove whatever Array/Values into this Method to remove them from the Exclusions.
myExclusionCls.DeleteArrayValues(myNewArray, myChromeID, myNotepadIDArray) ; The 1st parameter will remove any values that match what is in the 2nd parameter and so on.
