# Student Application Tracker

A Flutter mobile application that helps students track their university applications, manage application statuses, and receive real-time updates.

---

## Project Overview

This application was developed as part of the **Mobile App Development Intern Application** for  **University Insights** . It provides students with a centralized platform to manage and track their university applications, offering features like real-time updates, progress tracking, and secure authentication.

---

## Features

* **User Authentication** :
* Secure login system using  **Firebase Authentication** .
* Persistent login state management using  **Provider** .
* **Application Management** :
* Add, edit, and delete university applications.
* Track application status and progress using a  **progress bar** .
* View detailed application information in a clean, user-friendly interface.
* **Real-time Updates** :
* Live status updates using  **Firestore's real-time listeners** .
* Progress tracking visualization with color-coded status indicators.
* Application timeline view for easy tracking.

---

## Technologies Used

* **Flutter** : For cross-platform mobile app development.
* **Firebase Authentication** : For secure user login and authentication.
* **Cloud Firestore** : For real-time data storage and synchronization.
* **Provider** : For state management and dependency injection.
* **Firebase App Distribution** : For hosting and distributing the APK.

---

## Setup Instructions

To set up and run the project locally, follow these steps:

1. **Clone the Repository** :
   bash

   Copy

```
   git clone https://github.com/neerajgawane/application_tracker.git
```

1. **Install Dependencies** :
   bash

   Copy

```
   flutter pub get
```

1. **Configure Firebase** :

* Download the `google-services.json` file from your Firebase project.
* Place it in the `android/app/` directory.

1. **Run the Application** :
   bash

   Copy

```
   flutter run
```

---

## APK Download

You can download the latest version of the app through  **Firebase App Distribution** :
https://appdistribution.firebase.google.com/testerapps/1:885707766477:android:b15b2954d27d60efee8784/releases/5nfimqhpgkeeg?utm_source=firebase-console

Alternatively, you can download the APK directly from the link below:
https://drive.google.com/file/d/11yA1uuM4HAIhvi_EuierK4gYdHjtDsZy/view?usp=drive_link

### Instructions for Testers:

1. Click the link above.
2. Sign in with your Google account.
3. Accept the invitation to become a tester.
4. Download and install the APK.

### Test Credentials:

Use the following credentials to log in:

* **Email** : `test@example.com`
* **Password** : `test123`

---

## Development Challenges and Solutions

### 1. **Authentication Flow**

* **Challenge** : Implementing a seamless authentication system with persistent login states.
* **Solution** : Used **Firebase Authentication** and **Provider** to manage user sessions and login states effectively.

### 2. **Real-time Data Synchronization**

* **Challenge** : Ensuring real-time updates for application statuses without performance issues.
* **Solution** : Leveraged **Firestore's real-time listeners** to sync data across devices instantly.

### 3. **User Interface Design**

* **Challenge** : Designing an intuitive and responsive UI for complex application data.
* **Solution** : Implemented a **card-based design** with clear visual hierarchies and color-coded status indicators.

### 4. **Data Management**

* **Challenge** : Managing application data across multiple screens while maintaining consistency.
* **Solution** : Created a centralized **ApplicationService** to handle all CRUD operations and ensure data consistency.

### 5. **Code Organization**

* **Challenge** : Maintaining a clean and maintainable codebase.
* **Solution** : Organized the code into  **models** ,  **services** , and **screens** for better separation of concerns.

### 6. **Performance Optimization**

* **Challenge** : Ensuring smooth performance with real-time updates and complex UI rendering.
* **Solution** : Optimized database queries, implemented lazy loading, and added proper error handling.

---

## Future Improvements

* **Push Notifications** : Notify users about important updates or deadlines.
* **Advanced Filtering** : Add search and filter options for applications.
* **Document Upload** : Allow users to upload supporting documents (e.g., transcripts, recommendation letters).
* **Deadline Reminders** : Send reminders for upcoming application deadlines.
* **Analytics Dashboard** : Provide insights into application trends and progress.

---

## Contact

For any questions, feedback, or issues, feel free to reach out:

* **Name** : Neeraj Gawane
* **Email** : [neerajsgawane@gmail.com](mailto:neerajsgawane@gmail.com)
* **GitHub** : [https://github.com/neerajgawane](https://github.com/neerajgawane)
