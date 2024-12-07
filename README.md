# Notes App

A simple Notes App built using **Core Data** and **Swift**, designed to create, edit, delete, and search notes. The app is fully implemented with grouped sections based on note creation dates, enhanced search functionality, and a clean user interface.

## Features

- **Create Notes**: Add new notes with a title and content.
- **Edit Notes**: Tap on an existing note to open the editor and make changes.
- **Delete Notes**: Swipe left on a note in the list to delete it.
- **Search Notes**: Search for notes by title or content.
- **Grouped by Date**: Notes are organized into sections by their creation date.
- **Core Data Integration**: Notes are stored locally using Core Data.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/AishaKarzhauova/NotesApp.git
2. Open the project in Xcode:
cd NotesApp
open Notes.xcodeproj
3. Build and run the app on the simulator or a physical device.

## Requirements

Xcode: Version 14.0 or higher
iOS: 14.0 or higher
Swift: 5.0 or higher

## Usage

- Create a New Note:
Tap the "+" button in the top-right corner.
Enter a title and content, then press "Save."
- Edit an Existing Note:
Tap on a note in the list to open it in the editor.
Make changes and press "Save."
- Delete a Note:
Swipe left on a note in the list to delete it.
- Search Notes:
Use the search bar at the top to find notes by title or content.

## How It Works

- Core Data Integration:
The app uses Core Data to persist notes locally on the device.
Notes are fetched, saved, and deleted using Core Data’s NSManagedObjectContext.
- Grouping by Date:
Notes are grouped into sections based on their creation date using Dictionary(grouping:by:).
- Search Functionality:
The app supports searching by both title and content using filter.
