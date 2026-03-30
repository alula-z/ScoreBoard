# Scoreboard Buddy

A native iOS scoring utility built with SwiftUI and Core Data.

## Overview

Scoreboard Buddy is a lightweight and intuitive iOS application designed to track game scores and maintain scoring history. Whether you're playing casual board games, cards, or keeping competitive scores, this app makes it easy to manage multiple games and contestants.

## Features

- **Score Tracking**: Easily add and update scores in real-time
- **Multiple Games**: Support for tracking multiple concurrent games
- **Game History**: View detailed history of past games and scores
- **Persistent Storage**: Automatic saving using Core Data
- **Clean UI**: Intuitive SwiftUI interface for quick score updates
- **Game Confirmation**: Confirm game results before finalizing

## Technical Details

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Data Persistence**: Core Data
- **Platforms**: iOS 14+

## Project Structure

```
ScoreBoard/
├── ScoreBoard/              # Main application source
│   ├── Model/               # Data models
│   ├── ContentView/         # View components
│   ├── MainView.swift       # Main view controller
│   ├── LandingPage.swift    # Landing page
│   ├── GameConfirm.swift    # Game confirmation view
│   ├── Hitory/              # History views
│   ├── Persistence.swift    # Core Data management
│   └── Assets.xcassets      # App assets
├── ScoreBoardTests/         # Unit tests
├── ScoreBoardUITests/       # UI tests
└── MyScoreBoard.xcodeproj   # Xcode project
```

## Requirements

- iOS 14.0 or later
- Xcode 13.0 or later
- Swift 5.5+

## Getting Started

1. Clone the repository
2. Open `MyScoreBoard.xcodeproj` in Xcode
3. Build and run on a simulator or device

## Usage

1. Launch the app and create a new game
2. Add players/contestants
3. Start tracking scores in real-time
4. View game history to review past games

## License

This project is open source and available under the MIT License.