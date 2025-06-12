# NASM_HelloWorld
Простые программы написанные на nasm 

Компиляция Windows:
`nasm.exe -fwin32 .\name.asm`
`GoLink.exe /entry:Start /console kernel32.dll user32.dll .\msg.obj`



# x86 (32-битная архитектура) имеет набор регистров общего назначения, и каждый из них имеет свой младший (низкий) байт. Ниже приведены регистры и их младшие байты:

   [*] EAX (Extended Accumulator):
        Младший байт: AL (Access Low).

   [*] EBX (Base Register):
        Младший байт: BL.

   [*] ECX (Count Register):
        Младший байт: CL.

   [*] EDX (Data Register):
        Младший байт: DL.

   [*] ESI (Source Index).

   [*] EDI (Destination Index).

   [*] EBP (Base Pointer).

   [*] ESP (Stack Pointer).


   # Radare2 command
   > r2 main - запусть программу

   > ie - посмотреть входную точку 

   > ood - переоткрыть программу в режиме деббага
   
   > dr - просмотреть значения в регистрах 
   
   > ds шаг без захода

   > dc отпустить программу

   > px 10 @ 0x0804a000 - прочитать значение по указателю

 >px 10 @ ecx прочитать значение из регистра

>db установить брек поинт db- удалить брек поинт

>afl распечатать функции


# NASM сравнение
  
  ``` 
    ; Сравниваем AL с BL
    cmp al, bl

    ; Если байты равны, переходим к метке equal
    je equal
    ; Если байты не равны, переходим к метке not_equal
    jne not_equal
```
# Nasm обнулить значения в регистре с сохранением младшего байта

```
    mov  ebx, 0x08040034  ; Загружаем значение в ebx
    and  ebx, 0xFF        ; Применяем маску 0xFF (младший байт) к ebx
    ; Теперь ebx содержит младший байт 0x34 и остальные байты обнулены
```
