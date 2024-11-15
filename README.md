### What is this Function for?
* AHK's built-in WinWait will match any existing windows "indiscriminately" which is why I made this function so I can only match new windows.
* AHK's built-in RunWait does not grab more than 1 window. This Function can catch any newly created window.
The Function waits for a new window to appear by creating and maintaing a list of windows to exclude matching against.

### Simple Explanation on usage
Step 1. Use WinWaitExclusion(,,True) to Initalize/Reset the Exclusion list to contain all your current existing windows
Step 2. If you're using AHK's Run function to run your app, do it now before Step 3.
Step 3. Use WinWaitExclusion(WinTitle, Timeout) to wait until your window is found. The Timeout parameter is optional. Omitting the WinTitle parameter will match any window.
```ahk
WinWaitExclusion(,, True) ; Step 1
Run "Notepad" ; Step 2
WinWaitExclusion("ahk_exe notepad.exe") ; Step 3
Msgbox "Done" ; This msgbox is only reached after a new Notepad window is found.
```

### Example 1: Matching a new Notepad Window and storing the ID into a Variable.
```ahk
WinWaitExclusion(,,True) ; initialize the exclusion list
; If you were using the Run Function, it would go here.
myFoundID := WinWaitExclusion("ahk_exe Notepad.exe) ; matches any new window and stores the ID into the variable myFoundID.
Msgbox WinGetTitle(myFoundID) ; displays the window name of the found window
}
```

### Example 2: Matching and Displaying the next 3 windows of any kind.
```ahk
WinWaitExclusion(,,True) ; initialize the exclusion list
Loop 3 {
    myFoundID := WinWaitExclusion() ; matches any new window and stores the ID into the variable myFoundID.
    Msgbox WinGetTitle(myFoundID) ; displays the window name of the found window
}
```
