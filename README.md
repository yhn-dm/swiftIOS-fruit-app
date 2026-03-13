swiftIOS-fruit-app
===================

> An educational SwiftUI project that showcases a beautiful, fruit-themed iOS application built with a clean MVVM architecture.

## Overview

This repository contains a small but complete iOS application written in **SwiftUI**.  
The goal of the project is to present a curated list of fruits with rich visuals and smooth navigation between multiple screens (onboarding slider, fruit list, settings, and detailed views).

The app is inspired by a modern, card-based design with colorful gradients and large fruit illustrations, similar to the mockups used in the project brief.  
It is meant both as a **learning exercise** (SwiftUI + MVVM) and as a **clean example** of how to structure a small app in a professional way.

## Main Features

- **Onboarding / Home screen**
  - Slider-style presentation with large fruit imagery.
  - Prominent **“Start”** button that navigates to the fruit list.

- **Fruit list**
  - Scrollable list of fruits with:
    - Fruit image.
    - Name (title).
    - Short 1–2 line description.
  - Top-right **Settings** button that opens the settings screen.
  - Tap on any fruit to open its detailed view.

- **Fruit detail**
  - Large hero image of the selected fruit.
  - Fruit name and full description.
  - Room for additional information (nutrition, sections, etc.) if needed.

- **Settings**
  - Simple settings screen matching the visual style of the designs (cards/sections, toggles).
  - Intended for non-critical app preferences and demo options (e.g. restart onboarding).

All screens are designed to follow the provided UI references while staying idiomatic to SwiftUI.

## Architecture

The project follows the **MVVM (Model–View–ViewModel)** pattern:

- **Model**  
  Represents the fruit domain objects (name, description, image reference, color, etc.), typically loaded from bundled data resources.

- **ViewModel**  
  Exposes observable state and business logic to drive the SwiftUI views (loading fruits, selected fruit, simple settings flags, etc.).

- **View**  
  SwiftUI views that focus purely on layout, styling, and binding to published properties coming from the ViewModels.

This clear separation makes the app easier to maintain, extend, and test.

## Resources and Assets

The project makes use of:

- **Resources/Data** for structured fruit data (`FruitsData.txt`).
- **Color assets** for light/dark variants of fruit-themed colors.
- Image and design assets that reflect the modern, gradient-based UI seen in the reference screens.

All resources are kept under the `Resources` folder to keep the Xcode project clean and organized.

## Getting Started

### Requirements

- Xcode (recent version supporting SwiftUI and iOS 14+).
- iOS 14 or later as the minimum deployment target (simulator or physical device).

### Build & Run

1. Clone the repository:

   ```bash
   git clone https://github.com/yhn-dm/swiftIOS-fruit-app.git
   cd swiftIOS-fruit-app
   ```

2. Open the Xcode project:

   ```bash
   open fruit-app/fruit-app.xcodeproj
   ```

3. Select the desired simulator or a connected device.
4. Press **Run** in Xcode.

The app should launch into the onboarding/home screen, from which you can navigate to the fruit list, settings, and detail screens.

## Project Goals

This project is primarily intended to:

- Demonstrate a **clean, beginner-friendly SwiftUI codebase**.
- Practice **MVVM architecture** with simple, testable components.
- Explore how to:
  - Organize assets and resources in a real project.
  - Build consistent, visually appealing UIs.
  - Structure navigation flows across multiple screens.

Even though this is a learning project, the codebase aims to keep a **professional tone and clarity**, so it can be reused as a reference for future SwiftUI work.

## Contributing

Contributions, suggestions, and improvements are welcome.  
If you spot an issue or have an idea to enhance the app (new fruits, animations, better accessibility, etc.), feel free to:

- Open an issue describing the change.
- Or submit a pull request with a clear explanation and screenshots when relevant.

## License

This project is shared for educational purposes.  
You are free to explore, learn from, and adapt it for your own experiments or studies.  
If you reuse significant parts of the code or design, a small attribution back to this repository is appreciated but not strictly required.