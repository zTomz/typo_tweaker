import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:typo_tweaker/typo_tweaker.dart';

class TypoTweaker extends StatefulWidget {
  final String text;
  final TypoTweakerAnimation animation;
  final Duration? animationDuration;
  final TextStyle? style;
  final void Function()? onTap;
  final void Function()? onHover;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? hoverColor;
  final BorderRadius? borderRadius;
  final MouseCursor? mouseCursor;
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
      onTap: () {
        widget.onTap?.call();
      },
      onHover: (value) async {
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

  static const String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  Timer? timer;

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
