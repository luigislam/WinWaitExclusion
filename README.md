### License
MIT License. Do whatever you want with this script.

### What is this Library for?
This Class is a workaround for RunWait's inability to handle an executable that opens multiple windows. 
The code in this class basically just imitates WinWait while maintaining a list of window IDs to exclude. The WinWait method in this class will add found windows to the exclusion.  
* AHK's built-in RunWait fails when it comes to dealing with executables that open multiple windows since it only waits and grabs the ID of the 1st window and doesn't account more windows.  
* AHK's built-in WinWait will match your pre-existing windows which is why this class builds a list of windows to exclude matching with.

### Simple Explanation on usage
1. Initialize the Class to a Variable.
2. Use class.Start() to initialize/reset the windows to exclude.
3. Use the Run Function to run your Executable.
4. Use the Class.WinWait() or Class.WinWaitArray() methods to get the ID of the windows that will be appearing.

### Example 1
```
; initialize the class into a Variable
WWE := WinWaitExclusionClass()

; Use Variable.Start() to initialize the existing list of Windows to be excluded from matching.
WWE.Start()
; run your executable that opens multiple windows.
Run "Notepad"
Run "Notepad"
Run "Chrome"
Run "Notepad"

; Use Variable.WinWait() or Variable.WinWaitArray() to grab the IDs of the windows that will be appearing.
myNotepadWindowList := WWE.WinWaitArray("ahk_exe Notepad.exe", 3) ; waits for 3 new notepad windows before continuing
Msgbox "Found " myNotepadWindowList.Length " Notepad Windows",, 0x1000
myChromeWindow := WWE.WinWait("ahk_exe chrome.exe") ; waits for 1 new chrome window before continuing
Msgbox "Found " WinGetTitle(myChromeWindow),, 0x1000
```

### Example 2
```
F1:: Run "Notepad" ; Pressing the F1 hotkey will open a new Notepad window.

Suspend true ; disables the F1 Hotkey so its not usable at the start
WWE := WinWaitExclusionClass() ; initialize the class
Msgbox "Close this Msgbox and then press F1 to open Notepad windows."
Suspend false ; enables the F1 Hotkey for use
WWE.Start() ; initialize the exclusion of your pre-existing windows
myFoundList := WWE.WinWaitArray(,, 3) ; this will find any new window within the next 3 seconds.
Suspend true ; this is to disable the F1 Hotkey
Msgbox "Found " myFoundList.Length " Windows.`nClosing this Msgbox will continue onto the next section of code that will delete the found windows"

For Index, Value in myFoundList { ; perform code for each window inside the List
    If WinExist(Value) ; checks if the window exists first and then...
        WinClose() ; closes the window
}
```
