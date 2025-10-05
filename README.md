### What is this Function for?
* WinWaitExclusion is designed to only match for "new" windows that were created after WinWaitExclusion was used. This functionality is something that WinWait and RunWait completely fail to do.
* Autohotkey's WinWait function will match any "currently existing" windows indiscriminately.
* Autohotkey's RunWait function does not grab more than 1 window. This means that RunWait to be useless if your app creates more than 1 window and they all share the same window name and processes.

### Why would I need this?
For me personally, I use a program that creates multiple cmd windows that don't have any unique names/exe/class/etc so the only consistent and unique way to differentiate them is the order in which they appear. I could realistically just skim through the text in each separate cmd window but that is insanely stupid to do.

### Simple Explanation on usage
```ahk
WinWaitExclusion(,, True) ; Step 1: Use WinWaitExclusion(,,True) to Initalize/Reset the Exclusion list to contain all your current existing windows
Run "Notepad" ; Step 2: If you're using AHK's Run function to run your app, do it now before Step 3.
WinWaitExclusion("ahk_exe notepad.exe") ; Step 3: Use WinWaitExclusion(WinTitle, Timeout) to wait until your window is found. The Timeout parameter is optional and uses Milliseconds as the time value. Omitting the WinTitle parameter will match any window.
Msgbox "Done" ; This line is only reached after a new Notepad window is found or timed out.
```

### Example 1: Matching a new Notepad Window and storing the ID into a Variable.
```ahk
WinWaitExclusion(,,True) ; initialize the exclusion list
; If you were using the Run Function it would go here but since I'm not doing that in this code then you should run the Notepad app manually yourself.
myFoundID := WinWaitExclusion("ahk_exe Notepad.exe") ; matches any new window and stores the ID into the variable myFoundID.
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
