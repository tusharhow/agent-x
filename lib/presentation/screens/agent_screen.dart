import 'package:agent_x/blocs/agent_bloc/agent_bloc.dart';
import 'package:agent_x/blocs/agent_selection_bloc/agent_selection_bloc.dart';
import 'package:agent_x/presentation/screens/detail_screen.dart';
import 'package:agent_x/presentation/widgets/navigate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgentScreen extends StatelessWidget {
  const AgentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();
    final PageController pageController = PageController();
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
                        return PageView.builder(
                          itemCount: state.agents.length,
                          controller: pageController,
                          onPageChanged: (index) {
                            scrollController.animateTo(
                              index * 100.0, // Adjust the item width as needed
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease,
                            );
                            context
                                .read<AgentSelectionBloc>()
                                .add(AgentSelectionEvent(index));
                          },
                          itemBuilder: (context, index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    state.agents[index].background,
                                  ),
                                  scale: 2.5,
                                  opacity: 0.5,
                                ),
                                gradient: LinearGradient(
                                  colors: state
                                      .agents[index].backgroundGradientColors
                                      .map((color) =>
                                          Color(int.parse(color, radix: 16))
                                              .withOpacity(0.5))
                                      .toList(),
                                  begin: Alignment.topCenter,
                                  transform: const GradientRotation(0.2),
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: AnimatedBuilder(
                                  animation: pageController,
                                  builder: (context, child) {
                                    double rotation = 0.0;
                                    if (pageController
                                            .position.haveDimensions &&
                                        pageController.position
                                            .isScrollingNotifier.value) {
                                      // Calculate the rotation based on the difference between the current page and the index
                                      rotation = -pageController.page! + index;

                                      // If the difference is less than 0.5, add a transition to the next agent
                                      if ((index - pageController.page!).abs() <
                                          0.5) {
                                        rotation = (rotation) *
                                            1.5; // Apply a transition effect
                                      }
                                    }
                                    return Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(rotation),
                                      child: GestureDetector(
                                        onTap: () {
                                          push(
                                            context: context,
                                            widget: DetailScreen(
                                              agent: state
                                                  .agents[state.selectedIndex],
                                            ),
                                          );
                                        },
                                        onVerticalDragUpdate: (_) {
                                          // when user drag up or tap, push the screen

                                          if (_.primaryDelta! < -20) {
                                            push(
                                              context: context,
                                              widget: DetailScreen(
                                                agent: state.agents[
                                                    state.selectedIndex],
                                              ),
                                            );
                                          }
                                        },
                                        child: Hero(
                                          tag: state
                                              .agents[state.selectedIndex].name,
                                          child: Image(
                                            image: CachedNetworkImageProvider(
                                                state
                                                    .agents[state.selectedIndex]
                                                    .fullPortrait),
                                            height: 580.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          },
                        );
                      },
                    ),
                    BlocBuilder<AgentSelectionBloc, AgentSelectionState>(
                      builder: (context, state) {
                        return Positioned(
                          top: 80.0,
                          child: Column(
                            children: [
                              Text(
                                state.agents[state.selectedIndex].name,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 40.0,
                                  fontFamily: 'Valorant',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: state.agents[state.selectedIndex]
                                        .roleDisplayIcon,
                                    color: Colors.black54,
                                    height: 12.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    state.agents[state.selectedIndex].role,
                                    style: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14.0,
                                      fontFamily: 'Valorant',
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                              controller: scrollController,
                              itemCount: state.agents.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    pageController.jumpToPage(
                                      index,
                                      // duration:
                                      //     const Duration(milliseconds: 600),
                                      // curve: Curves.easeInBack,
                                    );
                                    // setState(() {
                                    // });
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
                                        image: CachedNetworkImageProvider(
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
                ));
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
