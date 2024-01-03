        .code
myProc  proc                    ;; Defining a function(called procedure) in  assembly
        ret                     ;; Return from the procedure
myProc  endp                    ;; End of the procedure definintion, this will transfer the control back to main

main    proc
        call    myProc
        ret
main    endp

        end
