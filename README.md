<a href="https://www.figma.com/design/txZGZiHops8IR4ZYxmcIML/PiGym?node-id=0-1&t=My3ANloMkPl10rVw-1">
<img src="https://img.shields.io/badge/Figma-Design-%23c11c84.svg?logo=figma&logoColor=white">
</a>

# PiGym

## Features

1. **Practice mode** - practice with configurable practice sessions, change number of digits to guess, duration (endless or timed), starting digit, etc.
2. **Challenge mode** - practice in configurable practice sessions, change number of hints, starting digit, number of digits to guess, time per digit, time mode (endless or timed), mistakes allowed, etc.
3. **Scores** - view statistics of practices and challenges completed, accuracy per digit, etc.
4. **Statistics** - view progression over time and a heatmap of Pi digits guessed in challenge mode (e.g., percentage guessed correctly/incorrectly).
5. **Offline first** - the app does not any require authentication and can run offline.

## Getting started

### Prerequisites

- **Flutter SDK:** Ensure you have [Flutter installed](https://flutter.dev/docs/get-started/install).
- **Dart SDK:** This is included when you install Flutter.

### Installation

1. Clone the repository

   ```bash
   git clone git@github.com:Eoic/PiGym.git
   cd PiGym
   ```

2. Install dependencies

   ```bash
   flutter pub get
   ```

3. Run the application

   **Mobile (Android / iOS)**
   Connect your device or start an emulator and run:

   ```bash
   flutter run
   ```

   **Web**
   Run the following command to launch Papyrus in Chrome (or another supported browser):

   ```bash
   flutter run -f chrome
   ```

   **Desktop**
   Make sure desktop support is enabled by referring to Flutter desktop setup page. Then run:

   ```bash
   flutter run -d screens  # or -d macos, -d linux
   ```

