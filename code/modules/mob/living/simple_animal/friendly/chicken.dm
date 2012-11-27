//Chicken
/mob/living/simple_animal/chicken
	name = "chicken"
	desc = "It's a chicken!"
	icon_state = "chicken"
	icon_living = "chicken"
	icon_dead = "chicken_dead"
	speak = list("Ко-ко-ко", "Куд-кудах!")
	speak_emote = list("crows")
	emote_hear = list("crows")
	emote_see = list("shakes its head", "shivers")
	speak_chance = 10
	turns_per_move = 5
	see_in_dark = 6
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	response_help  = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm   = "kicks the"
	var/turns_since_scan = 0
	var/mob/living/simple_animal/mouse/movement_target
	min_oxy = 16 //Require atleast 16kPA oxygen
	minbodytemp = 223		//Below -50 Degrees Celcius
	maxbodytemp = 323	//Above 50 Degrees Celcius

/mob/living/simple_animal/chicken/Life()
	//MICE!
	if((src.loc) && isturf(src.loc))
		if(!stat && !resting && !buckled)
			for(var/mob/living/simple_animal/mouse/M in view(1,src))
				if(!M.stat)
					M.splat()
					emote(pick("\red splats the [M]!","\red toys with the [M]","worries the [M]"))
					movement_target = null
					stop_automated_movement = 0
					break
	..()

	if(!stat && !resting && !buckled)
		turns_since_scan++
		if(turns_since_scan > 5)
			walk_to(src,0)
			turns_since_scan = 0
			if((movement_target) && !(isturf(movement_target.loc) || ishuman(movement_target.loc) ))
				movement_target = null
				stop_automated_movement = 0
			if( !movement_target || !(movement_target.loc in oview(src, 3)) )
				movement_target = null
				stop_automated_movement = 0
				for(var/mob/living/simple_animal/mouse/snack in oview(src,3))
					if(isturf(snack.loc) && !snack.stat)
						movement_target = snack
						break
			if(movement_target)
				stop_automated_movement = 1
				walk_to(src,movement_target,0,3)

//RUNTIME IS ALIVE! SQUEEEEEEEE~
/mob/living/simple_animal/chicken/Shepard
	name = "Shepard"
	desc = "Глава анимуса."
	speak = list("Анимус самый лучший!", "АНИМУС ВПЕРДЕ!", "А у меня педали есть!")

