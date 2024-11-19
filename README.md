# Blog App 📱

A mobile application built with **Flutter**, designed to practice **Clean Architecture** and implement **SOLID principles**. This app provides a feature-rich blogging experience with support for both online and offline modes.

---

## Features 🚀

- **Authentication**: Sign-in and sign-up functionality using Supabase.
- **Blog Management**: Add, edit, delete, and read blogs with ease.
- **Theme Switching**: Toggle between light and dark modes.
- **Offline Support**:
  - Fetches data from the remote database in online mode.
  - Utilizes locally stored data when offline for seamless user experience.

---

## Technologies Used 🛠️

- **Frontend Framework**: Flutter
- **State Management**: Bloc and Cubit
- **Authentication and Remote Database**: Supabase
- **Local Storage**: Hive
- **Dependency Injection**: GetIt

---

## Screenshots 📸

| Blog Home Page                | Single Blog Page                 |
|----------------------------------|------------------------------------|
| ![Blog Listing](assets/app_screenshots/all_blogs.png) | ![Add/Edit Blog](assets/app_screenshots/single_blogs.png) |

---

## Installation & Setup ⚙️

Follow these steps to get the app running on your local machine:

1. Clone the repository:
   ```bash
   git clone https://github.com/rashmirekha99/blog_app.git
   cd blog_app
   flutter pub get
   flutter run
