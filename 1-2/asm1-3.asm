        .CODE
        option casemap:none ; Done to make ml64 case sensitive
        public asmFunc      ; Declaration of public function

asmFunc PROC
        
        ret                 ; Just return the control back to windows

asmFunc ENDP
        END
