import 'package:agent_x/domain/usecases/agent_usecase_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/agent.dart';

part 'agent_event.dart';
part 'agent_state.dart';

class AgentBloc extends Bloc<AgentEvent, AgentState> {
  final AgentUseCase agentUseCase;

  AgentBloc({required this.agentUseCase}) : super(AgentInitial()) {
    on<FetchAgents>((event, emit) async {
      emit(AgentLoading());
      try {
        final agents = await agentUseCase.getAgents();
        emit(AgentLoaded(agents: agents));
      } catch (e) {
        emit(AgentError(message: e.toString()));
      }
    });
  }
}
