; создаем функцию
NULL EQU 0
STD_OUTPUT_HANDLE EQU -11
STD_INPUT_HANDLE EQU -10
extern ExitProcess

extern system

%define COMAND "echo 12345 > test.txt " ;обвляем строку с командой 
%strlen length COMAND

global Start

section .data	
	comand db COMAND
	
;содержит статически размещенные переменные, которые объявлены, но им еще не присвоено значение	
section .bss
	;character resd 1

section .text

	; Главная функция
	Start:
		mov dword [esp], comand ; esp
		call system
		;mov eax, 0
	    
		
    exit:
        push    NULL
        call    ExitProcess