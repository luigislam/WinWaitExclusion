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
            If Type(pTypeValue) = "Array"
                For Index, Value in pTypeValue
                    DeleteArray.Push(Value)
        }
        IndexSubtracted := 0
        For eIndex, eValue in this.Exclusions {
            For dIndex, dValue in DeleteArray {
                If this.Exclusions[eIndex-IndexSubtracted] = dValue{
                    this.Exclusions.RemoveAt(eIndex-IndexSubtracted)
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
            If Type(pTypeValue) = "Array"
                For Index, Value in pTypeValue
                    DeleteArray.Push(Value)
        }
        IndexSubtracted := 0
        For eIndex, eValue in EditArray {
            For dIndex, dValue in DeleteArray {
                If EditArray[eIndex-IndexSubtracted] = dValue{
                    EditArray.RemoveAt(eIndex-IndexSubtracted)
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
            If Type(pTypeValue) = "Array"
                For Index, Value in pTypeValue
                    CopyArray.Push(Value)
        }
        For Index, Value in CopyArray
            ReceivingArray.Push(Value)
    }
}
