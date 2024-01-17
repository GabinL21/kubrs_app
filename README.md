# Kubrs App

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

---

Kubrs is the perfect speedcubing companion!  
It helps you learn new algorithms and track your progress, all in a beautifully designed and easy-to-use mobile application built with [Flutter](https://flutter.dev/).

## Features ✨

### Current Features
- Precision timer with touch controls
- Solve history with real-time cloud synchronization to Firebase
- Session statistics and progress charts
- Competition-grade scramble generation and visualization
- Solve tags like +2 and DNF
- Offline mode to train anywhere and synchronize later
- Authentication with Google
- Imports from other popular timer apps

### Technical Features
- Clean and tested state management with [Bloc](https://bloclibrary.dev/#/)
- Custom caching solution with SQLite3 to reduce Firebase costs and fetch latency
- Custom timer using animation frames to get more precision
- Feature-oriented architecture
- Cross-platform mobile application
- Responsive components for all screen sizes
- Continuous integration with GitHub Actions

### Upcoming Features
- Flashcards to learn algorithms with spaced repetition
- Advanced statistics to track your progress
- Notifications to remind you to practice
- Session management to organize your solves

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
