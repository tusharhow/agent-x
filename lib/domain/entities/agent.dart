class Agent {
  final String id;
  final String name;
  final String role;
  final String background;
  final String description;
  final String displayIcon;
  final String fullPortrait;
  final List<String> backgroundGradientColors;

  Agent({
    required this.id,
    required this.name,
    required this.role,
    required this.displayIcon,
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
      displayIcon: json['displayIcon'],
      fullPortrait: json['fullPortrait'],
      background: json['background'],
      description: json['description'],
      backgroundGradientColors: json['backgroundGradientColors'].cast<String>(),
    );
  }
}
