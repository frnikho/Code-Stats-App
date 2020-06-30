import 'dart:math';

const double LEVEL_FACTOR = 0.025;

class Language {
  String name;
  int total_xp;
  int news_xp;

  Language(this.name, this.total_xp, this.news_xp);

  int getLevel() => (LEVEL_FACTOR * sqrt(total_xp)).floor();

}