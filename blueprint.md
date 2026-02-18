
# Project Blueprint

## Overview

This document outlines the architecture, features, and design of the "Spin and Win" Flutter application.

## Implemented Features

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
    *   **Theming:**
        *   Implemented a consistent color scheme and typography using Material 3 and `google_fonts`.
        *   Created a custom `ThemeData` object in `lib/main.dart`.
    *   **Component Styling:**
        *   Styled the buttons, app bars, and other widgets to match the new theme.
        *   Applied the custom theme to the `MaterialApp` widget.
        *   **Welcome Screen:**
            *   A new design with a gradient background and an icon to make it more engaging.
        *   **Login Screen:**
            *   A modern and user-friendly design with a `Card` to create a visually distinct login form.
        *   **Home Screen:**
            *   A `Card`-based menu with icons for a more organized and visually appealing layout.
        *   **Spin Screen:**
            *   A more prominent display for spin results using a `Card`.
        *   **Spin History Screen:**
            *   A more readable layout using `Card`s to display each spin's information.
        *   **Leaderboard Screen:**
            *   A visually engaging design with user avatars, rank highlights, and `Card`s.
        *   **Spinning Wheel:**
            *   A modernized `WheelPainter` with a vibrant color scheme and text shadows.
        *   **Profile Screen:**
            *   A user-friendly design with a `Card` to create a visually distinct profile editing form.
    *   **Layout:**
        *   Improved the layout of the screens to make them more visually appealing and user-friendly.
        *   Used `Card` and `Container` widgets to group and style content.
        *   A new `MainScreen` with a `BottomNavigationBar` to provide a persistent navigation experience.
*   **Current Task: Daily Challenges**

*   **Create `ChallengesScreen`:** A new screen to display a list of daily challenges and the user's progress.
*   **Define a Challenge Data Model:** Create a simple data structure to represent a challenge.
*   **Integrate Challenge Logic:** Modify the `SpinScreen` to check and update challenge progress after each spin.
*   **Display Progress and Rewards:** The `ChallengesScreen` will show the user's progress and a way to claim rewards.
*   **Update Navigation:** Add a new button on the `HomeScreen` to navigate to the `ChallengesScreen`.
