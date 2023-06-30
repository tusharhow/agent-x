import '../../domain/entities/agent.dart';

abstract class AgentRepository {
  Future<List<Agent>> getAgents();
}
