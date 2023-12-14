import 'package:agent_x/blocs/agent_bloc/agent_bloc.dart';
import 'package:agent_x/blocs/agent_selection_bloc/agent_selection_bloc.dart';
import 'package:agent_x/data/repositories/agent_repository_impl.dart';
import 'package:agent_x/domain/entities/agent.dart';
import 'package:agent_x/domain/usecases/agent_usecase_interface.dart';
import 'package:agent_x/presentation/screens/agent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final agentRepository = AgentRepositoryImpl();
  final agentUseCase = AgentUseCase(agentRepository: agentRepository);

  runApp(MyApp(agentUseCase: agentUseCase));
}

class MyApp extends StatelessWidget {
  final AgentUseCase agentUseCase;

  const MyApp({Key? key, required this.agentUseCase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valorant Agents',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AgentBloc>(
              create: (context) =>
                  AgentBloc(agentUseCase: agentUseCase)..add(FetchAgents())),
          BlocProvider<AgentSelectionBloc>(
              create: (context) => AgentSelectionBloc(
                  agents: agentUseCase.getAgents() as List<Agent>)),
        ],
        child: const AgentScreen(),
      ),
    );
  }
}
