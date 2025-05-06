
# Flutter Internship Assignment

This is a multi-screen Flutter app integrated with Firebase services. The app demonstrates Firebase Authentication, state management, navigation, and a clean code architecture.

## Features

* **Firebase Authentication**:

  * Sign Up and Login functionality
  * Persistent login across app restarts (session persistence)
  * Logout feature that clears the session

* **Profile Screen**:

  * Displays the user's email and other profile information 
  * Includes a Logout button that clears the session and navigates back to the login screen

* **Settings Screen** (Dummy for now):

  * Placeholder for user settings.

* **Curved Bottom Navigation Bar**:

  * A curved bottom navigation bar is used for smooth navigation between screens.

## Setup Instructions

### 1. Clone the repository:

```bash
git clone <repo_link>
cd <project_directory>
```

### 2. Install Dependencies:

```bash
flutter pub get
```

### 3. Firebase Setup:

* Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
* Add your Android app to the Firebase project.
* Download `google-services.json` and place it in the `android/app` directory.
* Enable Firebase Authentication in your Firebase Console.

### 4. Run the App:

Make sure to use an Android emulator or a physical device connected to your computer.

```bash
flutter run
```

## Features in Detail

### Firebase Authentication

* **Sign Up & Login**: Users can sign up with their email and password or log in to an existing account.
* **Session Persistence**: Once logged in, the session is maintained across app restarts using Firebase Auth's session persistence.
* **Logout**: Logs the user out and redirects them back to the login screen.

### Profile Screen

* Displays a personalized welcome message with the user's name and additional user profile information stored in cloud firestore.
* **Logout**: A button that logs out the user and navigates back to the login screen.

### Settings Screen (Dummy)

* Placeholder screen for future integration of user settings.

### Curved Bottom Navigation Bar

* The app uses a **Curved Bottom Navigation Bar** to switch between the Profile and Settings screens.

## Optional Features (Bonus Points)

* **Error Handling & Loading States**: Shows user-friendly error messages and loading indicators during network requests.
* **Clean Architecture**: Well-organized codebase with separate concerns for UI, business logic, and data layers.
* **Responsive UI**: UI adapts to different screen sizes.
* **Input Validation**: Ensures all inputs are validated before submitting.
* **Firebase Firestore Integration**: Firebase Firestore can be used to store and retrieve user profile data.


