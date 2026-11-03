# Roblox Garden Game

GrowGardenLite is a lightweight Roblox game that simulates a garden with growing plants, interactive NPCs, and a shop system. This project includes basic graphics and visual effects to enhance the gaming experience. It is designed to be easy to set up and use, making it ideal for developers looking to create a simple garden game in Roblox.

## Install

1. Download the project files from the GitHub repository.
2. Open Roblox Studio.
3. Create a new Roblox place or open an existing one.
4. Place the scripts from the `src` folder into their respective locations in Roblox Studio:
   - `garden_growth.server.lua` should be placed in ServerScriptService.
   - `npc_interaction.server.lua` should be placed in ServerScriptService.
   - `shop_system.server.lua` should be placed in ServerScriptService.
   - `graphics.client.lua` should be placed in StarterPlayerScripts.

## Use

1. **Garden Growth System**:
   - The garden growth system is handled by `garden_growth.server.lua`.
   - Plants will grow over time, and visual effects will be displayed when they grow.
   - To create a new plant, use the `createPlant` function with a unique plant ID and plant type.

2. **NPC Interaction**:
   - The NPC interaction system is managed by `npc_interaction.server.lua`.
   - NPCs will display dialogue when interacted with.
   - To add a new NPC, define it in the `npcs` table and ensure it is placed in the game workspace.

3. **Shop System**:
   - The shop system is implemented by `shop_system.server.lua`.
   - Players can purchase items from the shop using coins.
   - To add new items to the shop, define them in the `shopItems` table.

4. **Graphics and Visual Effects**:
   - The `graphics.client.lua` script handles basic graphics and visual effects.
   - Visual effects are displayed when plants grow.
   - NPC dialogue is displayed as billboard GUIs above the player's head.
   - The shop UI is displayed as a screen GUI when the player interacts with the shop.

---

More Roblox script projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/5ab958ff-3ac0-46e1-a3dc-7bf491b6bed3?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=5ab958ff-3ac0-46e1-a3dc-7bf491b6bed3
