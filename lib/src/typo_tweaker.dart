import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:typo_tweaker/typo_tweaker.dart';

/// `TypoTweaker` widget that animates text on hover and tap.
///
/// Allows configuring text, animation type, durations, styling, callbacks, etc.
/// Contains StatefulWidget and State classes to manage animation state.
/// Provides two built-in animations: building letters and hacker-style.
class TypoTweaker extends StatefulWidget {
  /// The text to display.
  ///
  /// The animation will be applied to this text.
  final String text;

  /// The animation type to use.
  ///
  /// See [TypoTweakerAnimation].
  final TypoTweakerAnimation animation;

  /// Optional duration for the animation.
  ///
  /// If not provided, defaults will be used.
  final Duration? animationDuration;

  /// Optional text style.
  ///
  /// If not provided, defaults will be used.
  final TextStyle? style;

  /// Optional callback when tapped.
  final void Function()? onTap;

  /// Optional callback when hovered.
  ///
  /// Provides hover state as parameter.
  final void Function(bool value)? onHover;

  /// Optional padding around the text.
  final EdgeInsets? padding;

  /// Optional background color.
  final Color? backgroundColor;

  /// Optional hover color.
  final Color? hoverColor;

  /// Optional border radius.
  final BorderRadius? borderRadius;

  /// Optional custom mouse cursor.
  final MouseCursor? mouseCursor;

  /// Optional duration for hover animations.
  final Duration? hoverDuration;

  const TypoTweaker({
    super.key,
    required this.text,
    required this.animation,
    this.animationDuration,
    this.style,
    this.onTap,
    this.onHover,
    this.padding,
    this.backgroundColor,
    this.hoverColor,
    this.borderRadius,
    this.mouseCursor,
    this.hoverDuration,
  });

  @override
  State<TypoTweaker> createState() => _TypoTweakerState();
}

class _TypoTweakerState extends State<TypoTweaker> {
  String text = "";

  @override
  void initState() {
    super.initState();

    text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: widget.mouseCursor ?? SystemMouseCursors.text,
      borderRadius: widget.borderRadius,
      onTap: () async {
        widget.onTap?.call();

        switch (widget.animation) {
          case TypoTweakerAnimation.buildLetters:
            await buildLettesAnimation();
            break;
          case TypoTweakerAnimation.hacker:
            hackerAnimation();
            break;
        }
      },
      onHover: (value) async {
        widget.onHover?.call(value);

        if (!value) {
          setState(() {
            text = widget.text;
          });
          return;
        }

        switch (widget.animation) {
          case TypoTweakerAnimation.buildLetters:
            await buildLettesAnimation();
            break;
          case TypoTweakerAnimation.hacker:
            hackerAnimation();
            break;
        }
      },
      focusColor: widget.hoverColor ?? Colors.transparent,
      splashColor: widget.hoverColor ?? Colors.transparent,
      highlightColor: widget.hoverColor ?? Colors.transparent,
      hoverColor: widget.hoverColor ?? Colors.transparent,
      hoverDuration: widget.hoverDuration ?? const Duration(milliseconds: 100),
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
        ),
        child: Text(
          text,
          style: widget.style ?? Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }

  /// Animates displaying the text letter by letter.
  ///
  /// Loops through each character in the text, delaying briefly between each one.
  /// After the delay, it updates the state to display the text up to the current
  /// character. This gives the effect of each character appearing slowly.
  ///
  /// The delay duration can be customized with the [animationDuration] parameter.
  Future<void> buildLettesAnimation() async {
    for (int i = 0; i < widget.text.length; i++) {
      await Future.delayed(
        widget.animationDuration ?? const Duration(milliseconds: 100),
      );
      setState(() {
        text = widget.text.substring(0, i + 1);
      });
    }
  }

  /// The letters constant defines the alphabet to use for generating
  /// random letters during the hacker animation.
  static const String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  /// The timer is used to periodically call setState during the
  /// hacker animation to update the displayed text.
  Timer? timer;

  /// Animates the text by randomly replacing letters over time to create a "hacker" effect.
  ///
  /// Uses a [Timer] to periodically call [setState] which replaces letters in the text with random letters from [letters].
  /// The [iteration] variable tracks the index to start replacing from, incrementing over time.
  /// Once [iteration] reaches the text length, the animation is complete.
  Future<void> hackerAnimation() async {
    double iteration = 0;

    timer = Timer.periodic(
        widget.animationDuration ?? const Duration(milliseconds: 30), (timer) {
      setState(() {
        text = text.split("").asMap().entries.map(
          (entry) {
            int index = entry.key;

            if (index < iteration) {
              return widget.text[index];
            }

            return letters[Random().nextInt(26)];
          },
        ).join("");
      });

      if (iteration >= widget.text.length) {
        timer.cancel();
        iteration = 0;

        return;
      }

      iteration += 1 / 3;
    });
  }
}
