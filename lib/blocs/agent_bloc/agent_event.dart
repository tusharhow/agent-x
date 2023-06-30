part of 'agent_bloc.dart';

abstract class AgentEvent extends Equatable {
  const AgentEvent();

  @override
  List<Object> get props => [];
}

class FetchAgents extends AgentEvent {}
