

# Flutter Virgin project

### Setup

#### Prereq

Login to firebase and create project

1. Download firebase CLI
- [Firebase docs](https://firebase.google.com/docs/cli#install-cli-windows)
- [Windows Download](https://firebase.tools/bin/win/instant/latest)

2. Setup local firebase

```sh
firebase login
firebase projects:list
# Copy the Project ID for later
firebase init
firebase use --add
# Add a main as a project alias
```

[Project Alias](https://firebase.google.com/docs/cli#add_alias)

3. Install flutter firebase dependencies

```sh
flutter pub add firebase_messaging
```


4. Install & configure `flutterfire`
```sh
dart pub global activate flutterfire_cli
flutterfire configure
```


5. Add `flutterfire` to PATH

```sh
source tools
# export PATH="$PATH:$HOME/.pub-cache/bin"
````

6. Configure `flutterfire`

```sh
flutterfire configure --project=<project_id>
```
