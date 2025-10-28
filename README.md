## 📸 ImageGalleryApp

A lightweight and scalable **SwiftUI-based Image Gallery** application demonstrating clean architecture, smooth UI interactions, and efficient network-driven image rendering.

---

### ✅ Features

• Browse images fetched from the network
• Grid-based gallery layout
• Thumbnail and full-size image displays
• Smooth loader views
• Image caching for performance
• Navigation to detail view
• Fully written in SwiftUI

---

### 🧱 Project Architecture

This project follows a **Layered Clean Architecture** approach for maintainability and testability.

```
ImageGalleryApp
├── Business Layer
│   ├── Enums
│   ├── Models
│   ├── Utilities
│   └── ViewModels
├── Network Layer
│   ├── NetworkManager
│   └── URLs
├── Presentation Layer
│   ├── Components
│   │   ├── CacheImage
│   │   └── Extensions
|   |   └── ImageViews
│   └── Main Views
│       ├── ImageGalleryView
│       ├── ImageDetailView
└── Resources
    ├── Assets
    └── Config
```

#### Layer Responsibilities

| Layer              | Responsibility                                                        |
| ------------------ | --------------------------------------------------------------------- |
| Business Layer     | Core business logic, reusable models, view models, app-wide utilities |
| Network Layer      | API services, URL management, data fetching                           |
| Presentation Layer | UI built in SwiftUI, modular components, navigation                   |
| Resources          | Static assets and configuration                                       |

This separation ensures code clarity, ease of scaling, and reuse across modules.

---

### 🛠️ Tech Stack

| Technology    | Purpose                 |
| ------------- | ----------------------- |
| SwiftUI       | UI development          |
| MVVM          | State & data management |
| URLSession    | Networking              |
| Async/Await   | Clean async operations  |
| Image Caching | Performance improvement |

---

### 🚀 Build Instructions

Follow these simple steps to run the project locally:

1️⃣ Clone the repository

```
git clone <repo-url>
```

2️⃣ Open the project in Xcode

```
cd ImageGalleryApp
open ImageGalleryApp.xcodeproj
```

3️⃣ Set your development team and signing settings in Xcode (if needed)

4️⃣ Run on simulator or real device
Choose any iOS 17+ simulator or device and hit **Run (⌘ + R)**

---

### 👨‍💻 Author

Developed by **Himanshu Goyal**
Software Engineer | iOS

---
