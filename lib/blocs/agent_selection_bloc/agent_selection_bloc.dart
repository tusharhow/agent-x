import 'package:agent_x/domain/entities/agent.dart';
import 'package:bloc/bloc.dart';

part 'agent_selection_event.dart';
part 'agent_selection_state.dart';

class AgentSelectionBloc
    extends Bloc<AgentSelectionEvent, AgentSelectionState> {
  AgentSelectionBloc({
    required List<Agent> agents,
  }) : super(AgentSelectionState(agents, 0)) {
    on<AgentSelectionEvent>((event, emit) {
      emit(AgentSelectionState(state.agents, event.selectedIndex));
    });
  }
}
