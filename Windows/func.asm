; создаем функцию
NULL EQU 0
STD_OUTPUT_HANDLE EQU -11
STD_INPUT_HANDLE EQU -10
extern _GetStdHandle@4
extern _WriteFile@20
extern _WriteConsoleA@20
extern _ExitProcess@4
extern _ReadConsoleA@16

global Start

section .data

	Message db "hello from Me", 0Dh, 0Ah ; Объявляем строку
	
section .bss
	StandardHandle resd 1
	Written resd 1

section .text

    ; функция возвращает длину передаваемой переменной
	Len:
	
		push  ebx
		push  ecx
		
		mov   ebx, edi            
		xor   al, al                               
		mov   ecx, 0xffffffff     
		repne scasb               ; Повторить следующую строковую операцию, если не равно 
		sub   edi, ebx            ; sub приемник, источник (приемник = приемник - источник) length = offset of (edi - ebx)
		mov   eax, edi            
		
		pop   ebx
		pop   ecx
		ret                

	; Функция выводит на экран
	Print:
		push  edi
		push  ecx
		
	
		push STD_OUTPUT_HANDLE
        call _GetStdHandle@4
        mov dword [StandardHandle], EAX
	    push NULL
        push Written
        push ecx ;длина текста для вывода на экран
        push edi ;текст для вывода на экран
        push dword [StandardHandle]
        call _WriteFile@20
		
		pop   ebx
		pop   ecx
		ret


	; Главная функция
	Start:
	    
		; Помещаем сообщение в еди
	    mov edi, Message
		call Len
		mov ecx, eax ; помещаем результат Len в eсx
		sub ecx,1 ;отнимаем от длины 5 
		
		mov edi, Message
		call Print
		mov ebx, eax


    exit:

        push    NULL
        call    _ExitProcess@4