part of 'agent_selection_bloc.dart';

class AgentSelectionState {
  final List<Agent> agents;
  int selectedIndex = 0;

  AgentSelectionState(this.agents, this.selectedIndex);
}
