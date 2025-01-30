import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/config/routes/routes.dart';
import 'package:school_erp/features/auth/auth.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
      ],
      child: BlocProvider<AuthBloc>(
        create: (context) {
          final authRepository = RepositoryProvider.of<AuthRepository>(context);
          final authService = AuthService(authRepository);
          return AuthBloc(authService)..add(AuthCheckRequested());
        },
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
