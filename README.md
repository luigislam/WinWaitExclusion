### What is this Function for?
* AHK's built-in WinWait will match any existing windows "indiscriminately" which is why I made this function so I can only match new windows.
* AHK's built-in RunWait does not grab more than 1 window. This Function can catch any newly created window.

### Simple Explanation on usage
1. Use WinWaitExclusion(,,True) to Initalize/Reset the Exclusion list to contain all your current existing windows
2. If you're using AHK's Run function to run your app, do it now before Step 3.
3. Use WinWaitExclusion(WinTitle, Timeout) to wait until your window is found. The Timeout parameter is optional. Omitting the WinTitle parameter will match any window.
4. Done.

### Example: Matching the next 3 new windows
```
WinWaitExclusion(,,3) ; initialize the exclusion list
Loop 3 {
    myFoundID := Fn_WinWaitExclusion() ; matches any new window and stores the ID into the variable myFoundID.
    Msgbox WinGetTitle(myFoundID) ; displays the window name of the found window
}
```
