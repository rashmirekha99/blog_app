# Blog App 📱

A mobile application built with **Flutter**, designed to practice **Clean Architecture** and implement **SOLID principles**. This app provides a feature-rich blogging experience with support for both online and offline modes.

## Screenshots 📸

<div style="display: flex; justify-content: space-around;">

<img src="assets/app_screenshots/all_blogs.png" alt="Blog Listing" width="300" />
<img src="assets/app_screenshots/single_blog.png" alt="Single Blog" width="300" />

</div>


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


## Installation & Setup ⚙️

Follow these steps to get the app running on your local machine:

1. Clone the repository:
   ```bash
   git clone https://github.com/rashmirekha99/blog_app.git
   cd blog_app
   flutter pub get
   flutter run
