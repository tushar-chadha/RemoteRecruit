# RemoteRecruit

A production-quality iOS job browser app built as a 72-hour take-home assignment.

## Setup
1.  **Environment**: Requires Xcode 15.0+ and iOS 17.0+.
2.  **Installation**: Clone the repository and open `RemoteRecruit.xcodeproj`.
3.  **Dependencies**: The project uses zero third-party libraries. All functionality is built using native Apple frameworks (SwiftUI, Combine, Security, Foundation).
4.  **Running**: Select a simulator (e.g., iPhone 15) and press `Cmd + R`.

## Architecture  
RemoteRecruit follows the **MVVM (Model-View-ViewModel)** architectural pattern combined with a service-oriented approach:
-   **Views**: Declarative SwiftUI views that observe ViewModels.
-   **ViewModels**: Manage UI state and business logic, leveraging `@MainActor` for thread safety.
-   **Services**: Encapsulated network and storage logic (e.g., `JobService`, `SavedJobsManager`).
-   **Models**: Pure data structures conforming to `Codable` and `Identifiable`.

## Key Technical Decisions
-   **Native Stack**: Zero third-party dependencies (like Alamofire or Kingfisher) to demonstrate deep knowledge of native frameworks like `URLSession` and `AsyncImage`.
-   **Async/Await**: Used for all network calls to ensure modern, readable, and efficient concurrency management.
-   **Persistence**: `SavedJobsManager` uses `UserDefaults` with `JSONEncoder` for favorites, while `KeychainManager` is implemented for secure token storage (ready for future Auth expansion).
-   **Design System**: A centralized design system (`AppColors`, `AppTypography`, `AppSpacing`) ensures visual consistency and easy theme management.
-   **UX Refinement**: Implemented skeleton loading with shimmer animations and an expandable text component for long job descriptions.

## Features
-   **Browse Jobs**: Real-time job listings from the Himalayas API with pagination support.
-   **Search**: Debounced search by job title or company with recent search history.
-   **Favorites**: Persistent "Save" functionality allowing users to bookmark jobs for offline viewing.
-   **Job Details**: Rich detail view with floating action buttons and share functionality.
-   **Accessibility**: Full VoiceOver support with custom labels, hints, and traits.

## Testing
-   **Unit Tests**: Over 70% coverage targeting ViewModels and Managers.
-   **Mocks**: Protocol-based dependency injection allows for reliable testing of network failure and success states.
-   **Validation**: Tests cover state transitions (idle -> loading -> loaded/error/empty), pagination logic, and persistence reliability.

## Assumptions
-   **API Limit**: The Himalayas API is treated as the source of truth; however, basic HTML stripping is performed locally to ensure UI safety.
-   **Auth**: While the app supports a "Guest" mode, the infrastructure for secure token storage is pre-integrated in `KeychainManager`.
-   **Offline**: The app requires an internet connection for searching/browsing, but saved jobs are accessible via local persistence.

## API
-   **Source**: Himalayas Public API
-   **Endpoint**: `https://himalayas.app/jobs/api`
-   **Usage**: Utilizes `limit` and `offset` for pagination and `query` for keyword search.
