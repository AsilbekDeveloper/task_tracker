# 📝 Task Tracker App

A cross-platform mobile application for managing daily tasks, built with Flutter using **Clean Architecture**, **BLoC state management**, and **Firebase** as the backend.

---
## 📸 Screenshots

<p float="left">
  <img src="https://github.com/user-attachments/assets/0cfed645-1fc8-465d-a1b6-ee98ac36a4c2" width="220" />
  <img src="https://github.com/user-attachments/assets/8a406c8c-d389-4260-bb7f-e5e758797e71" width="220" />
  <img src="https://github.com/user-attachments/assets/6c512673-bad2-4c34-9439-6ffb5737c375" width="220" />
  <img src="https://github.com/user-attachments/assets/091b2219-2aa3-4585-b429-2ff31ed68e8a" width="220" />
  <img src="https://github.com/user-attachments/assets/6e69169f-89f6-4d67-9ed2-d15dd7657cb2" width="220" />
</p>
## ✨ Features

- 🔐 **Firebase Authentication** — Sign in / Sign up with email & password
- ✅ **Task Management** — Create, update, delete, and complete tasks
- 📅 **Calendar View** — Browse tasks by date
- 🌙 **Dark / Light Theme** — System-aware theme switching
- 🌐 **Localization** — Multi-language support via `slang`
- 🔒 **Form Validation** — Real-time field validation using BLoC

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Language | Dart |
| Framework | Flutter |
| State Management | flutter_bloc |
| Backend | Firebase (Firestore, Auth) |
| Navigation | go_router |
| DI | get_it |
| Localization | slang |
| Architecture | Clean Architecture |

---

## 🏗 Architecture

This project follows **Clean Architecture** with three layers:

```
lib/
├── core/                  # Shared utilities, theme, constants
├── features/
│   └── auth/
│       ├── data/          # Repository impl, data sources, models
│       ├── domain/        # Entities, repository contracts, use cases
│       └── presentation/  # BLoC, pages, widgets
└── main.dart
```

**Data flow:**
```
UI (Widget)
  → BLoC (Presentation)
    → Use Case (Domain)
      → Repository Contract (Domain)
        → Repository Impl (Data)
          → Firebase / API
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Firebase project configured

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/AsilbekDeveloper/task_tracker.git

# 2. Navigate into the project
cd task_tracker

# 3. Install dependencies
flutter pub get

# 4. Generate localization files
dart run build_runner build --delete-conflicting-outputs

# 5. Run the app
flutter run
```

### Firebase Setup

1. Create a project on [Firebase Console](https://console.firebase.google.com/)
2. Enable **Authentication** (Email/Password)
3. Enable **Cloud Firestore**
4. Download `google-services.json` → place in `android/app/`
5. Download `GoogleService-Info.plist` → place in `ios/Runner/`

---

## 📁 Folder Structure

```
lib/
├── core/
│   ├── di/                # Dependency injection (get_it)
│   ├── router/            # App routing (go_router)
│   ├── theme/             # Light & dark theme
│   └── utils/             # Helper functions
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   └── tasks/
│       └── ...
└── main.dart
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.x.x
  firebase_auth: ^4.x.x
  cloud_firestore: ^4.x.x
  get_it: ^7.x.x
  go_router: ^13.x.x
  slang: ^3.x.x
  slang_flutter: ^3.x.x

dev_dependencies:
  build_runner: ^2.x.x
  slang_build_runner: ^3.x.x
```

---

## 👤 Author

**Asilbek**
Flutter Developer | PDP University

- GitHub: [@AsilbekDeveloper](https://github.com/AsilbekDeveloper)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
