import 'package:agent_x/constants/api_constants.dart';
import 'package:agent_x/domain/repositories/agent_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/entities/agent.dart';

class AgentRepositoryImpl implements AgentRepository {
  @override
  Future<List<Agent>> getAgents() async {
    try {
      final response = await http.get(Uri.parse(apiConstants.apiUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final agentList = jsonData['data'] as List<dynamic>;
        final agents = agentList.map((agentData) {
          try {
            return Agent.fromJson(agentData);
          } catch (e) {
            print('Error mapping agent: $e');
            return null;
          }
        }).toList();

        agents.removeWhere((agent) => agent == null);

        return agents.cast<Agent>();
      } else {
        throw Exception(
            'Failed to fetch agents. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch agents: $e');
    }
  }
}
