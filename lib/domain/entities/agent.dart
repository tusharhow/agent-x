class Agent {
  final String id;
  final String name;
  final String role;
  final String roleDisplayIcon;
  final String background;
  final String description;
  final String displayIcon;
  final List<Ability> abilities;
  final String fullPortrait;
  final List<String> backgroundGradientColors;

  Agent({
    required this.id,
    required this.name,
    required this.role,
    required this.roleDisplayIcon,
    required this.displayIcon,
    required this.abilities,
    required this.fullPortrait,
    required this.background,
    required this.description,
    required this.backgroundGradientColors,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
        id: json['uuid'],
        name: json['displayName'],
        role: json['role']['displayName'],
        roleDisplayIcon: json['role']['displayIcon'],
        displayIcon: json['displayIcon'],
        fullPortrait: json['fullPortrait'],
        background: json['background'],
        description: json['description'],
        backgroundGradientColors:
            json['backgroundGradientColors'].cast<String>(),
        abilities: json['abilities'].map<Ability>((ability) {
          return Ability(
            slot: ability['slot'],
            displayName: ability['displayName'],
            description: ability['description'],
            displayIcon: ability['displayIcon'],
          );
        }).toList());
  }
}

class Ability {
  final String slot;
  final String displayName;
  final String description;
  final String displayIcon;

  Ability(
      {required this.slot,
      required this.displayName,
      required this.description,
      required this.displayIcon});
}
