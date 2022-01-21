# Introduction 

The objectives behind this project is to build a Learning Management System (LMS) Mobile application, to be highly testable, scalable both vertically and horizontally, as the main objective is to handle up to 400.000 users in education system (students, teachers, parents), loosely coupled, and easily maintainable.
This project is build using Flutter.

# Getting Started
Step 0:

   Install flutter following this link: https://flutter.dev/docs/get-started/install
   
   Set up your favorite editor following this guide: https://flutter.dev/docs/get-started/editor
   
Step 1:

    Download or clone this repo:

Step 2:

   Go to project root and execute the following command in console to get the required dependencies:
   
   flutter pub get 

Step 3:

   This project uses inject library that works with code generation, execute the following command to generate files:
   
   flutter packages pub run build_runner build --delete-conflicting-outputs
   
   or watch command in order to keep the source code synced automatically:
   
   flutter packages pub run build_runner watch

# Build and run

   Use the "flutter run" command to run the application on the emulator/simulator
   
## Extension needed
   
   -Flutter plugin: https://plugins.jetbrains.com/plugin/9212-flutter
   -Dart plugin: https://plugins.jetbrains.com/plugin/6351-dart
   -Bloc plugin: https://plugins.jetbrains.com/plugin/index?xmlId=com.bloc.intellij_generator_plugin
   -Flutter-intl: https://plugins.jetbrains.com/plugin/13666-flutter-intl

# Packages
   Inside the lib/src folder the app is divided in different packages based on the feature.
   Inside of each package related to a specific feature you will find 2 packages:
    -bloc
        Inside this package will be the classes necessary to handle the state for this specific feature. 
        These classes are generated using the Bloc plugin in android studio.
        They follow the conventions of Bloc architecture: https://bloclibrary.dev/
    -view
        Inside this package you will find the view layer for this specific feature.
        2 important concepts in this layer are:
            Scenes: these are widgets which represent a screen
            Components: these are reusable widgets used as building blocks in scenes 
    
   In the lib/components package you will find basic widgets used through-out the app like: Button, Text, Icons, etc 
    
   In the lib/generated package is code generated in compile time which should not be modified by hand.
   
   In the lib/packages are the repository packages for different entities used through-out the app.
    These packages are organized in lib/ and a src/ package inside.
    Each package has a [entity]_repository class which is injected then in the corresponding widgets.
    These repository classes have usually two dependencies: An ApiProvider and a HiveRepository.
    The ApiProvider class is responsible for making the api calls in the backend to fetch the data related to this entity
    The HiveRepository is responsible for fetching data from the local database(Hive: https://pub.dev/packages/hive)
 

# Changing environments
   To change the environment which the application accesses you need to go and change the file located in: lib/packages/http_client/lib/src/config/http_config.dart
   Inside you will find the const variables which represent the baseUrl of the apiEndpoint.
   Here the "baseUrl" and "browserBaseUrl" must be changed to change environment and must be equal.
   ex:
    static const baseUrl = "https://app.stage.akademi.al/";
    static const browserBaseUrl = "https://app.stage.akademi.al";
    or
    static const baseUrl = "https://app.akademi.al/";
    static const browserBaseUrl = "https://app.akademi.al";
    

    