# Outreachy December 2023 to March 2024 Applicants
![logo2](https://github.com/mercyjae/Mboacare_Main/assets/83911888/8e2fc5b7-c741-4dd4-a397-6e18aba0ee79) 
# Mboacare: Create a platform to link-up medical facilities globally:

This repository is dedicated to tracking the progress of our project for the contribution phase. We will be using it to report on our project and keep a record of our work.

## 🧐 Problem Statement <a name = "problem_statement"></a>
"In the global world of healthcare, the ability to  connect medical facilities and provide accessible healthcare services remains a persistent challenge which cause mortality in the society. Patients often face challenges in locating hospital with medical facilities to treat a particular disease/illness, while hospitals struggle to refer patients to appropriate specialized centers. As a result, there is a significant need for a  platform that bridges the gap in healthcare connectivity.


## 💡 Solution <a name = "idea"></a>
The "Mboacare" project seeks to address these challenges by providing an app where hospitals can register their facilities, enabling seamless patient referrals and empowering patients to easily locate and access the healthcare services they require. Its primary goal is to improve healthcare connectivity.
 This project aims to revolutionize healthcare connectivity, making it more accessible and reducing mortality rate.


**Project's Tagline:** ""Your health, Simplified!"

## Getting Started 🚀

## Prerequisites
- Flutter and dart SDK 
- Any preffered IDE(integrated development environment)
- Android Emulator or Physical Device (for Android development):
- iOS Simulator or Physical Device (for iOS development):
- Basic knowledge of firebase.

## Installation Guide
- Navigate to the project directory: `cd your-project`
- Clone the repository:
    ````
     git clone https://github.com/Mboacare_Main.git
    ````  
 

## 🎈 Usage <a name="usage"></a>
- Install Flutter Dependencies:
  - Run the flutter pub get command to fetch and install the Flutter project's dependencies:
    ````
     flutter pub get
    ````
   
- Run the Project:
  - To run the Flutter project, use the flutter run command:
    ````
     flutter run
    ````
   
## ⛏️ Built With <a name = "tech_stack"></a>
- [Flutter](https://flutter.dev/) - Framework

- [Dart](https://dart.dev/) - Language

- [Firebase](https://firebase.google.com/) - Database and Authenticaion.


## Contributing Guide 🚀
 To contribute to this project, please follow these steps:
- Fork the repo
  - <https://github.com/Mboacare_Main.git>
- Clone the forked repo.
  - - <https://github.com/$username/Mboacare_Main.git>
- Check out a new branch based and name it to what you intend to do:
  - Example:
    ````
     git checkout -b BRANCH_NAME
    ````
    
  - Use one branch per fix / feature
- Commit your changes
  - Please provide a git message that explains what you've done
  - Please make sure your commits follow the [conventions](https://gist.github.com/robertpainsi/b632364184e70900af4ab688decf6f53#file-commit-message-guidelines-md)
  - Commit to the forked repository
  - Example:
    ````
     git commit -am 'Add some fooBar'
    ````
- Push to the branch
  - Example:
    ````
     git push origin BRANCH_NAME
    ````
- Make a pull request
  - Submit a pull request, providing a clear description of your changes.
    
  ## Build an APK🚀
-  Enter cd [project]
- Run: flutter build apk --split-per-abi
(The flutter build command defaults to --release.)
This command results in three APK files:

- [project]/build/app/outputs/apk/release/app-armeabi-v7a-release.apk
- [project]/build/app/outputs/apk/release/app-arm64-v8a-release.apk
- [project]/build/app/outputs/apk/release/app-x86_64-release.apk
  
Removing the `--split-per-abi` flag results in a fat APK that contains your code compiled for all the target ABIs. Such APKs are larger in size than their split counterparts, causing the user to download native binaries that are not applicable to their device’s architecture.

## Install APK on Android Device
Load one of the `.apk` files listed above. Which file to load depends on what kind of processor is running on your device.
  
# Features:

- Splash Screen
  - The splash screen gives a good user experience.
- User Authentication
  - User can create account, log in and reset their forgotten password.
- Hospital Registration
  - Hospital can signup by filling a form which consist of their the contact details, services, facilities,hospital size, hospital type(pulic/private), bed capacity, hospital ownership and image.
- Main Dashboard
  - The hospital dashboard shows a list of all the hospitals with the service offered, facilities present, name, address and images .
- Social Media Integration
  - User can join the mboalab community on Likendin
- Hospital Profiles
  - It provides information about each hospital e.g address, phone number, email facilities available, service offered etc.
- Search Functionality
  - Users are able to search for names of hospital.
- Filtering and Sorting
  - Hospitals are filtered based on the services and facilities.
- Dark mode: Enable dark mode in settings.
- Health Tips and Articles: Provide a section with informative articles and health tips related to various medical conditions and wellness.
- Geolocation: Search and view medical facilities, get directions based on location.(Google Map)

  
# Coding Guidelines

- Naming Conventions:
  - Use camelCase for variable and function names.
  - Use PascalCase for class, mixin, enum and extension names.
  - Use UPPER_CASE for constants.
  - Maintain consistent naming, formatting, and code organization across the project.

- File and Directory Structure:
  - Organize your project files and directories logically, grouping related    code together.
  - Use clear and meaningful names for directories and files.

- Widgets and Components:
  - Use descriptive names for custom widgets and components.
  - Break complex widgets into smaller, reusable components.
    
- Lint Rules:
  - Do not ```//ignore for file: $lint_rule``` lint rules in your code.

- Error Handling:
  - Properly handle exceptions and errors in your code.
  - Avoid using generic error handling statements when more specific ones are appropriate.

### Design Guidelines

### Font Family
- *Primary Font:* Inter

###  Color Scheme

- Primary Color: Color(0xFF07470A)
- Secondary Color: Color(0xFF106517)

### Background and Text Colors
- Background Color: Color(0xFFFFFFFF)
- Text Color: Color(0xFF106517)
- Secondary Text Color: Color(0xFF000000)

### Component Colors
- Button Color: Color(0xFF106517);
- Alert Color: Color(0xFF000000)
- Icon Color: Color(0xFF106517)

# **What's Ahead: Future Features:**
- AI recommendations: Personalized hospital suggestions on the dashboard.
- Bookmark feature: Save and organize facilities on hospital details page for easy access.
- Track history: Save booked appointment records.
- Refer: Share users' medical history.
- Telemedicine Integration: Incorporate telemedicine capabilities, allowing users to have virtual consultations with doctors.
- Real-Time Availability: Display real-time availability of appointments, allowing users to book slots instantly.
- Ratings and Reviews: Implement a robust rating and review system for users to share their experiences and help others make informed decisions.
- Multilingual Support: Offer language options for users to access the app in their preferred language.
- Community Forum: Create a platform for users to engage in discussions, ask questions, and share healthcare-related information.

*"Our progress is on track, and the collaboration between design and development is really paying off.*


## ✍️ Contributors <a name = "contributors"></a>:

- [Godwill](https://github.com/godsakani)
- [Carla Ejemeh](https://github.com/Sparklinglily)
- [Anisha](https://github.com/AnishaSingh0118)
- [Deborah](https://github.com/dearlydebbie)

## ✍️ Project Mentor <a name = "project mentor"></a>:

- [Petra](https://github.com/PetraAG)
