So, this is using my GODOT tutorial from before, and implementing more items as we go. At this point it is a very different game than the hello-world version.  
I've made major progress since last time, changing sprites, attack method, the level load system, ability implementation, adding a tutorial splash, and more.  
Notably, I've implemented the save system, using Godot's built in file.write functions. I'm not entirely sure what the encoding is, but it functions well for serialization.
I had originally planned on finding my own way to write a binary file, that I could read and implement, and had also thought about using JSON serialization.  
This method seemed easier than the binary system, and while it may be more complex than I need (binary being the least complex option), changes are super easy to implement, and it's generally low future technical burden.  
When I looked into the JSON methodology, I found that Godot has built in JSON serialization, but everything I read from 3rd party sources implored the reader to avoid it, as apparently the implementation is slow and unwieldy.  
This method is simple, and appears to just be string parsing, though the character encoding seems to elude my text editors and IDEs, so debugging could theoretically be an issue in the future.  
As it currently stands, we are saving the room that the player saved in, their score at the time, their deaths, and their abilities acquired.  
In the video, you'll see that there is a bug with the score, that it doesn't display until the score is updated, but it does in fact keep the score from before. I'm also forcing a late level start to cut down on video time, so I can demonstrate the saving of the wallcling mechanic.

ToDo (priority order): 
1. Readable UI update  
1. level design overhaul/New Tileset implementation  
1. change collision-less wall/s to destructible wall/s  
1. Add health/damage system  
1. Change power-up tutorial to splash screen  
1. Add dash power-up  
1. new enemies  
1. sound design  

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
