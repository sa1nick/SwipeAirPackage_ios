.
├── EnterOTPViewController.txt
├── Podfile
├── structure.md
├── SwipeAirPackage
│   ├── API
│   │   ├── Base
│   │   │   ├── APIConstants.swift
│   │   │   ├── APIEndpoint.swift
│   │   │   ├── AppEnvironment.swift
│   │   │   └── HTTPMethod.swift
│   │   ├── Models
│   │   │   └── Auth
│   │   │       ├── SignUp
│   │   │       │   ├── SignupRequest.swift
│   │   │       │   └── SignupResponse.swift
│   │   │       └── VerifySignUpOtp
│   │   │           ├── SendAndVerifyOtpRequest.swift
│   │   │           └── SendAndVerifyOtpResponse.swift
│   │   └── Services
│   │       ├── APIService.swift
│   │       └── Auth
│   │           └── AuthService.swift
│   ├── App
│   │   ├── HomeScreen
│   │   │   ├── Model
│   │   │   │   └── HomeScreen.swift
│   │   │   ├── View
│   │   │   │   └── HomeContentViewController.swift
│   │   │   └── ViewController
│   │   │       └── HomeViewController.swift
│   │   ├── LoginScreen
│   │   │   ├── Model
│   │   │   │   └── LoginScreen.swift
│   │   │   ├── View
│   │   │   │   └── LoginContentViewController.swift
│   │   │   └── ViewController
│   │   │       └── LoginViewController.swift
│   │   ├── Onboarding
│   │   │   ├── Model
│   │   │   │   └── OnboardingScreen.swift
│   │   │   ├── View
│   │   │   │   ├── OnboardingContentViewController.swift
│   │   │   │   └── SplashScreen.storyboard
│   │   │   └── ViewController
│   │   │       └── OnboardingViewController.swift
│   │   ├── OtpScreen
│   │   │   ├── Model
│   │   │   │   └── EnterOTPScreen.swift
│   │   │   ├── View
│   │   │   │   └── EnterOTPContentViewController.swift
│   │   │   └── ViewController
│   │   │       └── EnterOTPViewController.swift
│   │   ├── SignUpScreen
│   │   │   ├── Model
│   │   │   │   └── SignUpScreen.swift
│   │   │   ├── View
│   │   │   │   └── SignUpContentViewController.swift
│   │   │   └── ViewController
│   │   │       └── SignUpViewController.swift
│   │   └── WelcomeScreen
│   │       ├── Model
│   │       │   └── WelcomeScreen.swift
│   │       └── View
│   │           └── WelcomeContentViewController.swift
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset
│   │   │   └── Contents.json
│   │   ├── BottomTabBar
│   │   │   ├── activityIcon.imageset
│   │   │   │   ├── 🔍-Product-Icons.png
│   │   │   │   ├── 🔍-Product-Icons@2x.png
│   │   │   │   ├── 🔍-Product-Icons@3x.png
│   │   │   │   └── Contents.json
│   │   │   ├── Contents.json
│   │   │   ├── homeIcon.imageset
│   │   │   │   ├── Contents.json
│   │   │   │   ├── style=doutone.png
│   │   │   │   ├── style=doutone@2x.png
│   │   │   │   └── style=doutone@3x.png
│   │   │   ├── Homescreen
│   │   │   │   ├── box.imageset
│   │   │   │   │   ├── box-svgrepo-com (1).png
│   │   │   │   │   ├── box-svgrepo-com (1)@2x.png
│   │   │   │   │   ├── box-svgrepo-com (1)@3x.png
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── car.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   ├── Group 8919.png
│   │   │   │   │   ├── Group 8919@2x.png
│   │   │   │   │   └── Group 8919@3x.png
│   │   │   │   ├── Contents.json
│   │   │   │   ├── customerImage.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   ├── Ellipse 403.png
│   │   │   │   │   ├── Ellipse 403@2x.png
│   │   │   │   │   └── Ellipse 403@3x.png
│   │   │   │   ├── dateTimeIcon.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   ├── date-time-svgrepo-com.png
│   │   │   │   │   ├── date-time-svgrepo-com@2x.png
│   │   │   │   │   └── date-time-svgrepo-com@3x.png
│   │   │   │   ├── office.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   ├── Group 9537.png
│   │   │   │   │   ├── Group 9537@2x.png
│   │   │   │   │   └── Group 9537@3x.png
│   │   │   │   ├── searchIcon.imageset
│   │   │   │   │   ├── Contents.json
│   │   │   │   │   ├── Union 19.png
│   │   │   │   │   ├── Union 19@2x.png
│   │   │   │   │   └── Union 19@3x.png
│   │   │   │   └── swipeairgobanner.imageset
│   │   │   │       ├── Contents.json
│   │   │   │       ├── Group 9201.png
│   │   │   │       ├── Group 9201@2x.png
│   │   │   │       └── Group 9201@3x.png
│   │   │   ├── profileIcon.imageset
│   │   │   │   ├── account-svgrepo-com.png
│   │   │   │   ├── account-svgrepo-com@2x.png
│   │   │   │   ├── account-svgrepo-com@3x.png
│   │   │   │   └── Contents.json
│   │   │   ├── servicesIcon.imageset
│   │   │   │   ├── Contents.json
│   │   │   │   ├── menu-svgrepo-com (1).png
│   │   │   │   ├── menu-svgrepo-com (1)@2x.png
│   │   │   │   └── menu-svgrepo-com (1)@3x.png
│   │   │   └── toolsIcon.imageset
│   │   │       ├── Contents.json
│   │   │       ├── Group 9873.png
│   │   │       ├── Group 9873@2x.png
│   │   │       └── Group 9873@3x.png
│   │   ├── Contents.json
│   │   ├── Misc
│   │   │   ├── Contents.json
│   │   │   ├── eye-slash.imageset
│   │   │   │   ├── Contents.json
│   │   │   │   ├── view-hide-svgrepo-com (1).png
│   │   │   │   ├── view-hide-svgrepo-com (1)@2x.png
│   │   │   │   └── view-hide-svgrepo-com (1)@3x.png
│   │   │   ├── eye.imageset
│   │   │   │   ├── Contents.json
│   │   │   │   ├── view-show-svgrepo-com.png
│   │   │   │   ├── view-show-svgrepo-com@2x.png
│   │   │   │   └── view-show-svgrepo-com@3x.png
│   │   │   └── tick-square.imageset
│   │   │       ├── Contents.json
│   │   │       ├── tick-square-svgrepo-com (1).png
│   │   │       ├── tick-square-svgrepo-com (1)@2x.png
│   │   │       └── tick-square-svgrepo-com (1)@3x.png
│   │   ├── Onboarding
│   │   │   ├── Contents.json
│   │   │   ├── onboarding1.imageset
│   │   │   │   ├── Contents.json
│   │   │   │   ├── Group7500.png
│   │   │   │   ├── Group7500@2x.png
│   │   │   │   └── Group7500@3x.png
│   │   │   ├── onboarding2.imageset
│   │   │   │   ├── Contents.json
│   │   │   │   ├── onboarding2.png
│   │   │   │   ├── onboarding2@2x.png
│   │   │   │   └── onboarding2@3x.png
│   │   │   └── onboarding3.imageset
│   │   │       ├── Contents.json
│   │   │       ├── onboarding3.png
│   │   │       ├── onboarding3@2x.png
│   │   │       └── onboarding3@3x.png
│   │   ├── SplashScreen
│   │   │   ├── Contents.json
│   │   │   └── SplashScreen.imageset
│   │   │       ├── Contents.json
│   │   │       ├── Group8567.jpg
│   │   │       ├── Group8567@2x.jpg
│   │   │       └── Group8567@3x.jpg
│   │   ├── SwipeAirLogo.imageset
│   │   │   ├── Contents.json
│   │   │   ├── Layer 2.png
│   │   │   ├── Layer 2@2x.png
│   │   │   └── Layer 2@3x.png
│   │   └── WelcomeScreen
│   │       ├── appleIcon.imageset
│   │       │   ├── Contents.json
│   │       │   ├── Layer 2.png
│   │       │   ├── Layer 2@2x.png
│   │       │   └── Layer 2@3x.png
│   │       ├── Contents.json
│   │       ├── googleIcon.imageset
│   │       │   ├── Contents.json
│   │       │   ├── Layer 3.png
│   │       │   ├── Layer 3@2x.png
│   │       │   └── Layer 3@3x.png
│   │       ├── metaIcon.imageset
│   │       │   ├── Contents.json
│   │       │   ├── Layer 1.png
│   │       │   ├── Layer 1@2x.png
│   │       │   └── Layer 1@3x.png
│   │       └── welcomeBg.imageset
│   │           ├── Contents.json
│   │           ├── Group9967.png
│   │           ├── Group9967@2x.png
│   │           └── Group9967@3x.png
│   ├── Bridges
│   │   ├── LoginScreenBridgeView.swift
│   │   ├── SignUpScreenBridgeView.swift
│   │   ├── UIKitBottomTabBarBridge.swift
│   │   ├── UIKitEnterOTPBridge.swift
│   │   ├── UIKitOnboardingView.swift
│   │   └── WelcomeScreenBridgeView.swift
│   ├── Components
│   │   ├── Base
│   │   ├── Cells
│   │   ├── RadialGradientLayer.swift
│   │   └── UI
│   │       ├── Buttons
│   │       │   ├── AddressButtonView.swift
│   │       │   ├── SAPButton.swift
│   │       │   ├── SAPSecondaryButton.swift
│   │       │   ├── SAPSocialButtons.swift
│   │       │   └── TabButtonGroupView.swift
│   │       ├── Inputs
│   │       │   ├── SAPOTPInputView.swift
│   │       │   ├── SAPPasswordInputView.swift
│   │       │   ├── SAPPhoneInputView.swift
│   │       │   └── SAPTextInputView.swift
│   │       ├── TabBar
│   │       │   └── BottomTabBarController.swift
│   │       └── TitleSubtitleView.swift
│   ├── Constants
│   ├── ContentView.swift
│   ├── Extentions
│   │   ├── UIApplication+Extensions.swift
│   │   ├── UIColor+Extensions.swift
│   │   ├── UIFont+Jost.swift
│   │   └── UIViewController+Alert.swift
│   ├── Info.plist
│   ├── Item.swift
│   ├── Models
│   ├── Preview Content
│   │   └── Preview Assets.xcassets
│   │       └── Contents.json
│   ├── Resources
│   │   ├── Colors.swift
│   │   └── Fonts
│   │       ├── Jost
│   │       │   ├── Jost-Black.ttf
│   │       │   ├── Jost-BlackItalic.ttf
│   │       │   ├── Jost-Bold.ttf
│   │       │   ├── Jost-BoldItalic.ttf
│   │       │   ├── Jost-ExtraBold.ttf
│   │       │   ├── Jost-ExtraBoldItalic.ttf
│   │       │   ├── Jost-ExtraLight.ttf
│   │       │   ├── Jost-ExtraLightItalic.ttf
│   │       │   ├── Jost-Italic.ttf
│   │       │   ├── Jost-Light.ttf
│   │       │   ├── Jost-LightItalic.ttf
│   │       │   ├── Jost-Medium.ttf
│   │       │   ├── Jost-MediumItalic.ttf
│   │       │   ├── Jost-Regular.ttf
│   │       │   ├── Jost-SemiBold.ttf
│   │       │   ├── Jost-SemiBoldItalic.ttf
│   │       │   ├── Jost-Thin.ttf
│   │       │   ├── Jost-ThinItalic.ttf
│   │       │   └── OFL.txt
│   │       └── Rubik
│   │           ├── Rubik-Black.ttf
│   │           ├── Rubik-BlackItalic.ttf
│   │           ├── Rubik-Bold.ttf
│   │           ├── Rubik-BoldItalic.ttf
│   │           ├── Rubik-ExtraBold.ttf
│   │           ├── Rubik-ExtraBoldItalic.ttf
│   │           ├── Rubik-Italic-VariableFont_wght.ttf
│   │           ├── Rubik-Italic.ttf
│   │           ├── Rubik-Light.ttf
│   │           ├── Rubik-LightItalic.ttf
│   │           ├── Rubik-Medium.ttf
│   │           ├── Rubik-MediumItalic.ttf
│   │           ├── Rubik-Regular.ttf
│   │           ├── Rubik-SemiBold.ttf
│   │           ├── Rubik-SemiBoldItalic.ttf
│   │           └── Rubik-VariableFont_wght.ttf
│   ├── Storyboards
│   │   ├── Home
│   │   ├── Login
│   │   └── Register
│   ├── SwipeAirPackage.entitlements
│   ├── SwipeAirPackageApp.swift
│   └── Utilities
├── SwipeAirPackage.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcshareddata
│   │   │   └── swiftpm
│   │   │       ├── configuration
│   │   │       └── Package.resolved
│   │   └── xcuserdata
│   │       ├── apple.xcuserdatad
│   │       │   └── UserInterfaceState.xcuserstate
│   │       └── khichad.xcuserdatad
│   │           └── UserInterfaceState.xcuserstate
│   └── xcuserdata
│       ├── apple.xcuserdatad
│       │   └── xcschemes
│       │       └── xcschememanagement.plist
│       └── khichad.xcuserdatad
│           ├── xcdebugger
│           │   └── Breakpoints_v2.xcbkptlist
│           └── xcschemes
│               └── xcschememanagement.plist
├── SwipeAirPackageTests
│   └── SwipeAirPackageTests.swift
└── SwipeAirPackageUITests
    ├── SwipeAirPackageUITests.swift
    └── SwipeAirPackageUITestsLaunchTests.swift

105 directories, 211 files
