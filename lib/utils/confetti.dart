import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CelebrationConfetti extends StatelessWidget {
  const CelebrationConfetti({super.key, required this.controller});

  final ConfettiController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: controller,
        emissionFrequency: 0.1,
        blastDirection: pi * 0.5,
        gravity: 0.002,
        blastDirectionality: BlastDirectionality.directional,
      ),
    );
  }
}