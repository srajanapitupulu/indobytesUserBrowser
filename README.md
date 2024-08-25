# indobytesUserBrowser

This project implements a user browser application for Indobytes, built using SwiftUI.

[Watch Screen recording](https://youtube.com/shorts/Tp-_iOtDXis?si=PWd8_atLi09m6keD)


## Requirements

* macOS with Xcode 14 or later (Apple Silicon or Intel-based Mac)
* Swift 6 (included with Xcode)
* Git version control (download from [https://git-scm.com/](https://git-scm.com/))

## Dependencies

This project uses the Kingfisher package for image loading and caching functionalities.

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/srajanapitupulu/indobytesUserBrowser.git
   cd IndobytesUserBrowser
   ```

2. **Install CocoaPods:**

   [CocoaPods](https://cocoapods.org/) is a dependency management tool for Cocoa projects. If you haven't already, follow the instructions on their website to install it.

3. **Install dependencies:**

   ```bash
   pod install
   ```

   This command will download and install the Kingfisher package and any other dependencies listed in the Podfile.

## Running the Project

1. **Open the workspace:**

   Open the `IndobytesUserBrowser.xcworkspace` file in Xcode.

2. **Choose your device:**

   In the Xcode menu bar, select **Product > Destination**. Choose either a Simulator or a connected iOS device.

3. **Build and run:**

   Click the **Run** button (triangle icon) in the Xcode toolbar. The Indobytes User Browser app will launch on your chosen device.

## Testing the Project

**1. Open the project in Xcode.**

**2. Select the "Test" scheme:**

   In the top left corner of Xcode, select the "Product" menu and choose "Scheme". From the dropdown, select the "IndobytesUserBrowserTests" scheme.

**3. Run the tests:**

   - **Command Line:**
     - Navigate to the project's directory in your terminal.
     - Run the following command:
       ```bash
       xcodebuild test -scheme IndobytesUserBrowserTests -destination 'platform=iOS,OS=14.5,name=iPhone 12 Pro'
       ```
       Replace "iOS,OS=14.5,name=iPhone 12 Pro" with the desired device and OS version.
   - **Xcode:**
     - Click the "Product" menu and select "Test".

**4. View test results:**

   The test results will be displayed in the Test navigator pane. You can see the status of each test case and any error messages.

**Additional Notes:**

* You can create new test cases by adding Swift files to the "Tests" group in your project.
* For more information on unit testing in Xcode, refer to the official Apple documentation: [https://developer.apple.com/documentation/xcode/test-coverage](https://developer.apple.com/documentation/xcode/test-coverage)


## Additional Notes

* Kingfisher documentation can be found here: [https://cocoapods.org/pods/Kingfisher](https://cocoapods.org/pods/Kingfisher)
* For more information on developing SwiftUI apps, refer to the official Apple documentation: [https://developer.apple.com/tutorials/app-dev-training/](https://developer.apple.com/tutorials/app-dev-training/)


## Contributing

If you'd like to contribute, please fork the repository and use a feature branch. Pull requests are warmly welcome.

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a pull request.


## License

This project is licensed under the GPL 3.0 License - see the [LICENSE](LICENSE) file for details.
