import 'package:aruna_test/bloc/home/home_bloc.dart';
import 'package:aruna_test/bloc/home/home_state.dart';
import 'package:aruna_test/infrastructure/repository/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<HomeBloc>(
        create: (BuildContext context) => HomeBloc(
          initialState: HomeInitial(),
          appRepository: AppRepository(),
        ),
        child: HomeView(),
      ),
    );
  }
}
