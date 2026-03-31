# 📝 Task Tracker App

A cross-platform mobile application for managing daily tasks with categories and priorities, built with Flutter using **Clean Architecture**, **BLoC state management**, and **Firebase** as the backend.

---

## 📸 Screenshots
<p float="left">
  <img src="https://github.com/user-attachments/assets/0cfed645-1fc8-465d-a1b6-ee98ac36a4c2" width="150" />
  <img src="https://github.com/user-attachments/assets/8a406c8c-d389-4260-bb7f-e5e758797e71" width="150" />
  <img src="https://github.com/user-attachments/assets/6c512673-bad2-4c34-9439-6ffb5737c375" width="150" />
  <img src="https://github.com/user-attachments/assets/091b2219-2aa3-4585-b429-2ff31ed68e8a" width="150" />
  <img src="https://github.com/user-attachments/assets/6e69169f-89f6-4d67-9ed2-d15dd7657cb2" width="150" />
</p>


---

## ✨ Features

- 🔐 **Firebase Authentication** — Email/password and Google Sign-In
- ✅ **Task Management** — Create, update, delete, and complete tasks
- 🏷 **Categories** — Organize tasks by custom categories
- 🔥 **Priority Levels** — Set priority for each task
- 📅 **Calendar View** — Browse tasks by date
- 🌙 **Dark / Light Theme** — System-aware theme with persistent preference
- 🌐 **Localization** — Multi-language support (English, Uzbek, Russian) via `slang`
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
| Local Storage | shared_preferences, Hive |
| Localization | slang |
| Architecture | Clean Architecture |

---

## 🏗 Architecture

This project follows **Clean Architecture** with three layers:

```
lib/
├── core/                  # Shared utilities, theme, constants
├── generated/             # Auto-generated files (slang)
├── features/
│   ├── auth/              # Authentication (email, Google Sign-In)
│   ├── home/              # Task list and overview
│   ├── categories/        # Category management
│   └── settings/          # Theme and language settings
├── app.dart               # App widget and router setup
├── firebase_options.dart  # Firebase configuration
└── main.dart
```

Each feature is structured as:

```
feature/
├── data/          # Repository impl, data sources, models
├── domain/        # Entities, repository contracts, use cases
└── presentation/  # BLoC, pages, widgets
```

**Data flow:**
```
UI (Widget)
  → BLoC (Presentation)
    → Use Case (Domain)
      → Repository Contract (Domain)
        → Repository Impl (Data)
          → Firebase / Local Storage
```

---

## 🚀 Getting Started

### Prerequisites

Check your Flutter and Dart versions:

```bash
flutter --version
```

This project requires:
- Flutter `>=3.29.0`
- Dart `>=3.7.0`

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/AsilbekDeveloper/task_tracker.git

# 2. Navigate into the project
cd task_tracker

# 3. Install dependencies
flutter pub get

# 4. Generate localization files
dart run slang

# 5. Run the app
flutter run
```

### Firebase Setup

Since `google-services.json` and `GoogleService-Info.plist` are excluded from the repository for security reasons, you need to connect your own Firebase project:

1. Go to [Firebase Console](https://console.firebase.google.com/) and create a new project
2. Enable **Authentication** → Sign-in methods: **Email/Password** and **Google**
3. Enable **Cloud Firestore**
4. Register your Android app and download `google-services.json` → place in `android/app/`
5. Register your iOS app and download `GoogleService-Info.plist` → place in `ios/Runner/`

---

## 📁 Folder Structure

```
lib/
├── core/
│   ├── app_images_icons/  # Image and icon constants
│   ├── colors/            # App color palette
│   ├── components/        # Reusable widgets
│   ├── controllers/       # Shared controllers
│   ├── di/                # Dependency injection (get_it)
│   ├── router/            # App routing (go_router)
│   ├── theme/             # Light & dark theme
│   ├── utils/             # Helper functions
│   └── app_text_styles.dart
├── generated/             # slang localization output
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── categories/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── settings/
│       └── presentation/
├── app.dart
├── firebase_options.dart
└── main.dart
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter_bloc: ^9.1.1
  bloc: ^9.0.0
  firebase_core: ^4.4.0
  firebase_auth: ^6.1.4
  cloud_firestore: ^6.1.2
  google_sign_in: ^6.2.1
  get_it: ^8.0.3
  equatable: ^2.0.7
  go_router: ^17.0.1
  slang: ^4.12.1
  slang_flutter: ^4.12.1
  shared_preferences: ^2.5.4
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_screenutil: ^5.9.3
  google_fonts: ^8.0.1
  iconly: ^1.0.1
  iconsax_plus: ^1.0.0
  flutter_datetime_picker: ^1.5.1
  logger: ^2.5.0

dev_dependencies:
  build_runner: ^2.11.1
  slang_build_runner: ^4.12.1
  bloc_test: ^10.0.0
  mocktail: ^1.0.4
  flutter_lints: ^5.0.0
```

---

## 👤 Author

**Asilbek Ilhomov**
Flutter Developer | PDP University

- GitHub: [@AsilbekDeveloper](https://github.com/AsilbekDeveloper)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).