# Task App

This is a Flutter-based task management application with Firebase Firestore integration, Bloc state management, and offline-first capabilities.

## Features

- Add and complete tasks
- Filter tasks (All, Not Done, Done)
- Offline support: Tasks can be added or modified while offline and sync when back online
- Compatible with Android and Desktop

## Setup Instructions

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- A Firebase project set up in [Firebase Console](https://console.firebase.google.com/)

### Steps

1. **Clone the repository:**

    ```bash
    git clone https://github.com/Moaaz-Ahmad/task_app.git
    cd task_app
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Set up Firebase:**

    - Create a new Firebase project in the Firebase Console.
    - Add an Android app to your Firebase project and download the `google-services.json` file.
    - Place the `google-services.json` file in the `android/app` directory.
    - Enable Firestore and configure the Firestore rules to allow read and write access.
    - Initialize Firebase in your Flutter project:
      ```bash
      flutterfire configure
      ```

4. **Run the app:**

    - For Android:
      ```bash
      flutter run
      ```

    - For Desktop:
      ```bash
      flutter run -d windows
      ```

## Folder Structure

```plaintext
task_app/
│
├── android/                     # Android specific configuration
├── ios/                         # iOS specific configuration
├── lib/
│   ├── bloc/                    # Bloc state management files
│   ├── models/                  # Task model
│   ├── repository/              # Firestore interaction
│   ├── task_manager_screen.dart # Main screen
│   └── main.dart                # Entry point of the application
├── test/                        # Unit and widget tests
├── pubspec.yaml                 # Project dependencies
└── README.md                    # Setup instructions and project overview

