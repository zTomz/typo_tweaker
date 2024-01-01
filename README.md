# TypoTweaker 🚀

Welcome to TypoTweaker - the ultimate flutter package for impressive text animations! 💬✨

## What is TypoTweaker?

TypoTweaker is a powerful flutter package that allows you to take your texts to a whole new level. 🌟 With a wealth of animated effects and effortless integration, you can bring your app to life with captivating text animations.

## Features 🎉

- Diverse animations: Choose from a wide range of animated effects to personalize your text and make it stand out.

- Easy integration: TypoTweaker is designed to integrate seamlessly into your Flutter application. A few lines of code are all it takes to create stunning text animations.

- Customization options: Customize the animations to your needs. Control speed, direction and many other parameters for maximum flexibility.

## Installation 🚚
Add TypoTweaker to your Flutter project by adding the following line to your pubspec.yaml file:

```yaml
dependencies:
  typo_tweaker: ^1.0.0
```
Then install the packages with:

```bash
flutter pub get
```

## Example code 🧑‍💻
```dart
import 'package:typo_tweaker/typo_tweaker.dart';
```

```
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: TypoTweaker(
            text: 'Hello, TypoTweaker!
            duration: Duration(seconds: 2),
            animationType: TypoAnimationType.FadeIn,
          ),
        ),
      ),
    ),
  );
}
```

## Contribute 💪
We welcome contributions and feedback! If you have suggestions for improvements or bug reports, simply create an issue or a pull request on GitHub.

## License 📝
TypoTweaker is licensed under the MIT license. See the license file for more details.