import 'package:agent_x/domain/repositories/agent_repository_interface.dart';
import '../../domain/entities/agent.dart';

class AgentUseCase {
  final AgentRepository agentRepository;

  AgentUseCase({required this.agentRepository});

  Future<List<Agent>> getAgents() {
    return agentRepository.getAgents();
  }
}
