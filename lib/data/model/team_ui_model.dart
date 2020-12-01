class TeamUiModel {
  final String id;
  final String name;
  final String country;
  final TeamType type;
  final int cornerKicks;
  final int yellowCards;
  final int redCards;
  final int offSides;
  final int throwIns;
  final String color;

  TeamUiModel(
      this.id, this.name, this.country, this.type, this.cornerKicks, this.yellowCards, this.redCards, this.offSides, this.throwIns, this.color);
}

enum TeamType { home, away, unknown }
