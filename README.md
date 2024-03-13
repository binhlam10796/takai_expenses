# Expense Tracker App

## Introduction

The **Expense Tracker App** is a mobile application designed for tracking personal expenses. Developed for the iOS platform, this application provides essential features to help users manage their spending effectively. The implementation follows the principles of Clean Architecture and MVVM design pattern, leveraging Combine for reactive programming.

## Technology Stack

- **Backend:** Utilizes Firebase Authentication for secure user registration and login.
- **Mock API:** Simulates API interactions using the [MockWire website](https://app.wiremock.cloud/) to mock responses for API calls.

  > **Note:** Due to the nature of using a mock API, data synchronization in real-time is not available. The company can access the provided link to adjust the mock API, allowing for a more interactive exploration and understanding of the app. Additionally, you can choose to use `equalToJson` and modify parameters to thoroughly test the entire user interface.

## Features

### 1. User Registration and Authentication

- Implements a secure authentication system using Firebase Authentication with email/password.

### 2. Expense Tracking

- Allows users to add new expenses with details such as title, date, amount, category, location, and notes.
- Implements robust data validation to handle edge cases gracefully.

### 3. Expense Categories

- Predefines several expense categories (e.g., Food, Transportation, Entertainment, Utilities, etc.).
- Allows users to choose a category when adding an expense.
- Enables users to create custom categories.

### 4. Expense Listing

- Displays a list of all expenses in a user-friendly format.
- Implements sorting by date and filtering by category
- Includes the ability to edit and delete expenses.

# Project Structure (Clean Architecture + MVVM with Combine)

## Overview

This project follows the principles of Clean Architecture and MVVM design pattern, incorporating Combine for reactive programming. The architecture is organized into several layers, each serving a specific purpose to ensure separation of concerns and maintainability.

### Utility

The Utility layer contains reusable components for various functionalities:

- **Validation:** Includes a custom validation class with regex patterns.
- **Log:** Manages custom console logs.
- **Date:** Houses custom date utility functions.
- **Loadable:** Contains common loading components.
- **PrefUtil:** Utilizes UserDefaults for local storage.

### Presentation

The Presentation layer is divided into UI and Storyboard components:

- **UI:** Comprises ViewControllers and ViewModels responsible for managing the application state using Combine for reactive updates. The UI also includes a router as a key component for navigating between screens, and configurations define independent ViewController setups.
- **Storyboard:** Stores raw design layouts for the application.

### Assets

Assets include animations, fonts, colors, and images used in the application.

### AppDelegate

The `AppDelegate` includes two files, `AppDelegate` and `SceneDelegate`, serving the following purposes:

- **AppDelegate:** Manages the application's overall lifecycle and global settings.
- **SceneDelegate:** Handles multiple windows and state restoration, ensuring a smooth transition between scenes.

### Extensions

The Extensions layer contains extensions for UI controllers, such as UIColor, UIFont, providing additional functionality and enhancing readability.

### Core

The Core layer encompasses Firebase integration, Providers, Models, Repositories, and UseCases:

- **Firebase:** Manages Firebase services, including authentication, real-time database, and messaging.
- **Provider:** Consists of a provider and endpoint classes. Endpoint uses a layered architecture to break down request components for easier management, and the Provider consolidates these components into URLRequest for sending and receiving data.
- **Model:** Houses request and response structures for data communication.
- **Repositories:** Acts as a data processing hub, receiving raw data from the provider and transforming it into clean data for each UseCase group.
- **UseCase:** Functions as an aggregator, grouping related repositories with interdependencies to simplify Dependency Injection (DI) for the ViewModel.

### Localization

Localization manages string values and language conversion, currently supporting English and Vietnamese.

### Infrastructure

The Infrastructure layer contains classes like APIEndpoint, APIError, APIClient, and URLSessionAPIClient, working together to create requests to the server and handle responses.

### Application

The Application layer comprises DI (Dependency Injection) and Configuration:

- **DI:** Hosts various DI containers for network, repository, ViewModel, and ViewController, facilitating the injection of dependencies with a deep understanding of the application's structure.
- **Configuration:** Defines and manages configuration values, making them reusable across different environments.

This architecture aims to provide a scalable, modular, and maintainable structure for building robust iOS applications. Each layer has a clear responsibility, fostering code reusability, testability, and adaptability to changes.

## Setting Up the Project

1. Clone the repository from [GitHub](https://github.com/binhlam10796/takai_expenses).
2. Open the project in Xcode.
3. Install dependencies using CocoaPods: `pod install`.
4. Set up Firebase Authentication and replace the Firebase configuration files.
5. Run the app on a simulator or physical device.

## Demo

Include a demo video or screenshots showcasing the app in action. You can find them on [Youtube](https://youtu.be/7f_x5l2B7ls).
