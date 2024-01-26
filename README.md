# Varta - Flutter Chat App

![Trustique Logo](https://github.com/Sampurn44/trustique/blob/master/images/trust.png)



## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Firebase Configuration](#firebase-configuration)
- [App Customization](#app-customization)
- [Future Enhancements](#future-enhancements)
- [Contributing](#contributing)
- [License](#license)

<a name="features"></a>
## Features

1. **User Authentication**
   - **Google Sign-In:** Users can easily authenticate using their Google accounts.
   - **Add User:** Users can create and manage their profiles.

2. **Real-Time Messaging**
   - Enjoy real-time chat functionality powered by Firebase Firestore.

3. **Location Sharing**
   - **Send Current Location:** Share your current location as a text URL.
   - **Future Enhancement:** The text URL can be turned into a Google Maps screenshot if an API becomes available in the future.

4. **User Search**
   - **Search in Current Users:** Quickly find and start conversations with other users.

5. **Unread Message Indicator**
   - See the unread message count for each conversation.

6. **Message Status**
   - Double ticks indicate when a message has been seen by the recipient.

<a name="getting-started"></a>
## Getting Started

### Prerequisites

Before you start, make sure you have the following prerequisites installed:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase](https://firebase.google.com/docs/flutter/setup)
- [Google Cloud Console](https://console.cloud.google.com/) project for setting up Google Sign-In.

### Installation

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/Sampurn44/trustique.git

2. Navigate to the project directory:

   ```bash
    cd trustique
3. Install the required Flutter packages:
   ```bash
   flutter pub get
  **OR**
**Download the apk from here [apk](https://drive.google.com/drive/folders/16KW_ZSsIiIlD67vW_7wLyZ3ZtTj7AElA?usp=sharing)**
## Usage

1. **Firebase Configuration**

   - Create a new Firebase project on the Firebase Console.
   - Add your Android and iOS apps to the Firebase project and follow the setup instructions provided by Firebase.
   - Download the `google-services.json` file for Android and `GoogleService-Info.plist` for iOS from the Firebase Console, and place them in their respective directories (`android/app` and `ios/Runner`).
   - Enable Google Sign-In in your Firebase project.

2. **Run the App**

   - Use the following command to run the app on your emulator or physical device:

     ```bash
     flutter run
     ```

   - Explore the app's features and functionalities.

## App Customization

You can easily customize Trustique to suit your specific needs. Modify the Flutter code and Firebase configurations as required. You can also change the app's appearance, add new features, or integrate additional APIs.

## Future Enhancements

We have exciting plans for Trustique's future. Potential enhancements include:

- Integration of an API to convert location text URLs into Google Maps screenshots.
- Support for additional authentication methods.
- Enhanced chat features, including multimedia sharing.
- Improved user interface and user experience.

Stay tuned for updates and consider contributing to make these enhancements a reality!




---

Thank you for choosing Trustique - the Flutter Chat App! We hope it proves invaluable for your development projects. Should you have any questions or suggestions, please feel free to open an issue on GitHub.

Happy chatting and coding! 😄🚀
