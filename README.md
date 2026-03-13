swiftIOS-fruit-app
===================

## Overview

`swiftIOS-fruit-app` is a small but polished iOS application built entirely with SwiftUI.  
It showcases a curated list of fruits, each with a friendly description and a structured view of its nutritional values, while demonstrating a clean MVVM architecture.

The app guides the user through a welcoming onboarding slider, then presents a list of fruits.  
From this list, users can drill into a detailed screen for each fruit and access a Settings screen that lets them restart the onboarding flow and review basic app information.

## Features

- **Onboarding slider**
  - Page-style slider introducing the app with large fruit imagery and gradient backgrounds.
  - Prominent “Start” button that transitions to the main list of fruits.

- **Fruits list**
  - Scrollable list of fruits, each row showing:
    - Thumbnail image
    - Fruit name
    - Short, one- or two-line headline
  - Tapping a row opens a detailed screen for the selected fruit.
  - Settings button in the navigation bar to access the Settings screen.

- **Fruit detail**
  - Large hero image of the fruit with a color-coordinated gradient.
  - Fruit name and headline.
  - “Nutritional value per 100g” section with key nutritional data.
  - Longer descriptive text to learn more about each fruit.

- **Settings**
  - Informational section describing the purpose of the app.
  - Customization section with a toggle to restart the onboarding experience.
  - Application metadata: developer, designer, compatibility and website link.

## Architecture & Technology

- **SwiftUI only** – no UIKit.
- **MVVM** – clear separation between:
  - `Models` (e.g. `Fruit`, `OnboardingItem`)
  - `ViewModels` (e.g. `OnboardingViewModel`, `FruitListViewModel`)
  - `Views` (Onboarding, Fruit list, Fruit detail, Settings, nutrients, row views, etc.)
- Data loaded from bundled resources:
  - `Resources/Resources/Data/FruitsData.txt` for fruit content and nutrition.
  - Color assets in `Resources/Resources/Colors` and image assets in the app asset catalog.

## Requirements

- Xcode with SwiftUI support (Xcode 15 or later recommended).
- iOS 14 or later as deployment target.
- Swift 5.x.

## Getting Started

1. **Clone the repository**

   ```bash
   git clone https://github.com/yhn-dm/swiftIOS-fruit-app.git
   cd swiftIOS-fruit-app/fruit-app
   ```

2. **Open the project**

   - Open `fruit-app.xcodeproj` in Xcode.
   - Select the `fruit-app` scheme and a simulator or a connected device.

3. **Run**

   - Press **Run** (⌘R) in Xcode.
   - The app launches on the selected device, starting with the onboarding slider.

## Project Structure (high level)

- `fruit-app/fruit-app/`
  - `Models/` – data models such as `Fruit` and `OnboardingItem`.
  - `ViewModels/` – view models like `OnboardingViewModel` and `FruitListViewModel`.
  - `Views/`
    - `Onboarding/` – onboarding slider.
    - `FruitList/` – list view and fruit row.
    - `FruitDetail/` – fruit detail and nutrients view.
    - `Settings/` – settings screen.
  - `Services/` – data loading logic (`FruitDataService`).
  - `Resources/` – color assets and fruit data.
  - `fruit_appApp.swift` – application entry point.
  - `ContentView.swift` – decides between onboarding and the main list.

This layout keeps UI, state management and data access clearly separated, making the app easier to read and extend.

## Design

The UI is inspired by modern, card-based product designs:

- Bright gradients and high-quality fruit imagery.
- Clear hierarchy of text styles for titles, headlines and body text.
- Simple, recognizable SF Symbols in navigation and Settings.
- Layouts tuned for readability on recent iPhone devices and for both light and dark mode.

## Contributing

This repository is primarily intended for learning and experimentation with SwiftUI and MVVM.  
If you want to extend it (new fruits, filters, widgets, etc.), you can:

1. Fork the repository.
2. Create a feature branch.
3. Implement your changes with clear, focused commits.
4. Open a pull request describing what you changed and why.

## License

The project is provided for educational and demonstration purposes.  
You are welcome to copy and adapt the code in your own projects. If you publish a derivative work, please consider mentioning this repository as a source of inspiration.
