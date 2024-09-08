### License
MIT License. Do whatever you want with this script.

### What is this Library for?
This Class will cover for RunWait's flaws by having its own WinWait function that maintains an Array of Window IDs to ignore duplicate matches and some small tools for copying/deleting the Array values.  
* AHK's built-in RunWait fails when it comes to dealing with executables that open multiple windows since it only waits and grabs the ID of the 1st window and doesn't account more windows.  
* AHK's built-in WinWait will match your pre-existing windows so it doesn't replace RunWait.

### Simple Explanation on usage
1. Initialize the Class first.
2. Run your Apps via the Run Function.
3. Use your Class.WinWait() or Class.WinWaitArray() methods to get the ID of the windows that will be appearing.
4. Done.

### Example
```
myExclusionCls := WinWaitExclusionClass() ; this will initialize the Class and the Exclusions. Recommended to do so right before running your Apps.
; myExclusionCls.Exclusions := WinGetList() ; This is basically what it does to initialize itself. It just grabs all your current existing windows.

; run your apps
Run "Notepad"
Run "Notepad"
Run "Chrome"

; Wait to Return the ID of the matching WinTitles that will be showing up.
; The WinWait/WinWaitArray methods uses the Exclusions initialized before you ran your Apps so they don't pickup pre-existing matching windows by accident.
; Any windows found by these 2 methods will be automatically added into the Exclusions so there aren't duplicate matches.
myChromeID := myExclusionCls.WinWait("ahk_exe Chrome.exe") ; Returns the ID of this Window.
myNotepadIDArray := myExclusionCls.WinWaitArray("ahk_exe Notepad.exe", 2) ; Waits for 2 of these Windows and then returns their ID in an Array.

; Do whatever action with those IDs that you were going to use them for
For Index, Value in myNotepadIDArray {
    Sleep 1000
    WinClose Value
}
Sleep 1000
WinClose myChromeID

; We can copy values into an Array.
myNewArray := []
myExclusionCls.CopyArrayValues(myNewArray, myChromeID, myNotepadIDArray) ; The 1st Parameter's Array will receive the values from the following Parameters' Array/Values.

; We can delete values from an Array
myExclusionCls.DeleteArrayValues(myNewArray, myChromeID, myNotepadIDArray) ; The 1st Parameter's Array will lose any values that match from the following Parameter's Array/Values
myExclusionCls.DeleteExclusionValues(myChromeID, myNotepadIDArray) ; This is just to directly delete values from the Exclusions property for simplicity.
```
