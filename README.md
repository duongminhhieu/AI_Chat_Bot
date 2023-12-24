# Simple ChatGPT Flutter Version

This is a simple version of **ChatGPT in Flutter**, using your own API key. With this app, you can chat in app with ChatGPT.


|  |  |  |
| - | - | - |
| ![image](https://github.com/duongminhhieu/AI_Chat_Bot/assets/76527212/3d775c83-f740-4dac-be60-4b2de39e49ac) | ![image](https://github.com/duongminhhieu/AI_Chat_Bot/assets/76527212/f64cf8fc-2f1a-42fd-8bfb-7973fa7a11a1) | ![image](https://github.com/duongminhhieu/AI_Chat_Bot/assets/76527212/e18bfea3-cfd6-46c4-84a2-948baa195717) |


## Getting Started
### Prerequisites
Before you start, make sure you have the following:

Flutter installed on your machine. You can follow the instructions here.
An API key for the OpenAI ChatGPT language model. You can apply for an API key here.
### Installation
Clone the repository to your local machine.
Run the app on your device or emulator using flutter run.
You will also need the Xcode to simulate the ios environment.

'''
flutter run
'''

## Features
The app includes the following features:

- Chat with ChatGPT using the OpenAI API
- Display chat history
- Add new conversations
- Rename existing conversations
- Delete conversations


## Boilerplate Features:

* Splash
* Login
* Home
* Routing
* Theme
* Dio
* Database
* MobX (to connect the reactive data of your application with the UI)
* Provider (State Management)
* Encryption
* Validation
* Code Generation
* User Notifications
* Logging
* Dependency Injection
* Dark Theme Support (new)
* Multilingual Support (new)
* Provider example (new)

### Libraries & Tools Used

* [Dio](https://github.com/flutterchina/dio)
* [Database](https://github.com/tekartik/sembast.dart)
* [MobX](https://github.com/mobxjs/mobx.dart) (to connect the reactive data of your application with the UI)
* [Provider](https://github.com/rrousselGit/provider) (State Management)
* [Encryption](https://github.com/xxtea/xxtea-dart)
* [Validation](https://github.com/dart-league/validators)
* [Logging](https://github.com/zubairehman/Flogs)
* [Notifications](https://github.com/AndreHaueisen/flushbar)
* [Json Serialization](https://github.com/dart-lang/json_serializable)
* [Dependency Injection](https://github.com/fluttercommunity/get_it)

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- constants/
|- core/
|- data/
|- domain/
|- presentation/
|- utils/
|- main.dart
|- routes.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`, `dimentions`, `api endpoints`, `preferences` and `strings`.
2- data - Contains the data layer of your project, includes directories for local, network and shared pref/cache.
3- stores - Contains store(s) for state-management of your application, to connect the reactive data of your application with the UI. 
4- ui — Contains all the ui of your project, contains sub directory for each screen.
5- util — Contains the utilities/common functions of your application.
6- widgets — Contains the common widgets for your applications. For example, Button, TextField etc.
7- routes.dart — This file contains all the routes for your application.
8- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### Constants

This directory contains all the application level constants. A separate file is created for each type as shown in example below:

```
constants/
|- app_theme.dart
|- dimens.dart
|- endpoints.dart
|- preferences.dart
|- strings.dart
```

### Data

All the business logic of your application will go into this directory, it represents the data layer of your application. It is sub-divided into three directories `local`, `network` and `sharedperf`, each containing the domain specific logic. Since each layer exists independently, that makes it easier to unit test. The communication between UI and data layer is handled by using central repository.

```
data/
|- local/
    |- constants/
    |- datasources/
    |- app_database.dart
   
|- network/
    |- constants/
    |- exceptions/
    |- rest_client.dart
    
|- sharedpref
    |- constants/
    |- shared_preference_helper.dart
    
|- repository.dart

```

### Stores

The store is where all your application state lives in flutter. The Store is basically a widget that stands at the top of the widget tree and passes it's data down using special methods. In-case of multiple stores, a separate folder for each store is created as shown in the example below:

```
stores/
|- login/
    |- login_store.dart
    |- form_validator.dart
```

### UI

This directory contains all the ui of your application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in `widgets` directory as shown in the example below:

```
ui/
|- login
   |- login_screen.dart
   |- widgets
      |- login_form.dart
      |- login_button.dart
```

### Utils

Contains the common file(s) and utilities used in a project. The folder structure is as follows: 

```
utils/
|- encryption
   |- xxtea.dart
|- date
  |- date_time.dart
```

### Widgets

Contains the common widgets that are shared across multiple screens. For example, Button, TextField etc.

```
widgets/
|- app_icon_widget.dart
|- empty_app_bar.dart
|- progress_indicator.dart
```

### License
MIT License


