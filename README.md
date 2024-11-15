### What is this Library for?
This Class is a workaround for RunWait's inability to handle an executable that opens multiple windows.  
The code in this class just imitates WinWait while maintaining an internal list of window IDs to exclude.  
The WinWait/WinWaitArray method in this class will add found windows to the exclusion.  
* AHK's built-in RunWait fails when it comes to dealing with executables that open multiple windows since it only waits and grabs the ID of the 1st window and doesn't account more windows.  
* AHK's built-in WinWait will match your pre-existing windows which is why this class builds a list of the pre-existing windows to avoid matching them.

### Simple Explanation on usage
1. Initialize the Class to a Variable.
2. Use Variable.Start() to setup/reset the windows to exclude.
3. Use the Run Function to run your Executable.
4. Use the Variable.WinWait() or Variable.WinWaitArray() methods to get the ID of the windows that will be appearing.

### Example 1: Matching any newly existing Window for the next 3 seconds.
```
WWE := WinWaitExclusionClass() ; initialize the class to a variable called "WWE"

F1:: Run "Notepad" ; Pressing the F1 hotkey will open a new Notepad window.

Suspend true ; disables the F1 Hotkey so we can't use it at the start of this script.
Msgbox "Close this Msgbox and then press F1 to open Notepad windows."
Suspend false ; enables the F1 Hotkey for use
WWE.Start() ; grabs all currently existing windows to be excluded from future Variable.WinWait() methods
myFoundList := WWE.WinWaitArray(,, 3) ; this will find any new window within the next 3 seconds.
Suspend true ; this is to disable the F1 Hotkey
Msgbox "Found " myFoundList.Length " Windows.`nClosing this Msgbox will continue onto the next section of code that will delete the found windows"

For Index, Value in myFoundList { ; perform code for each window inside the List
    If WinExist(Value) ; checks if the window exists first and then...
        WinClose() ; closes the window
}
ExitApp ; closes the script
```

### Example 2: Finding specific windows and storing them into Variables/Arrays
```
WWE := WinWaitExclusionClass()

; Use Variable.Start() to initialize the existing list of Windows to be excluded from matching.
WWE.Start()

; run your executable that opens multiple windows.
Run "Notepad"
Run "Notepad"
Run "Notepad"
Run "MsPaint"

; Use Variable.WinWait() or Variable.WinWaitArray() to grab the IDs of the windows that will be appearing.
myNotepadWindowArray := WWE.WinWaitArray("ahk_exe Notepad.exe", 3) ; waits for 3 new notepad windows before continuing
myMSPaintWindow := WWE.WinWait("ahk_exe msPaint.exe") ; waits for 1 new MsPaint window before continuing
Msgbox "Found " myNotepadWindowArray.Length " Notepad windows"
Msgbox "Found 1 MsPaint window named... " WinGetTitle(myMSPaintWindow)

For Index, Value in myNotepadWindowArray ; perform code for each window in this Array
    If WinExist(Value) ; if window exists...
        WinClose ; close the window

If WinExist(myMSPaintWindow) ; if window exists...
    WinClose ; close the window

ExitApp ; closes the script
```
