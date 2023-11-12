Pitch:  
Play as Harper Chase stuck in a mysterious maze with deadly enemies. Harness mysterious runes to
augment your abilities. Discover secrets, and unravel the mysteries of the maze. Can you escape? Or
will you be forgotten amongst the vines?  

Synopsis:  
Harper Chase wakes up in a forested maze with a sword and no memories of how they arrived there. 
With nothing else to go on, they progress into the maze, filled with increasingly deadly enemies, and 
strange runes, desperate to find a way out. As you play as Harper, you will discover runes that change 
the way you can move through the levels, allowing you to climb walls and dash over large gaps. These 
new abilities allow you to access places that you couldn’t, when you first passed them by. Secret areas 
hide consumables, new runes, and lore of the maze. Can you find the exit? Be wary of who might wait 
for you there.  

Objective:  
	Complete the game with as many points as possible  
	
Mechanics:  
	1. Left and right movement  
	1. Jump  
	1. Swing Sword  
	1. Wallcling (obtained in game)  
	1. Dash (obtained in game)(To be Implemented)  
	1. Save mechanic (only available at benches)  

So, this is using my GODOT tutorial from before, and implementing more items as we go. At this point it is a very different game than the hello-world version.  
Some bug fixes have gone into this version, notably: self-pogo, UI bugs, and UI Readability bugs.  
A health and damage system is in place, though still rudimentary. There is an I-Frame system, but it needs debugging still.  
The levels are still using a basic undecorated tileset, so there's no "forest" yet, but I have the tileset, and just need to implement it.  
When that happens, I also want to redesign the levels from a "test" layout, to something thats more appropriate to the world.  
There are no bosses yet, and I only have some rudimentary AI for the current enemies, so thats a future plan.  
Dash power-up is still in the works, but first I plan on creating a splash screen for item pickups, because they look ugly in game.  
There is still hardlock potential, until i figure out how to make destructible walls. Dont enter the "pit" level behind the collisionless wall without wallcling.  

ToDo (priority order): 
1. change collision-less wall/s to destructible wall/s  
1. Add mechanic-get splash screen and remove text in world  
1. Add dash power-up  
1. sound design  
1. Update health system to be more visually appealing  
1. level design overhaul/New Tileset implementation  
1. new enemies  


ToDo (potentially outside the scope of this class/complete if possible):
1. boss/es  
1. in-world lore  
1. more abilities  
1. ability upgrades  
1. minor Bug fixing  
1. balancing  

ToDo (definitely outside the scope of this class):
1. Merge with GF's game idea(?)  
1. Sprite overhaul 2.0  
