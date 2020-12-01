class TeamUiModel {
  String id;
  String name;
  String country;
  TeamType type;
  int goals;
  int cornerKicks;
  int yellowCards;
  int redCards;
  int offSides;
  int throwIns;
  String color;
}

enum TeamType { home, away, unknown }
