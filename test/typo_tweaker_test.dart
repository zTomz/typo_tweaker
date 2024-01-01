import 'package:flutter_test/flutter_test.dart';
import 'package:typo_tweaker/typo_tweaker.dart';

void main() {
  test('TypoTweaker builds with initial text', () {
    const text = 'Hello World';
    const animation = TypoTweakerAnimation.buildLetters;

    const tweaker = TypoTweaker(text: text, animation: animation);

    expect(tweaker.text, text);
  });
}
