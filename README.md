# FREELANCE JOURNEY

Freelance Journey is a mobile app designed to simplify the job posting and application process for freelancers. Employers can post job listings with detailed requirements, and freelancers can easily browse and apply for jobs based on their skills.

## Features

* **User Authentication**: Secure login with Firebase
* **Job Listings**: Create and browse job opportunities
* **Profile Management**: Create and update freelancer profiles
* **Search & Filter**: Search jobs by keyword or filter by category
* **Job Application**: Apply to jobs directly from the app
* **Messaging System**: In-app chat for communication
* **Verification**: Identity checks for both freelancers and job posters

## Built With

* **Flutter**: For cross-platform app development
* **Firebase**:
  * Authentication
  * Firestore Database
  * Cloud Messaging
  * Storage

## Installation

1. **Clone the Repository**:
```bash
git clone https://github.com/nrebra/freelancer-App.git
cd freelance_journey
```

2. **Set Up Firebase**:
* Create a new Firebase project
* Enable Firestore, Authentication, and Cloud Messaging in Firebase Console
* Add your Android and iOS apps to the Firebase project
* Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS)
* Place the google-services.json file in android/app/ and the GoogleService-Info.plist file in ios/Runner/

3. **Install Dependencies**:
```bash
flutter pub get
```

4. **Run the App**:
```bash
flutter run
```

## Resources

If this is your first Flutter project, here are some helpful resources:

* [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
* [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
* [Flutter documentation](https://docs.flutter.dev/)

For help getting started with Flutter development, view the [Flutter documentation](https://docs.flutter.dev/), which offers tutorials, samples, and a full API reference.

## License

Distributed under the MIT License. See `LICENSE` for more information.