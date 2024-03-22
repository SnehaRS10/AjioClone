# Ajio Clone using Flutter and Firebase

This is a clone of the Ajio app built using Flutter framework with Firebase integration for storage and authentication.

## Requirements

- Flutter SDK
- Firebase Account (for storage and authentication)
- IDE (e.g., Visual Studio Code, Android Studio)

## IDE Setup

1. **Flutter SDK Installation**: 
    - Follow the official Flutter installation guide: [Flutter - Get Started](https://flutter.dev/docs/get-started/install)

2. **Firebase Configuration**:
    - Create a Firebase project on the [Firebase Console](https://console.firebase.google.com/)
    - Enable Firebase Authentication and Firestore database for the project
    - Download `google-services.json` file for Android or `GoogleService-Info.plist` for iOS and add it to your project under the `android/app` or `ios/Runner` directory respectively.
    - Follow the instructions provided by Firebase to set up Firebase Authentication (e.g., email/password authentication) and Firestore.

3. **IDE Setup**:
    - Install the necessary plugins for Flutter and Dart in your IDE.
    - For Visual Studio Code, you can install the Flutter and Dart plugins directly from the marketplace.

## Steps to Run the Project

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/yourusername/ajio-clone.git
    ```

2. **Navigate to Project Directory**:
    ```bash
    cd ajio-clone
    ```

3. **Install Dependencies**:
    ```bash
    flutter pub get
    ```

4. **Run the App**:
    - Connect your device/emulator and run the app using the following command:
    ```bash
    flutter run
    ```

5. **Testing Authentication and Storage**:
    - Make sure your Firebase configurations are correctly set up for authentication and storage.
    - Test authentication features such as sign-in, sign-up, password reset, etc.
    - Test file uploads/downloads using Firebase storage.

