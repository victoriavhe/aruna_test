import 'package:aruna_test/model/content_responses.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final List<ContentResponses> listOfContents;

  HomeLoaded({this.listOfContents}) : assert(listOfContents != null);

  @override
  List<Object> get props => [];
}

class HomeError extends HomeState {
  final String message;

  HomeError({this.message});

  @override
  List<Object> get props => [this.message];
}
