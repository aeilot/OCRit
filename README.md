# OCR it!

OCR it on macOS with DeepSeek-OCR.

OCRit is a small macOS utility written in Swift that uses DeepSeek-OCR to recognize text from photos and make it available for copying, searching, or further processing. It's designed to be lightweight and simple to use.

<a href="https://www.producthunt.com/products/ocr-it?utm_source=badge-follow&utm_medium=badge&utm_source=badge-ocr&#0045;it" target="_blank"><img src="https://api.producthunt.com/widgets/embed-image/v1/follow.svg?product_id=1126550&theme=light" alt="OCR&#0032;it - OCR&#0032;it&#0032;on&#0032;macOS&#0032;with&#0032;DeepSeek&#0045;OCR | Product Hunt" style="width: 250px; height: 54px;" width="250" height="54" /></a>

## Features
- Drag a photo and run OCR on it
- Fast OCR using DeepSeek-OCR integration
- Recognize photo text content as Markdown with LaTeX support
- Copy recognized text to the clipboard
- Simple macOS-native UI written in Swift

## Screenshots

<img width="612" height="544" alt="image" src="https://github.com/user-attachments/assets/99df5ee4-0c17-4562-9cf5-9dab396af358" />

<img width="612" height="544" alt="Screenshot 2025-11-11 at 16 31 32" src="https://github.com/user-attachments/assets/3b51334d-b9f2-46b7-9b74-d3decec12d09" />

## Installation

Download it straight from the [release page](https://github.com/aeilot/OCRit/releases).

## Requirements
- macOS 26.0+ (Tahoe or later)
- Xcode 26 or newer for building from source
 — see project code for details

## Building from source
1. Clone the repository:
```sh
   git clone https://github.com/aeilot/OCRit.git
```
3. Open OCRit.xcodeproj (or OCRit.xcworkspace if using CocoaPods/Carthage/SwiftPM resources) in Xcode.
4. Select a macOS target and a valid signing team in the project settings.
5. Build and run (Cmd+R).

## Contributing
Contributions and bug reports are welcome. If you'd like to contribute:
1. Open an issue describing the problem or feature.
2. Fork the repo and create a branch for your change.
3. Open a pull request describing your changes.

## Acknowledgements
- [DeepSeek-OCR](https://github.com/deepseek-ai/DeepSeek-OCR/) — thank you to the authors of the OCR model and tooling.
- [Silicon Flow](https://siliconflow.cn/) - thank you for providing the model API.

## Contact
If you have questions or need help, open an issue on the repository: https://github.com/aeilot/OCRit/issues

---

Made with ❤️ by [Louis Deng](https://aeilot.top/)
