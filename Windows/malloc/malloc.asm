
;https://www.nasm.us/xdoc/2.11.08/html/nasmdoc6.html


NULL EQU 0

;EXTERN Импорт символов из других модулей
extern _ExitProcess@4
extern _WriteFile@20
extern _GetStdHandle@4

;ucrtbased.dll 
;https://strontic.github.io/xcyclopedia/library/ucrtbase.dll-ED27C615D14DADBE15581E8CB7ABBE1C.html
extern _o_malloc

;Экспорт символов в другие модули
global Start 


;инициализированные данные
section .data
    ;объвляем массив                                                                                                                                                                                                                                                                                     string 38
	array   dw 0x57, 0x51, 0x6a, 0xf5, 0xe8, 0xf9, 0x1f, 0x00, 0x00, 0xa3, 0x38, 0x20, 0x40, 0x00, 0x6a, 0x00, 0x68, 0x3c, 0x20, 0x40, 0x00, 0xb9, 0x0f, 0x00, 0x00, 0x00, 0xbf, 0xb3, 0x20, 0x40, 0x00, 0x51, 0x57, 0xff, 0x35, 0x38, 0x20, 0x40, 0x00, 0xe8, 0xda, 0x1f, 0x00, 0x00, 0x5b, 0x59, 0xc3, 0x66, 0x6c, 0x61, 0x67, 0x7b, 0x71, 0x77, 0x65, 0x72, 0x74, 0x79, 0x31, 0x32, 0x33, 0x7d
	

;неинициализированные данные
section .bss
	StandardHandle resd 1
	Written resd 1
	;поинтер на скрытую функцию
	Hidden resq 1
	;переменная хранит перевернутые смещения
	Reverse resd 1
	


;Code
section .text

    ;расчитываем смещение вызова
    Calculation:
	    
	    push ebp
		
		;ecx - что мы хотим вызвать
		mov ecx, esi
		;от адреса который мы хотим вызвать отнимаем размер команды (5)
		sub ecx, 5
		;от результата отнимаем адресс который хотим вызвать
		;ecx хранит смещение которое надо перевернуть
		sub ecx, eax
		
		;кладем в переменную перевернутые байты
		;+100 - перемещаем переменную что бы она не наехала на массив array
		mov [Reverse+100], ecx 
		;расчитаный адрес смещения кладем в edx
		mov edx, [Reverse+100+0]
		;eax = e8 (команда call). eax+1 первый байт адреса, кладем в него младший бит edx
		mov [eax+1], dl
		;Перезаписываем edx следующим расчитаным байтом
		mov edx, [Reverse+100+1]
		mov [eax+2], dl
		mov edx, [Reverse+100+2]
		mov [eax+3], dl
		mov edx, [Reverse+100+3]
		mov [eax+4], dl		
		pop ebp
		ret
		
		
	; Функция выводит на экран
	;Print:
	;	push  edi
	;	push  ecx
		
	
	;	push -11
    ;    call _GetStdHandle@4
    ;    mov dword [StandardHandle], eax
	;    push NULL
    ;    push Written
    ;	 mov ecx, 15
	;	mov edi, Hidden+37
    ;    push ecx ;длина текста для вывода на экран
    ;    push edi ;текст для вывода на экран
    ;    push dword [StandardHandle]
    ;    call _WriteFile@20
		
	;	pop   ebx
    ;	pop   ecx
	;	ret




    ; Главная функция
	Start:
	
	    ;malloc 1000 flhtcjd
		push 0x3e8
		call _o_malloc
		
		;кладем поинтер на выделенные адреса в переменную Hidden
        mov [Hidden], eax
		
		;начинаем цикд
		mov edx, 0x0
		M1:
		;т.к. у нас каждый элемент массива занимает 2 байта *2
		mov cx, [array+edx*2]
		;поинтер на маллок + номер итерации кладем байт из массива
		mov byte [Hidden+edx], cl
		;увеличиваем счетчик
		add edx, 0x1
		;сравниваем edx с 62
		cmp edx, 0x3e
		;если edx не равно 62 (0x3e) то повторяем M1
		jne M1
	   
	    
	
		mov eax, Hidden+4 ;откуда вызываем
		mov esi, 0x0040300c ;что вызываем
		call Calculation
		
		;+39 адресс команды е8 из массива
		mov eax, Hidden+39 
		mov esi, 0x00403006
		call Calculation
				
		;Вызываем динамическую функцию
		call Hidden
		
		;надо сделать free
	   
	   
	; Завершение программы
	exit:
       push    NULL
       call    _ExitProcess@4
