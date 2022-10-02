![Logo](https://firebasestorage.googleapis.com/v0/b/doctr-fb5bb.appspot.com/o/app_icon.png?alt=media&token=4542471f-e0b9-49e1-8f83-3a2a3f5bf29f)

# Doctr Mobile Application

A mobile application built with flutter to utilize the
[https://prediction-disease-test.herokuapp.com/](https://prediction-disease-test.herokuapp.com/) api but also with additional functionality like authentication with
firebase, data contribution to the model,health news and storing and retrieval of previous diagnosis

## Tech Stack Used

**Client:** Flutter

**Server:** Firebase, Python(flask)

## Installation

Install the application on a mobile(android) device

- Download the release build from [https://github.com/gyatashoa/doctr/releases/download/1.0.1/app-release.apk](https://github.com/gyatashoa/doctr/releases/download/1.0.0/app-release.apk)
- Run the downloaded apk to install the application

## Run Locally

Clone the project

```bash
  git clone https://github.com/gyatashoa/doctr
```

Go to the project directory

```bash
  cd doctr-master
```

Install dependencies

```bash
  flutter pub get
```

Set up stream sdk api

- create a file stream_credential.dart in the config folder
- create two variable named streamKey and secret
- The value of these varibles should be your stream sdk key and secret

Start the application on a mobile device or an emulator

```bash
  flutter run
```

## Authors

- [@Asamoah Yeboah Felix](https://www.github.com/gyatashoa)

## Documentation

[Documentation](https://linktodocumentation)

## 🚀 About Me

My name Asamoah Yeboah Felix, A final year Computer Science student at KNUST
