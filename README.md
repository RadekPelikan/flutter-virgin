

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

Could be run without `--project=<project_id>`, and prompts user with selection

#### 7. Modify `build.gradle.kts`

> See [buld.gradle.kts](./src/projects/FirebaseFlutter/FirebaseFlutter.App/flutter/android/app/build.gradle.kts)

#### 8. Implement `NotificationService`

> See [notification_service.dart](./src/projects/FirebaseFlutter/FirebaseFlutter.App/flutter/lib/services/notification_service.dart)

#### 9. Download Firebase private key

![Screenshot of Project settings/Service accounts for private key json retrieval](https://miro.medium.com/v2/resize:fit:720/format:webp/1*nWEUjGR3FmBTLYfylAT2pA.png)

> Go to `https://console.firebase.google.com/project/<project_id>/settings/serviceaccounts/adminsdk`<br/>
> Click on `Generate new private key` save the file as `firebase.secret.json`<br/>
> Put `firebase.secret.json` in [FirebaseFlutter.Service](./src/projects/FirebaseFlutter/FirebaseFlutter.Service/) <br/>
> Make sure [FirebaseFlutter.Service.csproj](./src/projects/FirebaseFlutter/FirebaseFlutter.Service/FirebaseFlutter.Service.csproj) has the following setup:<br/>
> ```xml
> <ItemGroup>
>   <Content Update="firebase.secret.json">
>     <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
>   </Content>
> </ItemGroup>
> ``` 


#### 10. Implement BE Notification Service

> See [Program.cs](./src/projects/FirebaseFlutter/FirebaseFlutter.Service/Program.cs)<br/>
> See [NotificationService.cs](./src/projects/FirebaseFlutter/FirebaseFlutter.Service/Services/NotificationService.cs)

#### 11. Run BE Notification Service

```sh
dotnet run --project FirebaseFlutter.Service
```

> Go to http://localhost:5135/swagger

#### 12. Send `POST` request

`fcmToken` has to be token from log output of a flutter app
```sh
curl -X 'POST' \
  'http://localhost:5135/notification' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "title": "Test",
  "body": "Test",
  "fcmToken": "cxFYod3GQuavzSv6209Zyr:APA91bEK9PjJzs4zYSBm3xu6Ij8H42P7HnM7r3gLE2RTnasBz7BMN_PzC09TCPKoV4ClMxq3Z7_o7OFkn-1I9YWBVEhGkd5OFEZ0XOjHi4iBWF-fiPIq50Q"
}'
```

> Go to http://localhost:5135/swagger

### Resources

- [pub.dev - firebase_messaging](https://pub.dev/packages/firebase_messaging/example)
- [pub.dev - flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications/example)
- [Hot to implement Firebase Messageing in Flutter](https://youtu.be/CCrBHh8TcIE)
- [Firebase flutter Get started guide](https://firebase.google.com/docs/cloud-messaging/get-started?platform=flutter&authuser=0#retrieve-the-current-registration-token)
- [developer.android.com - notification channels#importance](https://developer.android.com/develop/ui/views/notifications/channels#importance)
- [What are notification channles](https://www.howtogeek.com/715614/what-are-android-notification-channels/)
- [medium.com - FCM with ASP.NET Core](https://cedricgabrang.medium.com/firebase-cloud-messaging-with-asp-net-core-df666291c427)