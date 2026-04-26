            option  casemap:none
nl          =       10
maxLen      =       256

            .const
titleStr    byte    "Listing 4-6", 0
prompt      byte    "Input a string; ", 0
fmtStr1     byte    "After strncpy, resultStr='%s'", nl, 0
fmtStr2     byte    "After strncat, resultStr='%s'", nl, 0
fmtStr3     byte    "After strcmp (3), eax=%d", nl, 0
fmtStr4     byte    "After strcmp (4), eax=%d", nl, 0
fmtStr5     byte    "After strcmp (5), eax=%d", nl, 0
fmtStr6     byte    "After strchr, rax='%s'", nl, 0
fmtStr7     byte    "After strstr, rax='%s'", nl, 0
fmtStr8     byte    "resultStr length is %d", nl, 0

str1        byte    "Hello, ", 0
str2        byte    "World!", 0
str3        byte    "Hello, World!", 0
str4        byte    "hello, world!", 0
str5        byte    "HELLO, WORLD!", 0

            .data
strLength   dword   ?
resultStr   byte    maxLen  dup (?)

            .code
            externdef   printf:proc
            externdef   readLine:proc
            externdef   malloc:proc
            externdef   free:proc

            ; some c string functions from the string.h header
            externdef   strlen:proc         ; size_t strlen(char *str)
            externdef   strncat:proc        ; char *strncat(char *dest, const char *src, size_t n)
            externdef   strchr:proc         ; char *strchr(const char *str, int c)
            externdef   strcmp:proc         ; int strcmp(const char *str1, const char *str2)
            externdef   strncpy:proc        ; char *strncpy(char *dest, const char *src, size_t n)
            externdef   strstr:proc         ; char *strstr(const char *inStr, const char *search4)

            public getTitle
getTitle    proc
            lea     rax, titleStr
            ret
getTitle    endp

            public asmMain
asmMain     proc
            sub     rsp, 56

            lea     rcx, resultStr
            lea     rdx, str1
            mov     r8, maxLen
            call    strncpy

            lea     rcx, fmtStr1
            lea     rdx, resultStr
            call    printf
            
            lea     rcx, resultStr
            lea     rdx, str2
            mov     r8, maxLen
            call    strncat

            lea     rcx, fmtStr2
            lea     rdx, resultStr
            call    printf

            lea     rcx, resultStr
            lea     rdx, str3
            call    strcmp

            lea     rcx, fmtStr3
            mov     edx, eax
            call    printf

            lea     rcx, resultStr
            lea     rdx, str4
            call    strcmp

            lea     rcx, fmtStr4
            mov     edx, eax
            call    printf

            lea     rcx, resultStr
            lea     rdx, str5
            call    strcmp

            lea     rcx, fmtStr5
            mov     edx, eax
            call    printf

            ; demonstrate the use of strchr, which is the character finding function
            lea     rcx, resultStr
            mov     rdx, ','
            call    strchr

            lea     rcx, fmtStr6
            mov     rdx, rax
            call    printf

            ; demonstrate the use strstr, which is the string matching function
            lea     rcx, resultStr
            lea     rdx, str2
            call    strstr

            lea     rcx, fmtStr7
            mov     rdx, rax
            call    printf

            ; demonstrate the use strlen
            lea     rcx, resultStr
            call    strlen

            lea     rcx, fmtStr8
            mov     rdx, rax
            call    printf

            add     rsp, 56
            ret
asmMain     endp
            end

