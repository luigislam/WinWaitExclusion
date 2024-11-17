WinWaitExclusion(WinTitle?, TimeOutinMilliseconds?, ifTrue_ResetExclusion:=false){
    Static myExclusionMap := Map()
    If ifTrue_ResetExclusion{
        myExclusionMap := Map()
        For Index, Value in WinGetList()
            myExclusionMap[Value] := false

    }
    Else {
        EndTime := A_TickCount + (TimeOutinMilliseconds??0)
        Loop {
            For Index, Value in WinGetList(WinTitle?)
                If !myExclusionMap.Has(Value) and (myExclusionMap[Value] := True)
                    Return Value
            If isSet(TimeOutinMilliseconds)
                If (TimeOutinMilliseconds = False) or (TimeOutinMilliseconds && (A_TickCount - EndTime > 0))
                    Break
            Sleep 1
        }
    }
}
