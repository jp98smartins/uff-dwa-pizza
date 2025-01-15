enum LoggerColor {
  black(30),
  blue(34),
  brightBlack(90),
  brightBlue(94),
  brightCyan(96),
  brightGreen(92),
  brightMagenta(95),
  brightRed(91),
  brightWhite(97),
  brightYellow(93),
  cyan(36),
  green(32),
  magenta(35),
  red(31),
  white(37),
  yellow(33);

  /// The ANSI code for the color.
  final int asANSI;

  const LoggerColor(this.asANSI);
}
