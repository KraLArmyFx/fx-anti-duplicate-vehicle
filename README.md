# fx-anti-duplicate-vehicle

A FiveM server-side security script that prevents spawning or duplicating vehicles with the **same license plate**.  
It automatically detects duplicate vehicle entities and removes them to block exploit abuse, macro spawning, and unintended vehicle duplication.

Created by **KraLArmyFx**.

---

## 🚧 Why Use This?

In some servers, players (or mod menus) can:

- Spawn multiple copies of the **same vehicle** with identical license plates.
- Abuse `/car` or `/givecar` commands to flood the world with clones.
- Bypass garage systems and cause syncing issues with repeated spawns.

This script **solves all of that** by automatically identifying and cleaning up these duplicates.

---

## ✅ Features

- 🛑 Detects and prevents **vehicle plate duplication**
- 🧹 Automatically deletes repeated vehicles nearby
- 🔒 Optional SQL-based whitelist from your owned vehicle table
- 🔁 Works on all framework setups (standalone / QBCore / ESX / Ox)
- ⚙️ Fully configurable: timing, range, behavior
- 🧼 Lightweight and performance-safe

---

## ⚙️ Configuration

Located in `config.lua`

```lua
Config.UseSQLWhitelist = true                           -- Enable SQL-based plate whitelist
Config.SQLVehicleTable = "player_vehicles"              -- Your vehicle ownership table

Config.AutoDeleteDuplicate = true                       -- Auto-remove duplicate vehicle

Config.EntityCreatedWaitTime = 500                      -- Wait time before checking (in ms)
Config.DuplicateScanRange = 50.0                        -- Nearby radius to check for same plate

Config.DebugPrint = false                               -- Debug console logging
