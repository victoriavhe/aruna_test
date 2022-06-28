import 'package:aruna_test/infrastructure/repository/app_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeInitial initialState;
  final AppRepository appRepository;

  HomeBloc({@required this.initialState, this.appRepository})
      : super(initialState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchContents) {
      try {
        yield HomeLoading();

        final response = await this.appRepository.fetchContents();

        if (response != null) {
          yield HomeLoaded(listOfContents: response);
        } else {
          yield HomeError(message: "List are empty");
        }
      } on Error {
        yield HomeError(message: "There is an error running the app.");
      }
    }
  }
}
