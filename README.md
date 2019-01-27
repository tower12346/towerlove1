# towerlove1
Run in Love2D, download it from https://love2d.org/ and download this project as a folder. Load the folder using Love2D. To quickly restart the game press '0'. 

The player object is the yellow square. Use the directional keys to move around the player object and the WASD keys to fire small red bullets. Firing in the horizontal directions are avaliable from the start however the ability to fire up and down are locked behind collecting blue circle collectibles. White squares are platforms that are able to be jumped on. When the player moves towards the edge of the screen, if there is an area beyond the edge then the screen will scroll to the next area. 

Enemies are green squares. They move around and jump randomly. They periodically spawn in at set locations within the map. When the player touches an enemy the player is dealt 1 damage per frame. The player has 100 HP to start with and when player HP hits 0 the player dies and the game must be restarted. These enemies can be destroyed using the red bullets fired by the player, and when the enemies are damaged they gradually turn red. Once the enemy loses its HP and becomes completely red it dies and disappears. When an enemy dies the score increments by 1. 

The small red bullets fired by the player are also considered stackable temporary platforms, and can be used to gain height or create bridges for the player. This strategy is sometimes necessary to collect collectibles to gain new abilities. 

Around the end of the game there is a boss enemy that acts similarly to other enemies, but is much larger, has much more HP, and fires large red bullets of its own that deals 20 damage to the player should those bullets connect. The boss's HP is visible on-screen. It is defeated in the same manner as other enemies. 
