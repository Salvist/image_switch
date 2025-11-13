# Image Switch

A beautiful Flutter application that displays random images with dynamic theming based on the dominant color of each image. Built with clean architecture principles and modern Flutter practices.

## Features

- 🎨 **Dynamic Theming**: Background color adapts to the dominant color of the displayed image
- 🌓 **Dark/Light Mode**: Toggle between dark and light themes
- 🖼️ **Random Images**: Fetch and display random images with smooth transitions
- 🎯 **Clean Architecture**: Organized with separation of concerns (data, presentation, utils)
- 📱 **Responsive Design**: Works seamlessly across different screen sizes
- 🌐 **Web Support**: Fully compatible with web browsers

## Screenshots

The app features:
- Centered image display with elegant styling
- Smooth color transitions when switching images
- Theme toggle button for dark/light mode
- Error handling with user-friendly messages

## Prerequisites

Before running this project, make sure you have the following installed:

- **Flutter SDK**: Version 3.9.2 or higher
  - [Download Flutter](https://docs.flutter.dev/get-started/install)
- **Chrome** or another web browser for testing
- **Git** (optional, for version control)

## Running on the Browser

### 1. Clone or Navigate to the Project

```bash
cd /path/to/image_switch
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Enable Web Support (if not already enabled)

```bash
flutter config --enable-web
```

### 4. Check Available Devices

```bash
flutter devices
```

You should see Chrome or another browser listed as an available device.

### 5. Run the Application

**Option A: Using Chrome (Recommended)**
```bash
flutter run -d chrome
```

**Option B: Using Web Server**
```bash
flutter run -d web-server
```
This will start a web server and provide a localhost URL (typically http://localhost:xxxxx) that you can open in any browser.

**Option C: Using a specific browser**
```bash
# For Edge
flutter run -d edge

# For Safari (macOS only)
flutter run -d safari
```

### 6. Build for Production (Optional)

To create an optimized production build:

```bash
flutter build web
```

The output will be in the `build/web/` directory. You can serve this directory using any web server:

```bash
# Using Python
cd build/web
python3 -m http.server 8000

# Or using Node.js http-server
npx http-server build/web
```

Then open `http://localhost:8000` in your browser.

## Hot Reload

While the app is running in the browser, you can make changes to the code and press `r` in the terminal to hot reload, or `R` for a full restart.

## Project Structure

```
lib/
├── data/
│   ├── image_data.dart          # Image data model
│   └── image_repository.dart    # Repository for fetching images
├── presentation/
│   ├── image_switch_page.dart   # Main page
│   └── widgets/
│       ├── image_background.dart # Animated background widget
│       ├── image_view.dart       # Image display widget
│       └── theme_notifier.dart   # Theme management
├── utils/
│   └── get_dominant_color.dart  # Color extraction utility
└── main.dart                     # App entry point
```

## Technologies & Packages

- **Flutter**: UI framework
- **http** (^1.6.0): HTTP requests for fetching images
- **image** (^4.5.4): Image processing and color extraction
- **lucide_icons_flutter** (^3.1.6): Beautiful icon set
- **equatable** (^2.0.7): Value equality for data classes
- **web** (^1.1.0): Web platform support

## Troubleshooting

### Port Already in Use
If you get a port conflict error:
```bash
flutter run -d chrome --web-port=8080
```

### CORS Issues
If you encounter CORS issues when fetching images:
```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

### Clear Build Cache
If you experience issues after updating dependencies:
```bash
flutter clean
flutter pub get
flutter run -d chrome
```

## Development

### Adding New Features
1. Follow the existing architecture pattern
2. Place data models in `lib/data/`
3. Place UI components in `lib/presentation/`
4. Place utilities in `lib/utils/`

### Code Style
This project follows Flutter's official style guide and uses `flutter_lints` for static analysis.

## License

This project is open source and available for educational purposes.

## Author

Made by Richie Budijono

---

For more information about Flutter web development, visit the [official Flutter documentation](https://docs.flutter.dev/platform-integration/web).
