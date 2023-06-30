import 'package:agent_x/blocs/agent_bloc/agent_bloc.dart';
import 'package:agent_x/blocs/agent_selection_bloc/agent_selection_bloc.dart';
import 'package:agent_x/presentation/screens/detail_screen.dart';
import 'package:agent_x/presentation/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgentScreen extends StatelessWidget {
  const AgentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AgentBloc, AgentState>(
        builder: (context, state) {
          if (state is AgentLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            );
          } else if (state is AgentLoaded) {
            return BlocProvider(
              create: (context) => AgentSelectionBloc(agents: state.agents),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  BlocBuilder<AgentSelectionBloc, AgentSelectionState>(
                    builder: (context, state) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              state.agents[state.selectedIndex].background,
                            ),
                            scale: 2.5,
                            opacity: 0.5,
                          ),
                          gradient: LinearGradient(
                            colors: state.agents[state.selectedIndex]
                                .backgroundGradientColors
                                .map((color) =>
                                    Color(int.parse(color, radix: 16)))
                                .toList(),
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: BlocBuilder<AgentSelectionBloc,
                            AgentSelectionState>(
                          builder: (context, state) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease,
                              child: GestureDetector(
                                onTap: () {
                                  push(
                                    context: context,
                                    widget: DetailScreen(
                                      agent: state.agents[state.selectedIndex],
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: state.agents[state.selectedIndex].name,
                                  child: Image.network(
                                    state.agents[state.selectedIndex]
                                        .fullPortrait,
                                    height: 580.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  BlocBuilder<AgentSelectionBloc, AgentSelectionState>(
                    builder: (context, state) {
                      return Positioned(
                        top: 80.0,
                        child: Text(
                          state.agents[state.selectedIndex].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontFamily: 'Valorant',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<AgentSelectionBloc, AgentSelectionState>(
                    builder: (context, state) {
                      return Positioned(
                        bottom: 0.0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.agents.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<AgentSelectionBloc>()
                                      .add(AgentSelectionEvent(index));
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.ease,
                                  margin: const EdgeInsets.all(8.0),
                                  width: 90.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: state.selectedIndex == index
                                          ? Colors.red
                                          : Colors.transparent,
                                      width: 2.0,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        state.agents[index].displayIcon,
                                      ),
                                      opacity: state.selectedIndex == index
                                          ? 1.0
                                          : 0.5,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No agents found'),
            );
          }
        },
      ),
    );
  }
}
