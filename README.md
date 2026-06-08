****# 🚀 RemoteRecruit
**[📹 Watch the demo](https://drive.google.com/file/d/1GnsUGyxXlXyb98xp6XCuIhalPkU6ECeF/view?usp=drivesdk)**

A production-oriented iOS application built as part of the RemoteRecruit Technical Examination.

The project demonstrates modern iOS engineering practices using SwiftUI, MVVM, Async/Await, Protocol-Oriented Dependency Injection, Local Persistence, Session Management, and Dark Mode support, while maintaining a clean and scalable architecture.

---

# ✅ Examination Requirements Coverage

### Job Listing
- Display jobs from Himalayas API
- Job title
- Company name
- Location
- Salary information
- Pull to refresh

### Search
- Search by title
- Search by company
- Debounced search requests
- Search result handling
- Search history persistence

### Job Details
- Job description
- Company information
- Salary details
- Location details
- Apply URL
- Share functionality

### State Handling
- Loading states
- Empty states
- Error states
- Retry handling
- Offline awareness

### Architecture
- MVVM
- Protocol-Oriented Dependency Injection
- Async/Await
- Service Layer Architecture
- Feature-Based Folder Structure

### Deliverables
- Architecture Documentation
- Clean Git History
- Scalable Code Structure
- Production-Ready Design System

---

# 🌟 What Makes This Submission Stand Out

While the assignment requirements have been fully implemented, the project also includes several production-focused improvements beyond the requested scope.

### Advanced Search Experience
- 400ms debounced search
- Persistent recent searches
- Dedicated search screen
- Instant search suggestions

### Saved Jobs System
- Save and unsave jobs
- Persistent local storage
- Dedicated Saved Jobs screen
- State synchronization across the application

### Authentication Foundation
- Guest Mode support
- Session Manager architecture
- Keychain-ready secure token storage
- Auto-login infrastructure

### Modern Design System
- Centralized typography
- Centralized spacing system
- Centralized color system
- Full Dark Mode support
- Reusable SwiftUI components

### Enhanced Job Detail Experience
- Expandable descriptions
- Expandable requirements
- Floating Apply button
- Share job functionality
- Persistent favorite state

### Native iOS Experience
- SwiftUI-first architecture
- Custom floating glass tab bar
- Native navigation patterns
- Haptic feedback integration
- Dynamic appearance support

---

# 🏗 Architecture

The application follows a layered MVVM architecture.

text SwiftUI View       ↓ ViewModel       ↓ Service Protocol       ↓ Service Implementation       ↓ Network Layer       ↓ URLSession       ↓ API 

### Architectural Principles

- Separation of Concerns
- Single Responsibility Principle
- Dependency Inversion
- Testability
- Scalability
- Reusability

---

# 📁 Project Structure

text RemoteRecruit  App ├── RemoteRecruitApp ├── RootView └── AppEnvironment  Core ├── Network ├── Storage ├── DesignSystem ├── Utilities └── Managers  Features ├── JobList ├── JobDetail ├── Search ├── SavedJobs ├── Profile ├── Authentication └── MainTab  Models ├── Job ├── JobResponse ├── ViewState └── AppError  Services ├── JobService ├── JobServiceProtocol └── NetworkService  Tests ├── Services ├── Managers └── ViewModels 

---

# 🔧 Technical Decisions

## Native Apple Frameworks Only

The project intentionally avoids third-party dependencies to demonstrate proficiency with Apple's native ecosystem.

Frameworks used:

- SwiftUI
- Foundation
- URLSession
- Combine
- Security
- AsyncImage

---

## Async/Await Networking

All network requests utilize Swift Concurrency.

Benefits:

- Cleaner asynchronous code
- Improved readability
- Reduced callback nesting
- Better error propagation

---

## Protocol-Based Dependency Injection

Services are injected through protocols rather than concrete implementations.

Benefits:

- Improved testability
- Loose coupling
- Easier mocking
- Better maintainability

---

## Persistence Strategy

### UserDefaults

Used for:

- Recent searches
- Saved jobs
- Guest mode state

### Keychain

Implemented for:

- Authentication tokens
- Secure credentials
- Future authentication expansion

---

## Design System

A centralized design system provides consistency throughout the application.

### Typography

- App Title
- Section
- Body
- Caption

### Spacing

- 8
- 16
- 24
- 32

### Colors

- Primary
- Background
- Card Background
- Text Primary
- Text Secondary
- Border
- State Colors

---

# ✨ Features

## Browse Jobs

- Real-time API integration
- Pagination support
- Pull-to-refresh
- Loading states

## Search

- Debounced requests
- Company search
- Title search
- Recent searches

## Saved Jobs

- Persistent favorites
- Dedicated saved jobs screen
- Instant synchronization

## Job Details

- Rich job information
- Expandable sections
- Share functionality
- Apply URL handling

## Profile

- Guest mode support
- Session management
- Logout handling

## Dark Mode

- Full application support
- Dynamic system colors
- Adaptive UI components

---

# 🧪 Testing Strategy

The architecture is designed for unit testing through protocol abstractions and dependency injection.

Covered scenarios:

### ViewModel Tests

- Loading state
- Success state
- Empty state
- Error state
- Search functionality

### Service Tests

- API success
- API failure
- Decoding validation

### Persistence Tests

- Saved jobs
- Search history
- Session management

---

# 📡 API

### Source

Himalayas Jobs API

### Features Used

- Job Listings
- Pagination
- Search

### Parameters

- limit
- offset
- query

---

# 🚀 Setup

### Requirements

- Xcode 15+
- iOS 17+
- Swift 5.9+

### Installation

bash git clone <repository-url> cd RemoteRecruit open RemoteRecruit.xcodeproj 

### Run

1. Select an iOS Simulator
2. Press Cmd + R

No additional configuration or third-party dependencies are required.

---

# 📝 Assumptions

- Himalayas API is treated as the source of truth.
- Network connectivity is required for job discovery.
- Saved jobs remain accessible through local persistence.
- Authentication infrastructure is prepared for future Google + Supabase integration.

---

# 🔮 Future Improvements

- Offline job caching
- Image caching
- Push notifications
- Deep linking
- Analytics
- Advanced filtering
- Job alerts
- Google Authentication
- Supabase Integration
- Full UI Test Coverage

---

# 👨‍💻 Author

Built as part of the RemoteRecruit iOS Technical Examination using SwiftUI, MVVM, and modern Apple development practices****`@MainActor` ViewModels · Protocol-injected services · Feature-based folders · Keychain + UserDefaults persistence

---

## Run it

```bash
git clone <repo-url> && open RemoteRecruit.xcodeproj
```

iOS 17+ simulator · No keys · No config · No third-party deps

---

## API

[Himalayas Jobs API](https://himalayas.app/jobs/api) — pagination, search, no key required
