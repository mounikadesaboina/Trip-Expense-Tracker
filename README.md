# Team 5 — Trip Expense Tracker (TripTally)

A Flutter app for recording and reviewing travel expenses for one or more trips.

## Features
- Create trip expense records with trip name, title, amount, category, date, payer and note
- Categories: Transport, Food, Stay, Tickets, Shopping and Other
- Trip-wise spending totals
- Category breakdown for each trip
- Expense history, detail view and delete action
- Local persistence using SharedPreferences
- Provider (`ChangeNotifier`) shared state
- Loading, error/retry and empty states

## Project structure
```text
lib/
  main.dart
  models/trip_expense.dart
  providers/trip_provider.dart
  services/trip_storage_service.dart
  screens/
    trip_dashboard_screen.dart
    add_trip_expense_screen.dart
    trip_detail_screen.dart
    trip_summary_screen.dart
  widgets/trip_expense_tile.dart
test/widget_test.dart
```

## Requirements and run
Flutter stable 3.35+, Dart null safety, Android Studio, Android SDK and JDK 17.
```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Data source
Trip expenses are entered by the user and stored locally with SharedPreferences. No external API is used.

## Team responsibilities
Add all three team members, GitHub usernames and assigned screen/feature before final submission.

## Verification status
This is an initial source package. It has not yet been built or tested on a physical Android device in the target team's environment. Run the commands above, fix reported issues and record actual results before calling it verified.

## Before submission
Add three genuine screenshots, team responsibilities, a defect log, a release APK and evidence of physical-device testing. Every member should contribute and be able to explain their work.
