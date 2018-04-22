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
	movgt personaje,#50

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
	movgt personaje,#50

	@@Cargar los pasos que dio el personaje
	ldr r0,

	.unreq personaje
	.unreq dados
	pop{r4-r7,pc}