import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff086b5a),
      surfaceTint: Color(0xff086b5a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa1f2dd),
      onPrimaryContainer: Color(0xff00201a),
      secondary: Color(0xff00696c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff9cf1f3),
      onSecondaryContainer: Color(0xff002021),
      tertiary: Color(0xff00696b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9cf1f2),
      onTertiaryContainer: Color(0xff002020),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffef9eb),
      onSurface: Color(0xff1d1c14),
      onSurfaceVariant: Color(0xff49473a),
      outline: Color(0xff7a7768),
      outlineVariant: Color(0xffcbc7b5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff323127),
      inversePrimary: Color(0xff85d6c1),
      primaryFixed: Color(0xffa1f2dd),
      onPrimaryFixed: Color(0xff00201a),
      primaryFixedDim: Color(0xff85d6c1),
      onPrimaryFixedVariant: Color(0xff005143),
      secondaryFixed: Color(0xff9cf1f3),
      onSecondaryFixed: Color(0xff002021),
      secondaryFixedDim: Color(0xff80d4d6),
      onSecondaryFixedVariant: Color(0xff004f51),
      tertiaryFixed: Color(0xff9cf1f2),
      onTertiaryFixed: Color(0xff002020),
      tertiaryFixedDim: Color(0xff80d4d6),
      onTertiaryFixedVariant: Color(0xff004f51),
      surfaceDim: Color(0xffdedacc),
      surfaceBright: Color(0xfffef9eb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f3e5),
      surfaceContainer: Color(0xfff3eee0),
      surfaceContainerHigh: Color(0xffede8da),
      surfaceContainerHighest: Color(0xffe7e2d5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004c40),
      surfaceTint: Color(0xff086b5a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2d8270),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff004b4d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff238183),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff004b4c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff238183),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef9eb),
      onSurface: Color(0xff1d1c14),
      onSurfaceVariant: Color(0xff454336),
      outline: Color(0xff625f51),
      outlineVariant: Color(0xff7e7b6c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff323127),
      inversePrimary: Color(0xff85d6c1),
      primaryFixed: Color(0xff2d8270),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff026858),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff238183),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff006769),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff238183),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff006769),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdedacc),
      surfaceBright: Color(0xfffef9eb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f3e5),
      surfaceContainer: Color(0xfff3eee0),
      surfaceContainerHigh: Color(0xffede8da),
      surfaceContainerHighest: Color(0xffe7e2d5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002820),
      surfaceTint: Color(0xff086b5a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004c40),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff002728),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff004b4d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002728),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff004b4c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef9eb),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff262419),
      outline: Color(0xff454336),
      outlineVariant: Color(0xff454336),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff323127),
      inversePrimary: Color(0xffaafce6),
      primaryFixed: Color(0xff004c40),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00332a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff004b4d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003334),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff004b4c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003334),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdedacc),
      surfaceBright: Color(0xfffef9eb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f3e5),
      surfaceContainer: Color(0xfff3eee0),
      surfaceContainerHigh: Color(0xffede8da),
      surfaceContainerHighest: Color(0xffe7e2d5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff85d6c1),
      surfaceTint: Color(0xff85d6c1),
      onPrimary: Color(0xff00382e),
      primaryContainer: Color(0xff005143),
      onPrimaryContainer: Color(0xffa1f2dd),
      secondary: Color(0xff80d4d6),
      onSecondary: Color(0xff003738),
      secondaryContainer: Color(0xff004f51),
      onSecondaryContainer: Color(0xff9cf1f3),
      tertiary: Color(0xff80d4d6),
      onTertiary: Color(0xff003738),
      tertiaryContainer: Color(0xff004f51),
      onTertiaryContainer: Color(0xff9cf1f2),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff15140c),
      onSurface: Color(0xffe7e2d5),
      onSurfaceVariant: Color(0xffcbc7b5),
      outline: Color(0xff959181),
      outlineVariant: Color(0xff49473a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe7e2d5),
      inversePrimary: Color(0xff086b5a),
      primaryFixed: Color(0xffa1f2dd),
      onPrimaryFixed: Color(0xff00201a),
      primaryFixedDim: Color(0xff85d6c1),
      onPrimaryFixedVariant: Color(0xff005143),
      secondaryFixed: Color(0xff9cf1f3),
      onSecondaryFixed: Color(0xff002021),
      secondaryFixedDim: Color(0xff80d4d6),
      onSecondaryFixedVariant: Color(0xff004f51),
      tertiaryFixed: Color(0xff9cf1f2),
      onTertiaryFixed: Color(0xff002020),
      tertiaryFixedDim: Color(0xff80d4d6),
      onTertiaryFixedVariant: Color(0xff004f51),
      surfaceDim: Color(0xff15140c),
      surfaceBright: Color(0xff3b3930),
      surfaceContainerLowest: Color(0xff0f0e07),
      surfaceContainerLow: Color(0xff1d1c14),
      surfaceContainer: Color(0xff212017),
      surfaceContainerHigh: Color(0xff2c2a21),
      surfaceContainerHighest: Color(0xff37352c),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff89dac5),
      surfaceTint: Color(0xff85d6c1),
      onPrimary: Color(0xff001a15),
      primaryContainer: Color(0xff4d9f8c),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xff84d9db),
      onSecondary: Color(0xff001a1b),
      secondaryContainer: Color(0xff479da0),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff84d9da),
      onTertiary: Color(0xff001a1b),
      tertiaryContainer: Color(0xff479d9f),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff15140c),
      onSurface: Color(0xfffffaf2),
      onSurfaceVariant: Color(0xffd0cbb9),
      outline: Color(0xffa7a392),
      outlineVariant: Color(0xff878374),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe7e2d5),
      inversePrimary: Color(0xff005245),
      primaryFixed: Color(0xffa1f2dd),
      onPrimaryFixed: Color(0xff001510),
      primaryFixedDim: Color(0xff85d6c1),
      onPrimaryFixedVariant: Color(0xff003e33),
      secondaryFixed: Color(0xff9cf1f3),
      onSecondaryFixed: Color(0xff001415),
      secondaryFixedDim: Color(0xff80d4d6),
      onSecondaryFixedVariant: Color(0xff003d3e),
      tertiaryFixed: Color(0xff9cf1f2),
      onTertiaryFixed: Color(0xff001415),
      tertiaryFixedDim: Color(0xff80d4d6),
      onTertiaryFixedVariant: Color(0xff003d3e),
      surfaceDim: Color(0xff15140c),
      surfaceBright: Color(0xff3b3930),
      surfaceContainerLowest: Color(0xff0f0e07),
      surfaceContainerLow: Color(0xff1d1c14),
      surfaceContainer: Color(0xff212017),
      surfaceContainerHigh: Color(0xff2c2a21),
      surfaceContainerHighest: Color(0xff37352c),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffecfff8),
      surfaceTint: Color(0xff85d6c1),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff89dac5),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe9ffff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff84d9db),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe9ffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff84d9da),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff15140c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffffaf2),
      outline: Color(0xffd0cbb9),
      outlineVariant: Color(0xffd0cbb9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe7e2d5),
      inversePrimary: Color(0xff003028),
      primaryFixed: Color(0xffa5f7e1),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff89dac5),
      onPrimaryFixedVariant: Color(0xff001a15),
      secondaryFixed: Color(0xffa0f5f7),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff84d9db),
      onSecondaryFixedVariant: Color(0xff001a1b),
      tertiaryFixed: Color(0xffa0f5f7),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff84d9da),
      onTertiaryFixedVariant: Color(0xff001a1b),
      surfaceDim: Color(0xff15140c),
      surfaceBright: Color(0xff3b3930),
      surfaceContainerLowest: Color(0xff0f0e07),
      surfaceContainerLow: Color(0xff1d1c14),
      surfaceContainer: Color(0xff212017),
      surfaceContainerHigh: Color(0xff2c2a21),
      surfaceContainerHighest: Color(0xff37352c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
