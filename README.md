

# Flutter Virgin project

#### Projects:

- [Firebase example](./src/projects/firebase/)
- [Todos example](./src/projects/todos/)


## Firebase


### Setup

#### **Prerequisite**

> Login to firebase and create project

#### 1. Download firebase CLI

> - [Firebase docs](https://firebase.google.com/docs/cli#install-cli-windows)
> - [Windows Download](https://firebase.tools/bin/win/instant/latest)


#### 2. Setup local firebase

```sh
firebase login
firebase projects:list
# Copy the Project ID for later
firebase init
firebase use --add
# Add a main as a project alias
```

> [Project Alias](https://firebase.google.com/docs/cli#add_alias)

#### 3. Install flutter firebase dependencies

```sh
flutter pub add firebase_core flutterfire_cli firebase_messaging flutter_local_notifications
```

#### 4. Configure `flutterfire`

```sh
dart pub global activate flutterfire_cli
flutterfire configure
```

#### 5. Add `flutterfire` to PATH

```sh
source tools
# export PATH="$PATH:$HOME/.pub-cache/bin"
```

#### 6. Configure `flutterfire`

```sh
flutterfire configure --project=<project_id>
```

#### 7. Modify `build.gradle.kts`

> See [buld.gradle.kts](./src/projects/firebase/android/app/build.gradle.kts)

#### 8. Implement `NotificationService`

> See [notification_service.dart](./src/projects/firebase/lib/services/notification_service.dart)


### Resources

- [pub.dev - firebase_messaging](https://pub.dev/packages/firebase_messaging/example)
- [pub.dev - flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications/example)
- [Hot to implement Firebase Messageing in Flutter](https://youtu.be/CCrBHh8TcIE)
- [Firebase flutter Get started guide](https://firebase.google.com/docs/cloud-messaging/get-started?platform=flutter&authuser=0#retrieve-the-current-registration-token)
- [developer.android.com - notification channels#importance](https://developer.android.com/develop/ui/views/notifications/channels#importance)
- [What are notification channles](https://www.howtogeek.com/715614/what-are-android-notification-channels/)