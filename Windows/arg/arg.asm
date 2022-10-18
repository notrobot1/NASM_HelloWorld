;https://www.nasm.us/xdoc/2.11.08/html/nasmdoc6.html


NULL EQU 0
;EXTERN Импорт символов из других модулей
extern _ExitProcess@4
extern _GetCommandLineA@16
extern _GetCommandLineW@0
;shell32.dll
extern _CommandLineToArgvW@8


;Экспорт символов в другие модули
global Start 


;инициализированные данные
;section .data
;	argcstr     db `argc = %d\n\0`      ; backquotes for C-escapes
;    argvstr     db `argv[%u] = %s\n\0`

;неинициализированные данные
section .bss
 ;RESB 1 allocates 1 byte.
 ;RESW 1 allocates 2 bytes.
 ;RESD 1 allocates 4 bytes.
 ;RESQ 1 allocates 8 bytes.
 ;varname resd 1
 ; std_addr resd 1

;Code
section .text



    ; Главная функция
	Start:
		push    ebp
		mov     ebp, esp
		sub     esp, 4

		call    _GetCommandLineW@0

		lea     ecx, [ebp - 4]          ; need the address of local
		push    ecx                     ; указатель на номер элемента массива
		push    eax                     ; указатель на строку "D:\\arg.exe" arg
		call    _CommandLineToArgvW@8

		push    dword [ebp - 4]     ; кладем в стек количество аргументов
		mov dword [ebp-30], eax
		mov eax, 4
		mov ecx, dword [ebp-30]
		mov edx, dword [ecx+eax] ;сюда помещаем второй элемент массива
			
	; Завершение программы
	exit:
        push    NULL
        call    _ExitProcess@4
