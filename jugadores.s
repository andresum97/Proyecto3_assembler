.data
.align 2
	posicion1: .word 0
	posicion2: .word 0
	mensaje1: "Es turno del jugador 1: "
	mensaje2: "Es turno del jugador 2: "
	mover: "Usted se ha movido "

.text
.align 2

@@Subrutina de primer jugador*********
@@Sirve para mover al jugador 1 dependediendo de las condiciones que le salen en el dado
@@Parametros:
@@	r0:direccion de cuanto dio los dados
@@	r1: cantidad de paso que lleva el personaje
@@Retorno:
@@	r0: pasos que dio el jugador, si para adelante o atras
@*************************************

.global primerjugador
primerjugador:
	push{r4-r6,lr}


	ldr r0,r5  @Asignar el numero que salio en el dado
	ldr r0,[r0]
	ldr r1,r6  @Asignar el numero de pasos que lleva el personaje
	ldr r1,[r1]   

	dados	.req r0    @alias para trabajarlo mas facil
	personaje .req r1
	@@Si el dado pose los valores 3,6,9,12 el personaje debe retroceder 10 pasos
	cmp dados,#3 @@Compara con el valor 3
	subeq personaje,personaje,#10
	cmp dados,#6
	subeq personaje,personaje,#10
	cmp dados,#9
	subeq personaje,personaje,#10
	cmp dados,#12
	subeq personaje,personaje,#10
	addne personaje,personaje,dados
	@@Comparar los movimientos del personaje, y ver que no sean menores a 0 o mayores a 50.
	cmp personaje,#0    
	movlt personaje,#0
	cmp personaje, #50
	bgt victoria1

	cmp personaje, #50
	bgt terminar

	@@Cargar los pasos que dio el personaje
	ldr r0,

	.unreq personaje
	.unreq dados
	pop{r4-r6,pc}


@@Subrutina de segundo jugador*********
@@Sirve para mover al jugador 2 dependediendo de las condiciones que le salen en el dado
@@Parametros:
@@	r0:direccion de cuanto dio los dados
@@	r1: cantidad de paso que lleva el personaje
@@Retorno:
@@	r0: pasos que dio el jugador, si para adelante o atras
@*************************************
.global segundojugador
segundojugador:
	push{r4-r7,lr}

	b random
	
	ldr r0,r5  @Asignar el numero que salio en el dado
	ldr r0,[r0]
	ldr r1,r7  @Asignar el numero de pasos que lleva el personaje
	ldr r1,[r1]   

	dados	.req r0    @alias para trabajarlo mas facil
	personaje .req r1
	@@Si el dado pose los valores 3,6,9,12 el personaje debe retroceder 10 pasos
	cmp dados,#3 @@Compara con el valor 3
	subeq personaje,personaje,#10
	cmp dados,#6
	subeq personaje,personaje,#10
	cmp dados,#9
	subeq personaje,personaje,#10
	cmp dados,#12
	subeq personaje,personaje,#10
	addne personaje,personaje,dados
	@@Comparar los movimientos del personaje, y ver que no sean menores a 0 o mayores a 50.
	cmp personaje,#0    
	movlt personaje,#0
	cmp personaje, #50
	bgt v2
	cmp personaje, #50
	bgt terminar


	@@Cargar los pasos que dio el personaje
	ldr r0,

	.unreq personaje
	.unreq dados
	pop{r4-r7,pc}


random:
	bl aleatorios
	and r0,#15
	cmp r0,#2
	blt random
	cmp r0,#12
	bgt random
	mov r1,r0

@Cada uno llama a su respectivo mensaje de victoria y lo imprime
v1:
	ldr r0,=victoria1
	bl puts

v2:
	ldr r0,=victoria2
	bl puts

@mensajes de victoria para cada jugador
victoria1:
	.asciz "Felicidades jugador 1 ES EL GANADOR!!\n"

victoria2:
	.asciz "Felicidades jugador 2 ES EL GANADOR!!\n"

despedida:
	.asciz "Gracias por jugar."
	
@Permite la salida del programa, igual se encuentra en el main
terminar:
	/*Se imprime un mensaje de despedida*/
	ldr R0,=despedida
	bl puts

	/*salida correcta*/
	mov R0, #0
	mov R3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr