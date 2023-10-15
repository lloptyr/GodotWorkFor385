So, this is using my GODOT tutorial from before, and implementing more items as we go.

Currently the game objective is to collect points by gathering coins and defeating enemies.

I had already implemented jumping, jumping on enemies, getting hit by enemies, and portals as interactions.

I have since added "wallcling", so the player can hold left or right to slide slowly down a wall, and jump off of the wall.

I have also implemented "collision-less walls", which once I have more time to change the game, will turn into destructible walls.

The one collision-less wall I have is currently indicated by a missing texture, and leads to a portal to a new level, where you need to use wallcling to escape.

When wallcling is locked behind an item later, it will allow for designing levels with multiple "parts", where the player can come back to progress after they've collected it.

ToDo: 
	1. implement a weapon
	2. change defeating enemies from jumping on them to using weapon on them
	3. update sprites
	4. change collision-less walls to destructible walls
	5. update wallcling to be locked behind an item
	6. level design overhaul
	7. sound design
