import 'package:agent_x/domain/entities/agent.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.agent});
  final Agent agent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: agent.backgroundGradientColors.length > 1
                ? LinearGradient(
                    colors: agent.backgroundGradientColors
                        .map((color) => Color(int.parse(color, radix: 16)))
                        .toList(),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : LinearGradient(
                    colors: [
                      Color(int.parse(agent.backgroundGradientColors[0],
                          radix: 16)),
                      Color(int.parse(agent.backgroundGradientColors[0],
                          radix: 16)),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: agent.name,
                child: Center(
                  child: Image.network(
                    agent.fullPortrait,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                agent.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontFamily: 'Valorant',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                agent.role,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                agent.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Abilities:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              for (int i = 0; i < agent.abilities.length - 1; i++)
                AgentDetailWidget(
                  ability: agent.abilities[i],
                ),
              const SizedBox(height: 24.0),
              const Text(
                'Ultimate:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              AgentDetailWidget(ability: agent.abilities.last)
            ],
          ),
        ),
      ),
    );
  }
}

class AgentDetailWidget extends StatelessWidget {
  const AgentDetailWidget({
    super.key,
    required this.ability,
  });

  final Ability ability;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        ability.displayIcon,
      ),
      title: Text(ability.displayName),
      subtitle: Text(
        ability.description.replaceFirst(RegExp(r'^.*?[.!?]\s'), ''),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
