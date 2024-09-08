Class WinWaitExclusionClass {
    __New(){
        this.Exclusions := WinGetList()
    }
    
    Exclusions := []

    WinWait(ParamWinTitle){
        Loop {
            CheckingArray := WinGetList(ParamWinTitle)
            this.DeleteArrayValues(CheckingArray, this.Exclusions)
            If CheckingArray.Length {
                this.CopyArrayValues(this.Exclusions, CheckingArray)
                Return CheckingArray[1]
            }
        }
    }

    WinWaitArray(ParamWinTitle, ParamCount){
        CompiledArray := []
        Loop {
            CheckingArray := WinGetList(ParamWinTitle)
            this.DeleteArrayValues(CheckingArray, this.Exclusions)
            this.DeleteArrayValues(CheckingArray, CompiledArray)
            If CheckingArray.Length {
                For Index, Value in CheckingArray {
                    CompiledArray.Push(Value)
                }
            }
            If CompiledArray.Length > ParamCount {
                Throw "Error Bruh"
            }
            Else If CompiledArray.Length = ParamCount {
                this.CopyArrayValues(this.Exclusions, CompiledArray)
                Return CompiledArray
            }
            Sleep 1
        }
    }

    DeleteExclusionValues(ParamVariadic*){
        DeleteArray := []
        For pIndex, pTypeValue in ParamVariadic {
            If Type(pTypeValue) = "Integer"
                DeleteArray.Push(pTypeValue)
            Else If Type(pTypeValue) = "Array"
                For Index, Value in pTypeValue
                    DeleteArray.Push(Value)
        }
        IndexSubtracted := 0
        Loop this.Exclusions.Length {
            CurrentIndex := A_Index - IndexSubtracted
            For dIndex, dValue in DeleteArray {
                If this.Exclusions[CurrentIndex] = dValue{
                    this.Exclusions.RemoveAt(CurrentIndex)
                    IndexSubtracted += 1
                    break
                }
            }
        }
    }
      

    DeleteArrayValues(EditArray, ParamVariadic*){
        DeleteArray := []
        For pIndex, pTypeValue in ParamVariadic {
            If Type(pTypeValue) = "Integer"
                DeleteArray.Push(pTypeValue)
            Else If Type(pTypeValue) = "Array"
                For Index, Value in pTypeValue
                    DeleteArray.Push(Value)
        }
        IndexSubtracted := 0
        Loop EditArray.Length {
            CurrentIndex := A_Index - IndexSubtracted
            For dIndex, dValue in DeleteArray {
                If EditArray[CurrentIndex] = dValue{
                    EditArray.RemoveAt(CurrentIndex)
                    IndexSubtracted += 1
                    break
                }
            }
        }
    }

    CopyArrayValues(ReceivingArray, ParamVariadicToCopy*){
        CopyArray := []
        For pIndex, pTypeValue in ParamVariadicToCopy {
            If Type(pTypeValue) = "Integer"
                CopyArray.Push(pTypeValue)
            Else If Type(pTypeValue) = "Array"
                For Index, Value in pTypeValue
                    CopyArray.Push(Value)
        }
        For Index, Value in CopyArray
            ReceivingArray.Push(Value)
    }
}
