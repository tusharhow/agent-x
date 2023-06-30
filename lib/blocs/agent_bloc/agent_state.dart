part of 'agent_bloc.dart';

abstract class AgentState extends Equatable {
  const AgentState();

  @override
  List<Object> get props => [];
}

class AgentInitial extends AgentState {}

class AgentLoading extends AgentState {}

class AgentLoaded extends AgentState {
  final List<Agent> agents;

  const AgentLoaded({required this.agents});

  @override
  List<Object> get props => [agents];
}

class AgentError extends AgentState {
  final String message;

  const AgentError({required this.message});

  @override
  List<Object> get props => [message];
}
