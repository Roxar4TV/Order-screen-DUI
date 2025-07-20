# 📺 Order-screen-DUI

A lightweight FiveM resource for managing in-game order screens.

---

## 📖 About
This script allows you to create, complete, and clear orders displayed on a screen prop in-game.  

✅ Easy to configure
✅ Supports custom props and textures
✅ Simple to integrate with existing systems

---

## ⚙️ Trigger Events

### [ENG]
- `TriggerEvent("orderscreen:order:add")` – Create a new order
- `TriggerEvent("orderscreen:order:end", id)` – Mark order as complete
- `TriggerEvent("orderscreen:order:clear", id)` – Clear a completed order

---

### [PL]
- `TriggerEvent("orderscreen:order:add")` – Tworzenie nowego zamówienia
- `TriggerEvent("orderscreen:order:end", id)` – Ukończenie zamówienia
- `TriggerEvent("orderscreen:order:clear", id)` – Usunięcie ukończonego zamówienia

---

## 🔧 Configurable Values
### [ENG]
- `tvPropHash` – Prop hash name
- `tvPropTxtHash` – Screen texture prop name
- `tvPropCoords` – Prop coordinates

### [PL]
- `tvPropHash` – Nazwa hash propa
- `tvPropTxtHash` – Nazwa tekstury dla podanego w `tvPropHash` propa
- `tvPropCoords` – Koordynaty propa

---

## 📝 License
This project is licensed under the **GNU General Public License v3.0**.  

You are free to:
- Use, share, and modify this script.  
- Distribute modified versions under the same license.   

For details, see: [https://www.gnu.org/licenses/gpl-3.0.en.html](https://www.gnu.org/licenses/gpl-3.0.en.html)

Author: **Roxar4TV**  
Discord: **roxar4tv**