;выводит всплывающее сообщение с вопросом да или нет

NULL EQU 0
MB_DEFBUTTON EQU 100h
IDNO EQU 7
MB_YESNO EQU 4
extern _MessageBoxA@16
extern _ExitProcess@4


global Start

section .data
	Message db "hello", 0
	MessageTitle db "Title", 0



section .text
	Start:
 	    push MB_YESNO | MB_DEFBUTTON
		  push MessageTitle
		  push Message
		  push NULL
      call _MessageBoxA@16
      cmp EAX, IDNO ; сравниваем значение еах с idno в регистр еах кладется результат нажатия
      je Start ; прыгаем в начало
		  push NULL ; иначе завершаем
      call    _ExitProcess@4
	  
