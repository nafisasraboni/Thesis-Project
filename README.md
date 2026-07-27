# 🛡️ MalGuard — Malware Classification Platform

**Enterprise-grade malware detection powered by deep learning (CNN + Bi-LSTM)**  
Flutter • FastAPI • Railway • Supabase • Drift • Riverpod

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Tech Stack](#tech-stack)
4. [Features](#features)
5. [Project Structure](#project-structure)
6. [Design System](#design-system)
7. [Backend API](#backend-api)
8. [Supabase Integration](#supabase-integration)
9. [Setup & Installation](#setup--installation)
10. [Model Export Guide](#model-export-guide)
11. [Screenshots / Pages](#screens)
12. [Roadmap](#roadmap)

---

## Project Overview

MalGuard is a production-grade Flutter client for malware classification and detection, built for thesis defense readiness. It analyzes uploaded files and images through a deep learning pipeline and presents professional-grade result workflows for **Safe**, **Suspicious**, and **Malware Detected** classifications.

| Component | Status |
|-----------|--------|
| Flutter App (UI + Logic) | ✅ Complete |
| Railway Backend API | ✅ Deployed & Live |
| Supabase Auth | ✅ Integrated |
| CNN + Bi-LSTM Model | ⏳ Weights pending upload |

---

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   Flutter Mobile App                     │
│  ┌─────────┐ ┌──────────┐ ┌────────┐ ┌──────────────┐ │
│  │Dashboard│ │ Scanner  │ │History │ │  Analytics   │ │
│  └────┬────┘ └────┬─────┘ └───┬────┘ └──────┬───────┘ │
│       │           │           │               │         │
│  ┌────┴───────────┴───────────┴───────────────┴───────┐ │
│  │              Clean Architecture                     │ │
│  │  Repository → UseCase → Provider → Widget           │ │
│  └──────────────────────┬──────────────────────────────┘ │
│                         │                                │
│  ┌──────────────────────┼──────────────────────────────┐ │
│  │   Riverpod State    │  Drift SQLite    │ Dio HTTP   │ │
│  │     Management      │  (Local Cache)   │   Client   │ │
│  └──────────────────────┼──────────────────────────────┘ │
└─────────────────────────┼───────────────────────────────┘
                          │
          ┌───────────────┴───────────────┐
          │                               │
┌─────────┴──────────┐     ┌─────────────┴──────────────┐
│   Railway Backend   │     │      Supabase Cloud        │
│  (FastAPI + PyTorch) │     │  (Auth + Database + API)   │
│                     │     │                            │
│  POST /api/predict  │     │  Email/Password Auth       │
│  GET /health        │     │  Row-Level Security        │
│                     │     │  Real-time Subscriptions   │
└─────────────────────┘     └────────────────────────────┘
```

---

## Tech Stack

### Frontend (Flutter App)
| Technology | Purpose |
|------------|---------|
| **Flutter 3.x** | Cross-platform UI framework |
| **Riverpod 3.x** | State management |
| **GoRouter 17.x** | Declarative navigation |
| **Drift 2.x** | Local SQLite database |
| **Dio 5.x** | HTTP client |
| **Supabase Flutter 2.x** | Auth + Cloud DB |

### Backend
| Technology | Purpose |
|------------|---------|
| **FastAPI** | Python REST API |
| **PyTorch 2.x** | CNN + Bi-LSTM model inference |
| **Railway** | Cloud deployment (PaaS) |
| **Uvicorn** | ASGI server |

### Cloud Services
| Service | Purpose |
|---------|---------|
| **Railway** | Backend API hosting |
| **Supabase** | Authentication + cloud database |

---

## Features

### ✅ Completed

#### UI/UX
- [x] Premium minimal dark theme design system
- [x] 9 fully redesigned screens
- [x] Responsive layout (phone, tablet, desktop)
- [x] Accessibility (Semantics, 48px tap targets)
- [x] All overflow bugs fixed
- [x] Consistent spacing, typography, border radius
- [x] Reusable component library (20+ widgets)

#### Core Functionality
- [x] File & image upload with preview
- [x] Prediction pipeline (staged workflow)
- [x] Result display with confidence visualization
- [x] Probability distribution charts
- [x] Scan history with search, filter, sort, delete
- [x] CSV export
- [x] Analytics dashboard (trends, distribution, top file types)
- [x] Configurable runtime settings (API URL, timeout, mock/live toggle)

#### Backend
- [x] Railway API deployed (`bi-lstmcnn-production.up.railway.app`)
- [x] `POST /api/predict` — multipart file upload → prediction JSON
- [x] `GET /health` — health check
- [x] CNN + Bi-LSTM model architecture ready
- [x] Fallback prediction mode (deterministic SHA-256 based)

#### Auth
- [x] Supabase project created & configured
- [x] Email/Password Sign In
- [x] Email/Password Sign Up
- [x] Sign Out
- [x] Real anon key integration

### ⏳ Pending
- [ ] Kaggle model weights upload → real inference
- [ ] Cloud database sync for scan history
- [ ] Google OAuth sign-in

---

## Project Structure

```
Thesis-Project/
│
├── README.md                          # This file
│
├── backend/                           # Railway FastAPI Server
│   ├── main.py                        # API server with CNN+BiLSTM model
│   ├── requirements.txt               # Python dependencies
│   ├── Procfile                       # Railway deployment config
│   ├── railway.toml                   # Railway build config
│   └── model_weights.pth              # ⏳ Model weights (upload from Kaggle)
│
├── my_app/                            # Flutter Application
│   ├── lib/
│   │   ├── main.dart                  # App entry point (Supabase init)
│   │   ├── app.dart                   # Root widget with GoRouter
│   │   │
│   │   ├── config/
│   │   │   └── routes/
│   │   │       ├── app_router.dart    # Centralized navigation
│   │   │       └── route_names.dart   # Route constants
│   │   │
│   │   ├── core/
│   │   │   ├── constants/             # AppStrings, durations, limits
│   │   │   ├── network/               # API config, Dio provider
│   │   │   ├── services/              # Supabase initialization
│   │   │   ├── theme/                 # Design system
│   │   │   │   ├── app_colors.dart
│   │   │   │   ├── app_sizes.dart
│   │   │   │   ├── app_text_styles.dart
│   │   │   │   └── app_theme.dart
│   │   │   ├── utils/                 # Formatters, classification
│   │   │   └── widgets/               # Reusable component library
│   │   │       ├── app_card.dart      # Base card container
│   │   │       ├── app_app_bar.dart   # Standardized app bar
│   │   │       ├── primary_button.dart
│   │   │       ├── secondary_button.dart
│   │   │       ├── stat_card.dart
│   │   │       ├── error_card.dart
│   │   │       ├── warning_card.dart
│   │   │       ├── empty_state.dart
│   │   │       ├── history_tile.dart
│   │   │       ├── section_header.dart
│   │   │       ├── upload_card.dart
│   │   │       ├── result_card.dart
│   │   │       ├── image_preview_card.dart
│   │   │       ├── loading_overlay.dart
│   │   │       ├── custom_dialog.dart
│   │   │       ├── custom_snackbar.dart
│   │   │       ├── bottom_navigation.dart
│   │   │       └── responsive_container.dart
│   │   │
│   │   ├── data/local/                # Drift SQLite database
│   │   │
│   │   ├── features/
│   │   │   ├── splash/                # Startup screen
│   │   │   ├── dashboard/             # Security overview
│   │   │   ├── scanner/               # File/image upload + prediction
│   │   │   │   ├── data/services/     # Prediction HTTP service
│   │   │   │   └── presentation/
│   │   │   │       ├── pages/         # Scanner, ScanResult
│   │   │   │       └── widgets/       # Timeline, Summary, Probability
│   │   │   ├── history/               # Scan history management
│   │   │   ├── analytics/             # Charts & metrics
│   │   │   │   └── presentation/widgets/
│   │   │   │       ├── trend_chart.dart
│   │   │   │       ├── distribution_chart.dart
│   │   │   │       └── top_file_types_chart.dart
│   │   │   ├── settings/              # Runtime configuration
│   │   │   ├── about/                 # Thesis info
│   │   │   └── authentication/        # Supabase login
│   │   │
│   │   └── shared/
│   │       ├── presentation/pages/    # App shell with bottom nav
│   │       └── providers/             # Shared Riverpod providers
│   │
│   └── pubspec.yaml                   # Flutter dependencies
│
└── .gitattributes
```

---

## Design System

### Color Palette
| Token | Hex | Usage |
|-------|-----|-------|
| `primary` | `#2563EB` | Primary actions, highlights |
| `background` | `#0F1117` | Scaffold background |
| `surface` | `#1A1D27` | Card backgrounds |
| `surfaceElevated` | `#22252F` | Elevated containers |
| `success` | `#22C55E` | Safe classification |
| `warning` | `#EAB308` | Suspicious classification |
| `danger` | `#EF4444` | Malware detected, errors |
| `info` | `#3B82F6` | Information, secondary actions |
| `textPrimary` | `#F8FAFC` | Primary text |
| `textSecondary` | `#94A3B8` | Secondary text |
| `divider` | `#2E3241` | Borders, separators |

### Typography
| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `display` | 32px | 700 | Hero/large titles |
| `heading` | 24px | 700 | Page titles |
| `subheading` | 18px | 600 | Section titles |
| `body` | 15px | 400 | Primary content |
| `bodySecondary` | 14px | 400 | Supporting text |
| `caption` | 13px | 500 | Metadata |
| `label` | 12px | 600 | Badges, UI labels |
| `button` | 15px | 600 | Button text |
| `metric` | 30px | 700 | Numeric values |

### Spacing Scale
`4, 8, 12, 16, 20, 24, 32, 48`

### Border Radius
`6, 10, 14, 18, 24`

---

## Backend API

### Base URL
```
https://bi-lstmcnn-production.up.railway.app
```

### Endpoints

#### `GET /`
Health/status endpoint.

**Response:**
```json
{
  "status": "online",
  "service": "MalGuard Prediction API"
}
```

#### `GET /health`
Model load status check.

**Response:**
```json
{
  "status": "healthy",
  "model_loaded": false
}
```

#### `POST /api/predict`
Submit a file for malware classification.

**Request:** `multipart/form-data` with field `file`

**Response:**
```json
{
  "prediction": "Suspicious",
  "confidence": 54.0,
  "threat_level": "Medium",
  "processing_time": "0.42 sec",
  "probabilities": {
    "Safe": 54.0,
    "Suspicious": 25.3,
    "Malware": 20.7
  }
}
```

### Classification Labels
| Label | Icon | Color | Description |
|-------|------|-------|-------------|
| **Safe** | ✅ | Green | File appears benign |
| **Suspicious** | ⚠️ | Yellow | Manual review recommended |
| **Malware Detected** | 🚨 | Red | Critical — do not execute |

---

## Supabase Integration

### Project
- **ID:** `awezvaiiyhmysyseraow`
- **Name:** nafisasraboni's Project
- **Region:** Northeast Asia (Seoul)
- **URL:** `https://awezvaiiyhmysyseraow.supabase.co`

### Authentication Features
- Email/Password Sign Up
- Email/Password Sign In
- Session persistence
- Sign Out
- Auth state change listener

### Configuration File
`lib/core/services/supabase_service.dart` contains all Supabase config and service methods.

---

## Setup & Installation

### Prerequisites
- Flutter SDK 3.12+
- Python 3.10+ (for backend)
- Node.js (for CLI tools)

### Flutter App

```bash
cd my_app
flutter pub get
flutter run
```

### Backend (Local Development)

```bash
cd backend
pip install -r requirements.txt
python main.py
# → http://localhost:8000
```

### Backend (Deploy to Railway)

```bash
cd backend
railway login
railway up
```

### CLI Tools Installed

| Tool | Version | Purpose |
|------|---------|---------|
| Node.js | v24.18.0 | Runtime |
| Railway CLI | v5.29.0 | Backend deployment |
| Supabase CLI | v2.109.1 | Database/Auth management |

---

## Model Export Guide

> **Recommended:** Use the auto-detect script at the bottom of your Kaggle notebook.

### Step-by-Step

1. Navigate to: https://www.kaggle.com/code/shadiamou/malware-thesis-final
2. Click **Copy & Edit**
3. Ensure all training cells have been run (**Runtime → Run All**)
4. Add a new cell at the bottom and paste:

```python
import torch, os

# Auto-detect any PyTorch model
found = None
for name in list(dir()):
    try:
        obj = eval(name)
        if isinstance(obj, torch.nn.Module):
            found = name
            print(f"✅ Found model: '{name}'")
            break
    except:
        pass

if found:
    torch.save(eval(found).state_dict(), 'model_weights.pth')
    size_mb = os.path.getsize('model_weights.pth') / 1024 / 1024
    print(f"✅ Saved! Size: {size_mb:.1f} MB")
else:
    print("❌ No model found. Run all training cells first.")
```

5. Run the cell
6. Download `model_weights.pth` from the Output tab
7. Place the file in `backend/` folder
8. Deploy: `cd backend && railway up`
9. Verify: `curl https://bi-lstmcnn-production.up.railway.app/health`

---

## Screens

| # | Screen | Description |
|---|--------|-------------|
| 1 | **Splash** | Animated startup with initialization checklist |
| 2 | **Dashboard** | Security overview, threat ratios, recent scans |
| 3 | **Scanner** | File/image upload, staged detection pipeline |
| 4 | **Scan Result** | Classification result, confidence, probabilities, file metadata |
| 5 | **History** | Search, filter, sort, delete, CSV export |
| 6 | **Analytics** | Trend charts, distribution donut, top file types |
| 7 | **Settings** | API URL config, mock/live toggle, timeout settings |
| 8 | **About** | Thesis objective, architecture, AI integration info |
| 9 | **Authentication** | Supabase email/password sign in & sign up |

---

## Roadmap

### Phase 1: Foundation ✅
- [x] Flutter app with Clean Architecture
- [x] Mock prediction service
- [x] Local SQLite history
- [x] Analytics dashboard

### Phase 2: UI Redesign ✅
- [x] Premium minimal design system
- [x] All 9 screens redesigned
- [x] 20+ reusable widgets
- [x] Accessibility improvements
- [x] Overflow bugs fixed

### Phase 3: Backend ✅
- [x] Railway FastAPI deployment
- [x] CNN + Bi-LSTM architecture
- [x] Fallback prediction mode
- [x] API connected to Flutter

### Phase 4: Auth ✅
- [x] Supabase project setup
- [x] Email/Password auth integration
- [x] Sign In / Sign Up / Sign Out

### Phase 5: Model (In Progress)
- [ ] Kaggle model export
- [ ] Real CNN + Bi-LSTM inference
- [ ] Supabase cloud database sync
- [ ] Google OAuth

---

## Technical Debt & Improvements

- Replace `CyberCard`/`CyberAppBar` deprecated aliases with `AppCard`/`AppAppBar`
- Extract shared `_DetailRow` widget (duplicated in scanner + result pages)
- Extract shared `_AppDropdown` widget (duplicated in history + settings pages)
- Add shimmer loading placeholders
- Implement Supabase cloud sync for scan history

---

## Contributors

- **Shadia Mou** — ML Model (Kaggle Notebook)
- **Nafisa Sraboni** — Full-Stack Development (Flutter + Backend)

---

## License

This project is part of an academic thesis. All rights reserved.

---

**Last Updated:** July 27, 2026  
**Analyzer Status:** ✅ Zero errors, zero warnings  
**API Status:** ✅ Live at `https://bi-lstmcnn-production.up.railway.app`