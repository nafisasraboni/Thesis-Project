# MalGuard

MalGuard is a production-structured Flutter application built for a university thesis project.

The app allows users to upload files or images, run a malware detection workflow, display classification results, store scan history locally, and visualize operational analytics. The UI is already prepared to connect to a trained CNN + Bi-LSTM backend without changing the presentation layer.

## Project Goal

This project is the Flutter client for a malware classification and detection system. It is designed to:

- Accept file and image uploads
- Generate file metadata and SHA256 hash
- Send uploaded content to a prediction API
- Display Safe, Suspicious, or Malware Detected results
- Persist scan history locally
- Show analytics and detection statistics
- Remain scalable, maintainable, and backend-agnostic

## Current Status

The app is ready for thesis demonstration and client-side testing.

- Clean Architecture is implemented
- Feature-first structure is implemented
- Riverpod state management is implemented
- GoRouter navigation is implemented
- Drift + SQLite local persistence is implemented
- Mock prediction mode is implemented
- Live API mode is prepared
- `flutter analyze` passes
- `flutter test` passes
- `flutter build apk --debug` passes

## Implemented Features

### 1. App Shell

- Minimal `main.dart`
- Centralized routing
- Splash screen
- Themed app shell
- Reusable UI components

### 2. Dashboard

- Total scanned files
- Safe files
- Suspicious files
- Malware detected files
- Recent scan history
- Threat overview
- Last scan summary
- Quick scan navigation

### 3. Scanner

Supported file types:

- `.exe`
- `.dll`
- `.apk`
- `.pdf`
- `.docx`
- `.zip`
- `.rar`
- `.bin`

Supported image types:

- `.jpg`
- `.jpeg`
- `.png`
- `.bmp`
- `.webp`

Scanner flow:

- File/image selection
- Size validation
- Extension validation
- SHA256 generation
- Staged scan animation
- Prediction request through use case -> repository -> data source -> service

### 4. Scan Result

- Prediction label
- Confidence score
- Probability distribution
- Processing time
- Scan date
- SHA256
- File details
- Threat-specific result cards

Result categories:

- Safe
- Suspicious
- Malware Detected

### 5. History

- Auto-save completed scans
- Search history
- Sort history
- Filter by result type
- Delete a single record
- Clear all history
- Export CSV

### 6. Analytics

- Daily scans
- Weekly scans
- Monthly scans
- Average confidence
- Safe ratio
- Suspicious ratio
- Malware ratio
- Top file types
- Scan trend visualization

### 7. Settings

- Mock prediction on/off
- Prediction API base URL
- Request timeout
- Save history on/off
- Analytics window selection

### 8. About

- Thesis project overview
- Architecture summary
- AI integration summary
- Defense/demo readiness summary

## Architecture

The app follows:

- Clean Architecture
- Feature-First Architecture
- Repository Pattern
- MVVM-style presentation flow
- SOLID-friendly separation

Project layers:

- `presentation`: UI, pages, widgets, controllers/providers
- `domain`: entities, repositories, use cases
- `data`: models, repository implementations, services, data sources

## State Management

Riverpod is used for:

- feature state
- async loading/error handling
- dependency injection
- repository and use case access

## Navigation

Navigation is centralized with GoRouter.

Important files:

- `lib/config/routes/app_router.dart`
- `lib/config/routes/route_names.dart`

## Local Database

Drift with SQLite is used for local persistence.

Stored data currently includes:

- scan history
- persisted app settings

## AI Integration Design

Prediction logic is not placed inside the UI. The scanner communicates through:

- `PredictionUseCase`
- `PredictionRepository`
- `PredictionRemoteDataSource`
- `PredictionService`

Expected API contract:

- Method: `POST`
- Endpoint: `/api/predict`
- Content-Type: `multipart/form-data`

Expected response shape:

```json
{
  "prediction": "Malware Detected",
  "confidence": 96.42,
  "processing_time": "0.41 sec",
  "probabilities": {
    "Safe": 1.23,
    "Suspicious": 2.35,
    "Malware": 96.42
  }
}
```

This means the trained CNN + Bi-LSTM backend can be connected later without redesigning the UI.

## Tech Stack

- Flutter
- Dart
- Riverpod
- GoRouter
- Dio
- Drift
- SQLite
- file_selector
- crypto
- csv

## Project Structure

```text
lib/
  config/
    routes/
  core/
    constants/
    network/
    services/
    theme/
    utils/
    widgets/
  data/
    local/
  features/
    about/
    analytics/
    authentication/
    dashboard/
    history/
    scanner/
    settings/
    splash/
  shared/
    presentation/
    providers/
```

## How To Run

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Run in default demo mode

```bash
flutter run
```

By default, the app uses mock prediction mode for stable demonstration.

### 3. Run with live backend

Use Dart defines to disable mock mode and point to the real API:

```bash
flutter run --dart-define=USE_MOCK_PREDICTION=false --dart-define=PREDICTION_API_BASE_URL=http://127.0.0.1:8000
```

You can also update runtime behavior from the in-app Settings screen.

## Development Commands

Analyze:

```bash
flutter analyze
```

Test:

```bash
flutter test
```

Generate Drift code:

```bash
dart run build_runner build
```

Build debug APK:

```bash
flutter build apk --debug
```

## Notes

- The current build is thesis-demo ready.
- Mock prediction mode is useful when the AI backend is unavailable.
- Authentication is currently a placeholder screen, not a full secure auth system.
- Production release hardening such as secure storage, release signing, and full backend deployment still depends on the final deployment scope.

## Thesis Summary

This application demonstrates how a Flutter frontend can be structured as a professional malware detection client with scalable architecture, local persistence, analytics, and a clean AI integration boundary. It is designed so the trained deep learning model can be connected later with minimal integration changes.
