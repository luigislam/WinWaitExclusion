Class WinWaitExclusionClass {
    ExclusionList := []

    Start(){
        this.ExclusionList := WinGetList()
    }

    WinWait(WinTitle:="", TimeOutSeconds:=false){
        EndTime := A_TickCount + (TimeOutSeconds * 1000)
        Loop {
            If TimeOutSeconds and (A_TickCount > EndTime)
                Return false
            CheckingArray := WinGetList(WinTitle)
            this.DeleteArrayValues(CheckingArray, this.ExclusionList)
            If CheckingArray.Length {
                this.CopyArrayValues(this.ExclusionList, CheckingArray)
                Return CheckingArray[1]
            }
        }
    }

    WinWaitArray(WinTitle:="", WindowCount:=1, TimeOutSeconds:=false){
        EndTime := A_TickCount + (TimeOutSeconds * 1000)
        CompiledArray := []
        Loop {
            If TimeOutSeconds and (A_TickCount > EndTime)
                Return CompiledArray
            CheckingArray := WinGetList(WinTitle)
            this.DeleteArrayValues(CheckingArray, this.ExclusionList)
            this.DeleteArrayValues(CheckingArray, CompiledArray)
            If CheckingArray.Length {
                For Index, Value in CheckingArray {
                    CompiledArray.Push(Value)
                }
            }
            If CompiledArray.Length > WindowCount {
                Throw "Error Bruh"
            }
            Else If CompiledArray.Length = WindowCount {
                this.CopyArrayValues(this.ExclusionList, CompiledArray)
                Return CompiledArray
            }
            Sleep 1
        }
    } 

    DeleteArrayValues(DeleteInThisArray, VariadicArrayValues*){
        DeleteList := this.MergeVariadicValues(VariadicArrayValues)
        IndexSubtracted := 0
        Loop DeleteInThisArray.Length {
            CurrentIndex := A_Index - IndexSubtracted
            For dIndex, dValue in DeleteList {
                If DeleteInThisArray[CurrentIndex] = dValue{
                    DeleteInThisArray.RemoveAt(CurrentIndex)
                    IndexSubtracted += 1
                    break
                }
            }
        }
    }

    CopyArrayValues(CopyToThisArray, VariadicArrayValues*){
        For Index, Value in this.MergeVariadicValues(VariadicArrayValues)
            CopyToThisArray.Push(Value)
    }

    MergeVariadicValues(InsertVariadicArray){
        ReturnList := []
        For pIndex, pTypeValue in InsertVariadicArray {
            If Type(pTypeValue) = "Integer"
                ReturnList.Push(pTypeValue)
            Else If Type(pTypeValue) = "Array"
                For Index, Value in pTypeValue
                    ReturnList.Push(Value)
        }
        Return ReturnList
    }
}
