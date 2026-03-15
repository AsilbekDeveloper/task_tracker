# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Task Tracker is a Flutter app for managing tasks and categories with Firebase backend (Auth, Firestore, Storage). Supports light/dark themes and three languages (English, Russian, Uzbek).

## Build & Development Commands

```bash
# Run the app
flutter run

# Build
flutter build apk
flutter build ios

# Tests
flutter test                                    # All tests
flutter test test/get_all_tasks_bloc_test.dart   # Single test file

# Analyze
flutter analyze

# Code generation (i18n strings via slang)
dart run build_runner build --delete-conflicting-outputs

# Get dependencies
flutter pub get
```

## Architecture

Clean Architecture with feature-based folder structure and BLoC pattern for state management.

### Layer Flow
```
Presentation (BLoC + Pages) → Domain (Use Cases + Entities) → Data (Repositories + Remote Data Sources) → Firebase
```

### Feature Structure
Each feature (`auth`, `home`, `categories`, `settings`) follows this pattern:
```
features/<feature>/
  data/
    data_source/       # Firebase interactions (RemoteDataSource)
    models/            # Data models (fromJson/toJson)
    repositories/      # Repository implementations
  domain/
    entities/          # Business entities (Equatable)
    repositories/      # Abstract repository contracts
    use_cases/         # Single-responsibility use cases
  presentation/
    bloc/              # BLoC (event/state/bloc triad per operation)
    pages/             # UI pages
    widgets/           # Feature-specific widgets
```

### Key Patterns

- **DI**: `get_it` service locator in `lib/core/di/service_locator.dart`. Data sources, repositories, and use cases are `registerLazySingleton`; BLoCs are `registerFactory`.
- **Routing**: `go_router` with named routes defined in `lib/core/router/app_router.dart` and route constants in `route_names.dart`.
- **State Management**: Each BLoC operation (create, edit, delete, get) has its own BLoC class with separate event/state files. All BLoCs are provided globally via `MultiBlocProvider` in `main.dart`.
- **Theme**: Managed via `ThemeBloc` with Hive for persistence. Colors in `core/colors/`, styles in `core/app_text_styles.dart`, theme in `core/theme/app_theme.dart`.

## Localization

Uses [slang](https://pub.dev/packages/slang) for i18n. Source strings are in `assets/i18n/strings_{locale}.i18n.json`. Generated files go to `lib/generated/`. After modifying i18n JSON files, run code generation.

## Testing

Uses `mocktail` for mocking and `bloc_test` for BLoC testing. Mock classes are in `test/mocks/`. Tests follow the pattern: mock the repository, inject into use case, inject into BLoC, use `blocTest` to verify state emissions.

## Adding New Features

1. Create the feature directory under `lib/features/<name>/` with `data/`, `domain/`, and `presentation/` layers
2. Register data source, repository, use cases, and BLoCs in `lib/core/di/service_locator.dart`
3. Add routes in `lib/core/router/app_router.dart` and route name constants in `route_names.dart`
4. Add BLoC providers in `main.dart`'s `MultiBlocProvider`

## Reusable Components

Shared widgets live in `lib/core/components/` (buttons, text fields, priority widgets, category dialogs). Use `AppTheme`, `AppColors`, and `AppTextStyles` from `core/` for consistent styling.

---

## Known Issues & Technical Debt

### Architecture Violations
- `create_task_bloc.dart` accesses `FirebaseAuth.instance` directly — should be injected via use case/repository
- `single_category_page.dart` and `create_category_page.dart` contain business logic (Firebase auth checks, task-existence checks) that belongs in the domain layer
- `EditCategoryUseCase` exists in domain but has no BLoC and no UI — dead code with incomplete feature
- `EditCategoryUseCase` is not registered in `service_locator.dart`
- All BLoCs are provided globally in `main.dart` `MultiBlocProvider` — should be scoped to feature/page level

### Code Quality
- `auth_event.dart` defines a duplicate `SignInEvent` class (also exists in `sign_in/sign_in_event.dart`) — `sign_in_event.dart` is unused dead code
- Date/time formatting logic is duplicated in `task_widget.dart`, `single_task_page.dart`, and `task_time_widget.dart` — extract to utility
- Error handling try-catch pattern duplicated across all data sources — extract to common wrapper
- Category deduplication logic duplicated in `categories_dialog.dart` and `categories_page.dart`
- `print()` statements in `create_task_bloc.dart` — should use `Logger` package
- `single_task_page.dart` shows "taskEditedSuccessfully" message for delete action — wrong message

### Missing Validation
- Email validation only checks `isEmpty`, no format validation
- No password strength requirements on sign-up (beyond Firebase's 6-char minimum)
- Task title/description only checks `isEmpty`, no length limits
- Category name has no length limit or duplicate name check

### Hardcoded Strings (not localized)
- Settings page: "Select Language", "Theme", "DarkMode", "LightMode"
- Priority widget: "Task Priority"
- Create category page: "Fill All Fields"
- Various error messages in data sources mix English and Uzbek

### Testing Gaps
- Only 2 meaningful test cases exist (`get_all_tasks_bloc_test.dart`)
- No tests for: auth blocs, create/edit/delete task blocs, category blocs, repositories, use cases
- `test/widget_test.dart` is boilerplate
- `test/integration_test/app_test.dart` appears empty

### Missing Features
- No search by task title
- No filter by priority or completion status from home
- No batch operations (bulk delete/complete)
- No password reset flow
- No task notifications/reminders
- No profile editing in settings
- No offline support / local caching
- No retry mechanism on network errors
- No skeleton/shimmer loading states

### UI/Responsive
- `crossAxisCount: 2` hardcoded in categories grid — not responsive
- No tablet/landscape layouts
- Form data lost on submission error (no state preservation)
