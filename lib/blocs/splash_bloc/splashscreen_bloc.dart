import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splashscreen_event.dart';
part 'splashscreen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<SplashScreenEvent>((event, emit) async {
      if (event is NavigateToHomeScreenEvent) {
        emit(SplashScreenLoading());

        // During the Loading state we can do additional checks like,
        // if the internet connection is available or not etc..

        await Future.delayed(
          const Duration(
            seconds: 2,
          ),
        ); // This is to simulate that above checking process
        emit(SplashScreenLoaded()); // In this state we can load the HOME PAGE
      }
    });
  }
}
