import 'package:flutter/material.dart';

const Green = Color(0xFF24CA49);
const Orange = Color(0xFFFF9315);
const Violet = Color(0xFF8E0CF5);
const Red = Color(0xFFFD4439);
const Cyan = Color(0xFF06A0F6);

CustomColors lightCustomColors = const CustomColors(
  Green: Color(0xFF006E20),
  onGreen: Color(0xFFFFFFFF),
  GreenContainer: Color(0xFF6FFF7B),
  onGreenContainer: Color(0xFF002105),
  Orange: Color(0xFF8E4E00),
  onOrange: Color(0xFFFFFFFF),
  OrangeContainer: Color(0xFFFFDCC1),
  onOrangeContainer: Color(0xFF2E1500),
  Violet: Color(0xFF8800EC),
  onViolet: Color(0xFFFFFFFF),
  VioletContainer: Color(0xFFEFDBFF),
  onVioletContainer: Color(0xFF2B0052),
  Red: Color(0xFFBD0F13),
  onRed: Color(0xFFFFFFFF),
  RedContainer: Color(0xFFFFDAD5),
  onRedContainer: Color(0xFF410001),
  Cyan: Color(0xFF00639B),
  onCyan: Color(0xFFFFFFFF),
  CyanContainer: Color(0xFFCEE5FF),
  onCyanContainer: Color(0xFF001D33),
);

CustomColors darkCustomColors = const CustomColors(
  Green: Color(0xFF46E25E),
  onGreen: Color(0xFF00390C),
  GreenContainer: Color(0xFF005316),
  onGreenContainer: Color(0xFF6FFF7B),
  Orange: Color(0xFFFFB779),
  onOrange: Color(0xFF4C2700),
  OrangeContainer: Color(0xFF6C3A00),
  onOrangeContainer: Color(0xFFFFDCC1),
  Violet: Color(0xFFDCB8FF),
  onViolet: Color(0xFF480082),
  VioletContainer: Color(0xFF6700B5),
  onVioletContainer: Color(0xFFEFDBFF),
  Red: Color(0xFFFFB4AA),
  onRed: Color(0xFF690003),
  RedContainer: Color(0xFF930007),
  onRedContainer: Color(0xFFFFDAD5),
  Cyan: Color(0xFF96CBFF),
  onCyan: Color(0xFF003353),
  CyanContainer: Color(0xFF004A76),
  onCyanContainer: Color(0xFFCEE5FF),
);

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.Green,
    required this.onGreen,
    required this.GreenContainer,
    required this.onGreenContainer,
    required this.Orange,
    required this.onOrange,
    required this.OrangeContainer,
    required this.onOrangeContainer,
    required this.Violet,
    required this.onViolet,
    required this.VioletContainer,
    required this.onVioletContainer,
    required this.Red,
    required this.onRed,
    required this.RedContainer,
    required this.onRedContainer,
    required this.Cyan,
    required this.onCyan,
    required this.CyanContainer,
    required this.onCyanContainer,
  });

  final Color? Green;
  final Color? onGreen;
  final Color? GreenContainer;
  final Color? onGreenContainer;
  final Color? Orange;
  final Color? onOrange;
  final Color? OrangeContainer;
  final Color? onOrangeContainer;
  final Color? Violet;
  final Color? onViolet;
  final Color? VioletContainer;
  final Color? onVioletContainer;
  final Color? Red;
  final Color? onRed;
  final Color? RedContainer;
  final Color? onRedContainer;
  final Color? Cyan;
  final Color? onCyan;
  final Color? CyanContainer;
  final Color? onCyanContainer;

  @override
  CustomColors copyWith({
    Color? Green,
    Color? onGreen,
    Color? GreenContainer,
    Color? onGreenContainer,
    Color? Orange,
    Color? onOrange,
    Color? OrangeContainer,
    Color? onOrangeContainer,
    Color? Violet,
    Color? onViolet,
    Color? VioletContainer,
    Color? onVioletContainer,
    Color? Red,
    Color? onRed,
    Color? RedContainer,
    Color? onRedContainer,
    Color? Cyan,
    Color? onCyan,
    Color? CyanContainer,
    Color? onCyanContainer,
  }) {
    return CustomColors(
      Green: Green ?? this.Green,
      onGreen: onGreen ?? this.onGreen,
      GreenContainer: GreenContainer ?? this.GreenContainer,
      onGreenContainer: onGreenContainer ?? this.onGreenContainer,
      Orange: Orange ?? this.Orange,
      onOrange: onOrange ?? this.onOrange,
      OrangeContainer: OrangeContainer ?? this.OrangeContainer,
      onOrangeContainer: onOrangeContainer ?? this.onOrangeContainer,
      Violet: Violet ?? this.Violet,
      onViolet: onViolet ?? this.onViolet,
      VioletContainer: VioletContainer ?? this.VioletContainer,
      onVioletContainer: onVioletContainer ?? this.onVioletContainer,
      Red: Red ?? this.Red,
      onRed: onRed ?? this.onRed,
      RedContainer: RedContainer ?? this.RedContainer,
      onRedContainer: onRedContainer ?? this.onRedContainer,
      Cyan: Cyan ?? this.Cyan,
      onCyan: onCyan ?? this.onCyan,
      CyanContainer: CyanContainer ?? this.CyanContainer,
      onCyanContainer: onCyanContainer ?? this.onCyanContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      Green: Color.lerp(Green, other.Green, t),
      onGreen: Color.lerp(onGreen, other.onGreen, t),
      GreenContainer: Color.lerp(GreenContainer, other.GreenContainer, t),
      onGreenContainer: Color.lerp(onGreenContainer, other.onGreenContainer, t),
      Orange: Color.lerp(Orange, other.Orange, t),
      onOrange: Color.lerp(onOrange, other.onOrange, t),
      OrangeContainer: Color.lerp(OrangeContainer, other.OrangeContainer, t),
      onOrangeContainer: Color.lerp(onOrangeContainer, other.onOrangeContainer, t),
      Violet: Color.lerp(Violet, other.Violet, t),
      onViolet: Color.lerp(onViolet, other.onViolet, t),
      VioletContainer: Color.lerp(VioletContainer, other.VioletContainer, t),
      onVioletContainer: Color.lerp(onVioletContainer, other.onVioletContainer, t),
      Red: Color.lerp(Red, other.Red, t),
      onRed: Color.lerp(onRed, other.onRed, t),
      RedContainer: Color.lerp(RedContainer, other.RedContainer, t),
      onRedContainer: Color.lerp(onRedContainer, other.onRedContainer, t),
      Cyan: Color.lerp(Cyan, other.Cyan, t),
      onCyan: Color.lerp(onCyan, other.onCyan, t),
      CyanContainer: Color.lerp(CyanContainer, other.CyanContainer, t),
      onCyanContainer: Color.lerp(onCyanContainer, other.onCyanContainer, t),
    );
  }

  // CustomColors harmonized(ColorScheme dynamic) {
  //   return copyWith(
  //     Green: Green!.harmonizeWith(dynamic.primary),
  //     onGreen: onGreen!.harmonizeWith(dynamic.primary),
  //     GreenContainer: GreenContainer!.harmonizeWith(dynamic.primary),
  //     onGreenContainer: onGreenContainer!.harmonizeWith(dynamic.primary),
  //     Orange: Orange!.harmonizeWith(dynamic.primary),
  //     onOrange: onOrange!.harmonizeWith(dynamic.primary),
  //     OrangeContainer: OrangeContainer!.harmonizeWith(dynamic.primary),
  //     onOrangeContainer: onOrangeContainer!.harmonizeWith(dynamic.primary),
  //     Violet: Violet!.harmonizeWith(dynamic.primary),
  //     onViolet: onViolet!.harmonizeWith(dynamic.primary),
  //     VioletContainer: VioletContainer!.harmonizeWith(dynamic.primary),
  //     onVioletContainer: onVioletContainer!.harmonizeWith(dynamic.primary),
  //     Red: Red!.harmonizeWith(dynamic.primary),
  //     onRed: onRed!.harmonizeWith(dynamic.primary),
  //     RedContainer: RedContainer!.harmonizeWith(dynamic.primary),
  //     onRedContainer: onRedContainer!.harmonizeWith(dynamic.primary),
  //     Cyan: Cyan!.harmonizeWith(dynamic.primary),
  //     onCyan: onCyan!.harmonizeWith(dynamic.primary),
  //     CyanContainer: CyanContainer!.harmonizeWith(dynamic.primary),
  //     onCyanContainer: onCyanContainer!.harmonizeWith(dynamic.primary),
  //   );
  // }
}