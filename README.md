# QuestLog – The Gamified Routine Planner

QuestLog is a mobile application that merges traditional time management elements with gamification strategies. The project's core objective is to transform daily routines and tasks into engaging "quests" rather than simple to-do lists.

## Project Overview

Users can build their day using predefined routine blocks and categorize individual tasks into "Main Quests" (high priority) and "Side Quests" (lower priority). A primary focus of the application is the analysis of self-organization through the precise tracking of creation and completion timestamps.

## Key Features

### Functional Requirements
* **Routine Management:** Create and save time blocks (e.g., "Morning Routine") to assemble a daily schedule.
* **Quest System:** Record tasks with metadata such as name, description, category, and frequency.
* **Time Tracking:** Automatic recording of timestamps upon the creation and completion of a quest.
* **Statistics Dashboard:** Visualization of average processing durations per category and progress tracking over weeks or months.
* **Categorization:** Organization of tasks into specific folders or contexts, such as "Semester" or "Winter Vacation".

### Non-Functional Requirements
* **Usability:** High-quality interface design and intuitive operation.
* **Data Persistence:** Local data storage on the device to ensure full offline functionality.
* **Performance:** Smooth execution on standard smartphones, particularly regarding the loading of statistical data.
* **Aesthetics:** An appealing design that actively supports the gamification character of the app.

## Tech Stack

* **Framework:** [Flutter](https://flutter.dev) (Dart programming language).
* **Database:** Local NoSQL database (**Hive** or **Isar**).
* **State Management:** **Provider** or **Riverpod**.
* **Visualizations:** The `fl_chart` library.

## Quality Assurance

* **Unit Tests:** Automated tests of the core logic.
* **Widget Tests:** Verification of UI components.
* **Manual User Testing:** Qualitative surveys to assess the usability of the gamification approach.

## Project Timeline (2026)

| Period | Phase |
| :--- | :--- |
| April – May | Conception & UI/UX Design |
| June – July | Implementation of Core Functions |
| August | Statistics Features & Testing |
| Until Sept. 25 | Documentation & Finalization |

---
**Academic Coursework – Media Informatics**
* **University:** HTW Berlin – University of Applied Sciences
* **Submitted by:** Lukas Kaik
* **Supervisor:** Prof. Dr. Gefei Zhang
* **Submission Deadline:** September 25, 2026