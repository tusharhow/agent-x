import 'package:agent_x/domain/entities/agent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.agent});
  final Agent agent;
  @override
  Widget build(BuildContext context) {
    final agentUltimate = agent.abilities.firstWhere(
      (element) => element.slot == "Ultimate",
      orElse: () => agent.abilities.last,
    );
    final Ability? agentPassive = agent.abilities.firstWhereOrNull(
      (element) => element.slot == "Passive",
    );
    final agentAbilities = agent.abilities
        .where((element) => element != agentUltimate && element != agentPassive)
        .toList();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: agent.backgroundGradientColors.length > 1
                  ? LinearGradient(
                      colors: agent.backgroundGradientColors
                          .map((color) => Color(int.parse(color, radix: 16))
                              .withOpacity(0.5))
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
                GestureDetector(
                  // when user drag down, pop the screen
                  onVerticalDragUpdate: (details) {
                    if (details.primaryDelta! > 20) {
                      Navigator.pop(context);
                    }
                  },

                  child: Hero(
                    tag: agent.name,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: agent.fullPortrait,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Hero(
                  tag: '${agent.name}name',
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        agent.name,
                        style: const TextStyle(
                          fontSize: 26,
                          fontFamily: 'Valorant',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Hero(
                  tag: '${agent.name}role',
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: agent.roleDisplayIcon,
                          color: Colors.black54,
                          height: 12.0,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          agent.role,
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 10.0,
                            fontFamily: 'Valorant',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    if (agentPassive != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Passive:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          AgentDetailWidget(ability: agentPassive),
                        ],
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
                    for (int i = 0; i < agentAbilities.length; i++)
                      AgentDetailWidget(
                        ability: agentAbilities[i],
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
                    AgentDetailWidget(ability: agentUltimate),
                  ],
                )
              ],
            ),
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
      leading: CachedNetworkImage(
        imageUrl: ability.displayIcon,
      ),
      title: Text(ability.displayName),
      subtitle: Text(
        ability.description.replaceFirst(RegExp(r'^.*?[.!?]\s'), ''),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
