/* Programa temario numero 5 */
/* Juan Guillermo Sandoval Lacayo, Alberto Andres Urizar */
/* 17577 / 17632 */


.text
.align 2
.global main
.type main,%function

main:

 	stmfd sp!, {lr} /*SP = R13 link register*/


	/*Se imprime la bienvenida*/
	ldr R0,=bienvenida
	bl puts
	/* Inicializa los valors de los jugadores en r6 y r7 para los jugadores respectivos */
	ldr r6,=pasos1
	ldr r6, [r6]
	ldr r7,=pasos2
	ldr r7, [r7]
	/* inicializa el dado en 0 */
	ldr r5,=dado
	ldr r5, [r5]
	b jugar

jugar:
	b jugador2
	b jugador1
	b jugar

jugador1:
	@llama a la funcion random para obtener el valor tirado
	b random

	ldr r0,[r0]
  

	dados	.req r5    @alias para trabajarlo mas facil
	avanzar .req r6

	@Si el dado pose los valores 3,6,9,12 el personaje debe retroceder 10 pasos
	cmp dados,#3 @@Compara con el valor 3
	subeq avanzar,avanzar,#10
	cmp dados,#6
	subeq avanzar,avanzar,#10
	cmp dados,#9
	subeq avanzar,avanzar,#10
	cmp dados,#12
	subeq avanzar,avanzar,#10

	@Si no es igual a ninguno de esos valores entonces avanza
	/* Guarda los valores que avanza */
	addne avanzar,avanzar,dados
	str r6,[R6]
	
	ldr r0,=pruebadado
	mov r1,r5
	bl printf
	bl getchar

	@@Comparar los movimientos del personaje, y ver que no sean menores a 0 o mayores a 50.
	cmp avanzar,#0  
	/* Si el valor es menor a 0, entonces resetea el valor a 0 */
	blt reset1

	@Si el valor es mayor a 49, es decir 50 o mas ya gano ese personaje
	cmp avanzar, #49
	bgt fin1

	@@Cargar los pasos que avanzo el personaje
	@@ldr r0,

	.unreq dados
	cmp avanzar,#50
	blt jugador2
	.unreq avanzar

jugador2:
	@llama a la funcion random para obtener el valor tirado
	b random

	ldr r0,[r0]

	dados	.req r5    @alias para trabajarlo mas facil
	avanzar .req r7

	@Si el dado pose los valores 3,6,9,12 el personaje debe retroceder 10 pasos
	cmp dados,#3 @@Compara con el valor 3
	subeq avanzar,avanzar,#10
	cmp dados,#6
	subeq avanzar,avanzar,#10
	cmp dados,#9
	subeq avanzar,avanzar,#10
	cmp dados,#12
	subeq avanzar,avanzar,#10
	
	@Si no es igual a ninguno de esos valores entonces avanza
	/* Guarda los valores que avanza */
	addne avanzar,avanzar,dados
	str r7,[r7]
	

	ldr r0,=pruebadado
	mov r1,r5
	bl printf
	bl getchar

	@@Comparar los movimientos del personaje, y ver que no sean menores a 0 o mayores a 50.
	cmp avanzar,#0  
	/* Si el valor es menor a 0, entonces resetea el valor a 0 */
	blt reset2

	@Si el valor es mayor a 50 ya gano ese personaje
	cmp avanzar, #49
	bgt fin2

	@@Cargar los pasos que avanzo el personaje
	@@ldr r0,

	.unreq dados
	cmp avanzar,#50
	blt jugador1
	.unreq avanzar

/* Regresa el valor avanzado del jugador 1 a 0 */
reset1:
	mov r6, #0
	str r6, [r6]
/* Regresa el valor avanzado del jugador 2 a 0 */
reset2:
	mov r7, #0
	str r7, [r7]

random:
	bl aleatorios
	and r0,#15
	cmp r0,#2
	blt random
	cmp r0,#12
	bgt random
	mov r5,r0

fin1:
	/*Se imprime un mensaje de despedida y la victoria del jugador 1*/
	ldr r0, =victoria1
	bl puts
	ldr R0,=despedida
	bl puts
	/*salida correcta*/
	mov R0, #0
	mov R3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

fin2:
	/*Se imprime un mensaje de despedida y la victoria del jugador 2*/
	ldr r0, =victoria2
	bl puts
	ldr R0,=despedida
	bl puts
	/*salida correcta*/
	mov R0, #0
	mov R3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

.data
.align 2


bienvenida:

	.asciz	" .----------------. .----------------. .----------------. .----------------. .----------------. .----------------. .----------------. \n | .--------------. | .--------------. | .--------------. | .--------------. | .--------------. | .--------------. | .--------------. |\n | | _____  _____ | | |  _________   | | |   _____      | | |     ______   | | |     ____     | | | ____    ____ | | |  _________   | |\n | ||_   _||_   _|| | | |_   ___  |  | | |  |_   _|     | | |   .' ___  |  | | |   .'    `.   | | ||_   \  /   _|| | | |_   ___  |  | |\n | |  | | /\ | |  | | |   | |_  \_|  | | |    | |       | | |  / .'   \_|  | | |  /  .--.  \  | | |  |   \/   |  | | |   | |_  \_|  | |\n | |  | |/  \| |  | | |   |  _|  _   | | |    | |   _   | | |  | |         | | |  | |    | |  | | |  | |\  /| |  | | |   |  _|  _   | |\n | |  |   /\   |  | | |  _| |___/ |  | | |   _| |__/ |  | | |  \ `.___.'\  | | |  \  `--'  /  | | | _| |_\/_| |_ | | |  _| |___/ |  | |\n | |  |__/  \__|  | | | |_________|  | | |  |________|  | | |   `._____.'  | | |   `.____.'   | | ||_____||_____|| | | |_________|  | |\n | |              | | |              | | |              | | |              | | |              | | |              | | |              | |\n | '--------------' | '--------------' | '--------------' | '--------------' | '--------------' | '--------------' | '--------------' |\n '----------------' '----------------' '----------------' '----------------' '----------------' '----------------' '----------------'	\n \n \n              #   ___         _     _       |          \n	  ***      #  <_*_>      o' \,=./ `o     |.===.     \n  	 (o o)     #  (o o)         (o o)        {}o o{}    \n ooO--(_)--Ooo-8---(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-\n"

pasos1:
	.word 0
pasos2:
	.word 0
dado:
	.word 0

pruebadado:
	.asciz "VALOR: %d \n"

victoria1:
	.asciz "Felicidades jugador 1 ES EL GANADOR!!\n"

victoria2:
	.asciz "Felicidades jugador 2 ES EL GANADOR!!\n"

despedida:
	.asciz "Gracias por jugar."