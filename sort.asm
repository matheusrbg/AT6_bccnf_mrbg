section .text
global sort

sort:
    push EBP
    mov EBP, ESP
    push EBX
    push ESI
    push EDI
   
    ;EBP + 12   é o tamanho do array
    ;EBP + 8   é o ponteiro do array
   
    mov ESI, [EBP+8]   ;ESI é o array
   
    ;ECX vai ser o numero para o final do array
    mov EAX, [EBP+12]
    mov ECX, 4
    mul ECX
    mov ECX, EAX 
    sub ECX, 4
   
    ;EAX vai ser i = 0
    xor EAX, EAX
   
    ;EBX vai ser j = final do array
    mov EBX, ECX
   
    ;We now call our recursive function that will sort the array
    call QuickRecursive
       
    ;Restoring the registers
    pop EDI
    pop ESI
    pop EBX
    pop EBP

    ret
    

;;Funcao recursiva QuickSort

QuickRecursive:
   
    ;se i >= j, sai da funcao
    cmp EAX, EBX
    jge end
   
    push EAX    ;salva o lowIndex
    push EBX    ;salva o highIndex
    add EBX, 4  ;j = high + 1
   
    ;EDI é o pivot
    ;pivot = array[lowIndex];
    mov EDI, [ESI+EAX]
   
    MainLoop:
        iIncreaseLoop:
            ;i++
            add EAX, 4

            ;If i >= j, sai do loop
            cmp EAX, EBX
            jge End_iIncreaseLoop
           
            ;If array[i] >= pivot, sai do loop
            cmp [ESI+EAX], EDI
            jge End_iIncreaseLoop
           
            ;Volta para o inicio do loop
            jmp iIncreaseLoop

        End_iIncreaseLoop:
       
        jDecreaseLoop:
       
            ;j--
            sub EBX, 4
           
            ;If array[j] <= pivot, sai do loop
            cmp [ESI+EBX], EDI
            jle End_jDecreaseLoop
           
            ;Volta para o inicio do loop
            jmp jDecreaseLoop

        End_jDecreaseLoop:
       
        ;If i >= j, não faz swap e termina o loop principal
        cmp EAX, EBX
        jge EndMainLoop
       
        ;senao, faz um swap no array[i] com o array [j]
        push dword[ESI+EAX]
        push dword[ESI+EBX]
       
        pop dword[ESI+EAX]
        pop dword[ESI+EBX]
       
        ;volta para o loop principal
        jmp MainLoop
       
    EndMainLoop:       
   
    ;Restaura o high index no EDI
    pop EDI
   
    ;Restaure o low index no ECX
    pop ECX
   
    ;If low index == j: nao faz swap
    cmp ECX, EBX
    je EndSwap
   
    ;Else: faz swap array[low index] com array[j]
    push dword[ESI+ECX]
    push dword[ESI+EBX]
       
    pop dword[ESI+ECX]
    pop dword[ESI+EBX]
       
    EndSwap:

    ;seta EAX de volta pro low index
    mov EAX, ECX
   
    push EDI    ;salva o high Index
    push EBX    ;salva j
   
    sub EBX, 4  ;salva EBX para j-1
   
    ;QuickSort(array, low index, j-1)
    call QuickRecursive
   
    ;Restaura 'j' pro EAX
    pop EAX
    add EAX, 4  ;seta EAX para j+1
   
    ;Restaura o high index para EBX
    pop EBX
   
    ;QuickSort(array, j+1, high index)
    call QuickRecursive
   
    end:

ret
