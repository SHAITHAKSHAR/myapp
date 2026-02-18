# Spin and Win Flutter App

This is a "Spin and Win" game built with Flutter and Firebase. It's a complete mobile application with a modern UI, a robust backend, and engaging features to keep users entertained.

## Features

*   **Authentication:**
    *   Email/Password and Google Sign-In.
    *   Persistent login sessions.
    *   Redirects based on authentication state.
*   **Routing:**
    *   Declarative routing using `go_router`.
    *   Welcome screen for new users.
    *   Home screen for authenticated users.
    *   Login screen.
*   **Backend:**
    *   Firebase Realtime Database for storing spin results and leaderboard data.
    *   Firebase Storage for storing user profile pictures.
*   **Spin and Win Feature:**
    *   Dynamic spinning wheel with `CustomPainter`.
    *   Spin animation and result calculation.
    *   Saving spin results to Realtime Database.
*   **Spin History Screen:**
    *   A dedicated screen to display the user's past spin results.
    *   Real-time updates using `StreamBuilder`.
*   **Leaderboard:**
    *   A screen displaying the top 10 players by total winnings.
    *   User scores are updated in real-time after each spin.
    *   Displays user profile pictures.
*   **Statistics Screen:**
    *   A dedicated screen to display the user's spin statistics.
    *   Real-time updates using `StreamBuilder`.
*   **Monetization:**
    *   Integration of Google Mobile Ads SDK.
    *   Rewarded ads allow users to watch an ad to get a free spin.
*   **User Experience:**
    *   A welcome screen for new users to introduce the app.
    *   A bottom navigation bar for easy navigation between the main screens.
    *   A dynamic `AppBar` that displays the user's profile picture and the current screen's title.
*   **Profile Customization:**
    *   A dedicated screen for users to edit their profile information.
    *   Users can update their display name.
    *   Users can upload a profile picture from their device's gallery.
*   **Visual Design Enhancement:**
    *   A consistent and modern theme using Material 3 and `google_fonts`.
    *   Custom styling for buttons, app bars, and other widgets.
    *   Visually appealing layouts with `Card`s and `Container`s.
*   **AI-Powered Spin Analysis:**
    *   An AI-powered feature that analyzes the user's spin history and provides insights.
    *   Integration with the `firebase_ai` package.
*   **Daily Challenges:**
    *   A system of daily challenges to keep users engaged.
    *   A dedicated screen to display challenges and track progress.

## Architecture

*   **State Management:** `provider`
*   **Routing:** `go_router`
*   **Backend:** Firebase (Realtime Database, Storage, Authentication)
*   **UI:** Flutter, Material 3

## Getting Started

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/spin-and-win.git
    ```

2.  **Set up Firebase:**

    *   Create a new Firebase project.
    *   Set up Authentication (Email/Password and Google Sign-In).
    *   Set up Realtime Database.
    *   Set up Firebase Storage.
    *   Download the `google-services.json` file and place it in the `android/app` directory.

3.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

4.  **Run the app:**

    ```bash
    flutter run
    ```

## Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request.

