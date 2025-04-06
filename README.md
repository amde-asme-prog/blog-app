# 📝 Flutter Blog App

A modern, scalable, and production-ready **Flutter Blog App** built using **Clean Architecture** principles. This app demonstrates a clean separation of concerns, functional error handling, offline capabilities, and integration with **Supabase** for backend services.

![Flutter Blog App](https://user-images.githubusercontent.com/placeholder/blog-banner.png)

---

## 🧠 Key Features

- 🧼 Clean Architecture with Domain, Data, and Presentation layers
- ⚡ Functional programming with [`fpdart`](https://pub.dev/packages/fpdart)
- 🔥 Backend powered by [Supabase](https://supabase.com/)
- 📦 Dependency injection with `get_it`
- 📶 Offline-ready with Hive and Isar
- 🧠 State management using `flutter_bloc`
- 🌐 Internet connection monitoring
- 📸 Image upload with `image_picker`
- 🌍 Localization-ready with `intl`

---

## 🧰 Tech Stack

| Category               | Package                            |
| ---------------------- | ---------------------------------- |
| State Management       | `flutter_bloc`                     |
| Functional Programming | `fpdart`                           |
| Backend Integration    | `supabase_flutter`                 |
| Dependency Injection   | `get_it`                           |
| Local Storage          | `hive`, `isar_flutter_libs`        |
| File System            | `path_provider`                    |
| Connectivity           | `internet_connection_checker_plus` |
| Media Picker           | `image_picker`                     |
| UI Elements            | `dotted_border`                    |
| Utilities              | `uuid`, `intl`                     |

---

## 🧱 Architecture

This app uses **Clean Architecture** for maintainability, scalability, and testability:

lib/ ├── core/ # Common logic, failure handling, utils ├── features/ │ └── blog/ │ ├── data/ # DTOs, models, repositories │ ├── domain/ # Entities, use cases, repository interfaces │ └── presentation/ │ ├── bloc/ # BLoC files and states │ └── ui/ # UI pages and widgets ├── inject/ # get_it service locator setup ├── main.dart # App entry point

yaml
Copy
Edit

---

## 🚀 Getting Started

### ✅ Prerequisites

- Flutter SDK (>=3.0.0)
- Supabase project with configured authentication and storage
- Emulator or physical device

### 🔧 Installation

```bash
git clone https://github.com/your-username/flutter-blog-app.git
cd flutter-blog-app
flutter pub get
flutter run
🧪 Testing
Run unit and widget tests using:

bash
Copy
Edit
flutter test
📸 Screenshots
Home Page	Add Blog	Blog Details
📂 Hive & Isar Setup
Ensure to run the build runner for Isar:

bash
Copy
Edit
flutter pub run build_runner build
🛡️ License
This project is licensed under the MIT License - see the LICENSE file for details.

💡 Contributing
Found a bug or want to add a feature? Contributions are welcome! Please fork the repository and submit a pull request.

🤝 Contact
Feel free to connect:

```
