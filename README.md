# Viva Home Mobile

A modern real estate evaluation mobile application built with Flutter, featuring contemporary design and user-friendly interface.

## ✨ Features

- **🚀 Splash Screen**: Welcome screen with logo and loading animation
- **👋 Welcome Page**: Greeting page with login button and gradient design
- **🔐 Login System**: Authentication with bottom sheet modal, email and password validation
- **🏠 Dashboard**: Simple main page with 3 functional cards
- **📋 Property Details**: Property details page with 5 categories (2+2+1 grid layout)
- **🎨 Modern UI**: Design with background images, curved containers and shadows

## 🏗️ Project Architecture

```
lib/
├── main.dart                     # Entry point with Google Fonts
├── pages/                        # Main screens
│   ├── splash_page.dart          # Splash screen with logo
│   ├── welcome_page.dart         # Welcome screen
│   ├── login_page.dart           # Login form (deprecated)
│   ├── home_page.dart            # Main dashboard with 3 cards
│   └── details/
│       └── details_propeties_page.dart  # Property details
├── widgets/                      # Reusable custom widgets
│   ├── custom_button.dart        # Button with pressed state styling
│   ├── custom_text_field.dart    # TextField following Figma design
│   ├── custom_bottom_sheet.dart  # Modal bottom sheet container
│   └── login_form.dart           # Login form with validation
└── utils/                        # Utilities and constants
    ├── constants.dart            # Colors, sizes, strings constants
    └── validation.dart           # Email and password validation

assets/
├── images/
│   └── background1.png           # Background image for pages
└── fonts/                        # Google Fonts (Mulish)
```

## 🎨 Design System

### Colors
- **Primary Teal**: `#1FBCC6` - Main teal color
- **Dark Teal**: `#1A5F7A` - Dark teal for buttons and accents
- **Light Teal**: `#7EE5EB` - Light teal
- **White**: `#FFFFFF` - Card backgrounds and text
- **Light Gray**: `#F5F5F5` - Neutral background
- **Dark Gray**: `#757575` - Secondary text and disabled states
- **Text Dark**: `#2C3E50` - Primary text

### Typography
- **Font**: Mulish (Google Fonts) - Used throughout the app
- **Font Sizes**: 12px to 32px with scale system

### Components
- **Custom Button**: Pressed state styling, adaptive for welcome/login pages
- **Custom TextField**: White background, 12px border radius, prefix/suffix icons
- **Custom Bottom Sheet**: Drag indicator, configurable height and title
- **Cards**: Shadow effects, border radius, hover states

## 🛠️ User Flow

1. **Splash Screen** → Auto navigate after 3 seconds
2. **Welcome Page** → Tap "Login" button
3. **Login Bottom Sheet** → Enter email/password, loading state
4. **Home Dashboard** → 3 cards: Details, Survey, Surveyors Requests
5. **Property Details** → 5 categories: General, External, Internal, Services, Additional

## 📱 Main Features

### Login System
- Bottom sheet modal instead of full page
- Real-time validation (email format, password length)
- Loading states with spinner
- Error handling and success feedback

### Dashboard
- Simplified design with 3 main cards
- Background image with curved overlay container
- Map-based data structure for easy maintenance
- Navigation to Property Details

### Property Details
- Grid layout 2+2+1 (2 cards/row, 1 card centered)
- 5 categories with icons and titles
- Consistent styling with homepage
- Back navigation

## 🔧 Technical Implementation

### State Management
- StatefulWidget with setState
- Local state for forms and UI interactions

### Navigation
- MaterialPageRoute with Navigator.push/pop
- Parameter passing (username) between pages

### Data Architecture
- Map-based approach for dynamic content
- Centralized constants for strings, colors, sizes
- Reusable widget patterns

### Code Quality
- Extracted inline data into separate methods
- Consistent naming conventions
- Proper widget composition
- Error handling and validation

## 🚀 Installation and Setup

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code

### Installation
```bash
# Clone repository
git clone <repository-url>
cd viva_home_mobile

# Install dependencies
flutter pub get

# Run application
flutter run
```

### Build for Production
```bash
# Android APK
flutter build apk --release

# iOS (requires macOS)
flutter build ios --release
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  google_fonts: ^5.1.0        # Mulish font family

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
```

## 📸 Screenshots

### 🚀 Splash Screen
- Viva logo with loading indicator
- Auto navigation to Welcome page

### 👋 Welcome Page  
- Background image with gradient overlay
- "Login" button with hover effects
- Clean and modern design

### 🔐 Login Modal
- Bottom sheet with drag indicator
- Email and password fields with validation
- Loading spinner on submit
- Real-time error messages

### 🏠 Home Dashboard
- Header with username and logout
- 3 main feature cards:
  - 📋 Details (enabled) → Property Details
  - 🏠 Survey (enabled) → Placeholder
  - 📄 Surveyors Requests (disabled)

### 📋 Property Details
- 5 category cards in grid layout:
  - 🔑 General, 🏠 External (Row 1)
  - 🚪 Internal, 🔧 Services (Row 2)  
  - ➕ Additional (Row 3, centered)
- Consistent styling with shadows and borders

## 🎯 Future Enhancements

- [ ] Implement actual survey functionality
- [ ] Add property data management
- [ ] Integrate with backend API
- [ ] Add offline support
- [ ] Implement push notifications
- [ ] Add image capture and upload
- [ ] Multi-language support
- [ ] Advanced search and filtering

## 👥 Development Notes

- Code organized with component-based architecture
- Map-based data structures to reduce code duplication
- Consistent styling system with centralized constants
- Responsive design patterns for different screen sizes
- Clean separation between UI and business logic

---

**Built with ❤️ using Flutter**
