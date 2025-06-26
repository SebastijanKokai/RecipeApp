# Recipe App

A simple Flutter recipe application demonstrating **Provider state management** and **MVVM architecture**.

## Architecture

This project follows the **MVVM (Model-View-ViewModel)** pattern:

- **Models**: Recipe data classes
- **ViewModels**: State management using Provider and ChangeNotifier
- **Views**: UI components and screens
- **Repository**: Data access layer with mock API

## State Management

Built with **Provider** library for centralized state management, reactive UI updates, and type-safe state handling with sealed classes.

## Project Structure

```
lib/
├── models/          # Data classes (Recipe, DataState)
├── viewmodels/      # Business logic (RecipeViewModel)
├── views/           # UI screens (RecipeDetailView, etc.)
├── widgets/         # Reusable components
├── repositories/    # Data access layer
└── main.dart        # App entry point
```

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter run`