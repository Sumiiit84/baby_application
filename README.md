#  Baby & Mood Tracker App

A complete Flutter application to log baby activities (feeding, diaper, sleep) and track daily moods — built as part of my **Flutter Internship Assignment (1 Month)** at **Jayadhi Limited**.

---

## 🧾 Overview
The **Baby & Mood Tracker App** helps parents easily record and monitor their baby’s daily routines:
- Feeding schedules  
- Diaper changes  
- Sleep durations  
- Daily mood tracking with notes  

It also supports exporting data, reminders, and a polished Material 3 interface for a delightful user experience.

---

## 🗓️ Project Timeline & Deliverables

### 🏁 Week 1 — Setup & Foundation
 Deliverables:
- Flutter project created  
- Folder structure: `/models`, `/screens`, `/widgets`, `/services`  
- Onboarding flow (Welcome → Baby Setup → Home)  
- Themes & global styles (Material 3 with light/dark support)  
- Baby data stored locally via **SharedPreferences**  
- Splash screen with short baby video (5s)

🎥 **Demo Video (Week 1–2):** [Watch here](https://drive.google.com/file/d/1Fd8J4npQOwGCBCC2q6dfE8SEicsEpZNQ/view?usp=drivesdk)

---

### ⚙️ Week 2 — Event Logging & Data Persistence
 Completed Features:
- **Baby Setup Screen** (name + DOB, saved in SharedPreferences)
- **Home Screen** with navigation cards:
  - Log Feeding  
  - Log Diaper Change  
  - Log Sleep  
  - View Timeline  
- **Event Logging** for feeding, diaper, and sleep  
- **Timeline Screen** displaying all logged events (with filters)  
- **Logout** → clears saved data and returns to setup flow  
- **Navigation flow:**
  - First time → Splash → Welcome → Setup → Home  
  - Returning users → Splash → Home  
  - After logout → Splash → Welcome → Setup → Home  

---

###  Week 3 — Mood Tracker, Export & Notifications
 Added Features:
- **Mood Tracker** (5-point slider + optional note) — 1 entry per day  
- **Data Export:** CSV / JSON for last 7 or 30 days using `share_plus`    
- **Home Summary Dashboard:**
  - Last feeding time  
  - Last diaper change  
  - Total sleep today  
  - Today’s mood  

---

### 🧪 Week 4 — Polish, Testing & Final Submission
 Final Improvements:
- UI polish — icons, animations, empty states, error messages  
- Accessibility — large fonts, color contrast, screen reader labels  
- Added unit and widget tests:
  - Models (feeding, diaper, sleep, mood)  
  - Timeline screen & mood tracker widgets  
- Updated README with features & setup  
- Recorded final demo video  
- Created 5-slide summary deck (Problem, Features, Architecture, Screenshots, Future Scope)

 **Final Submission Video:** [Watch Here](https://drive.google.com/file/d/1qshiSPxFTQqfmKwTRvNgxP390lW2jZBm/view?usp=drivesdk)

---

## 🧠 Tech Stack
| Category | Technology |
|-----------|-------------|
| Framework | **Flutter (Dart)** |
| UI | **Material 3 Design** |
| State Management | Provider / Riverpod |
| Local Storage | SharedPreferences / Hive |
| File Sharing | share_plus |
| Testing | flutter_test (unit + widget) |

---

## 🧰 Project Structure
