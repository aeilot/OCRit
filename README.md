# OCRit

OCR it on macOS with DeepSeek-OCR.

OCRit is a small macOS utility written in Swift that uses DeepSeek-OCR to recognize text from the screen and make it available for copying, searching, or further processing. It's designed to be lightweight and simple to use.

## Features
- Capture a region of the screen and run OCR on it
- Fast local OCR using DeepSeek-OCR integration
- Copy recognized text to the clipboard
- Simple macOS-native UI written in Swift

## Requirements
- macOS 11.0+ (Big Sur or later)
- Xcode 13 or newer for building from source
- (Optional) Any required model files or dependencies for DeepSeek-OCR — see project code for details

## Building from source
1. Clone the repository:

   git clone https://github.com/aeilot/OCRit.git
2. Open OCRit.xcodeproj (or OCRit.xcworkspace if using CocoaPods/Carthage/SwiftPM resources) in Xcode.
3. Select a macOS target and a valid signing team in the project settings.
4. Build and run (Cmd+R).

## Usage
1. Launch the app.
2. Grant any requested permissions (Screen Recording and Accessibility) so the app can capture and interact with the screen.
3. Use the app UI to select a region or capture the current screen.
4. Wait briefly while OCR runs; the recognized text will appear and you can copy it to the clipboard.

## Configuration
- If DeepSeek-OCR requires model files or additional configuration, place them according to the instructions in the source files or the project's configuration section.

## Contributing
Contributions and bug reports are welcome. If you'd like to contribute:
1. Open an issue describing the problem or feature.
2. Fork the repo and create a branch for your change.
3. Open a pull request describing your changes.

## Acknowledgements
- DeepSeek-OCR — thank you to the authors/contributors of the OCR model and tooling.

## License
No license file is included in this repository. If you'd like a specific license (for example, MIT), add a LICENSE file or tell me which license you prefer and I can add one.

## Contact
If you have questions or need help, open an issue on the repository: https://github.com/aeilot/OCRit/issues

---

This README was added by GitHub Copilot on request of the repository owner.
