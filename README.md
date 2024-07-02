# Flutter Feedback Demo

This app is a very simple demo. It showcases the implementation of feedback tools like Wiredash and A/B testing to enhance user experience and improve app performance.

## Table of Contents
- [Educational resources](#educational-resources)
- [Installation](#installation)
- [Wiredash](#wiredash)
- [A/B Testing](#ab-testing)
- [License](#license)

## Educational resources
This app is an illustration for talk "Listen up! Mastering A/B testing and feedback techniques in your mobile apps" that I gave on Fluttercon Europe 2024 in Berlin.
You can check out the slides [here](https://docs.google.com/presentation/d/1czdGS6P3Uu6hgE2OPkFVesrg91N5qN2EWS5eK_Jszko/edit?usp=sharing).

Some other useful resources that I either mentioned in the talk, or wish I had time to mention:
- [Bayesian A/B testing calculator](https://marketing.dynamicyield.com/bayesian-calculator/)
- [A/B testing in Flutter using Unleash and Mixpanel](https://docs.getunleash.io/feature-flag-tutorials/flutter/a-b-testing)

## Installation

### Prerequisites
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter installation

```bash
flutter pub get
```

```bash
flutter run
```



## Wiredash
To use Wiredash, you need to create your account. It offers a generous free tier. You can setup your account [here](https://wiredash.com).

Inside the code, Wiredash is set up in the main.dart file. You need to provide your project id and secret via dart define arguments, or, alternatively, you can paste them directly inside the code.
```bash
flutter run --dart-define=PROJECT_ID=xxx --dart-define=SECRET=zzz
```
```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: const String.fromEnvironment('PROJECT_ID'),
  secret: const String.fromEnvironment('SECRET'),
  child: MaterialApp(
  ...
  ```

Wiredash is used in two places of the app:
- On the app bar of the main screen (product_list_screen.dart), when the user clicks on the bug icon, Wiredash feedback tool will open:
```dart
InkWell(
  onTap: () {
    Wiredash.of(context).show(inheritMaterialTheme: true);
  },
  child: const Padding(
  ...
  ```
- On product screen (product_screen.dart), when user adds item to cart, a NPS form is *maybe* opened.
```dart
void _showPromoterSurvey(BuildContext context) {
  Wiredash.of(context).showPromoterSurvey(
  force: true,
  options: const PsOptions(
      frequency: Duration(days: 90),
	  initialDelay: Duration(days: 7),
	  minimumAppStarts: 3,
	  ),
  );
}
```

### A/B testing
In the service_locator.dart you can select either Firebase or Postgres based code.
