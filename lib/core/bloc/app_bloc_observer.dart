// ignore_for_file: avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    final blocName = bloc.runtimeType.toString();
    final prev = change.currentState.runtimeType.toString();
    final next = change.nextState.runtimeType.toString();

    // Determine type of next state
    String nextType = '';
    if (next.toLowerCase().contains('loading')) {
      nextType = '⏳ Loading';
    } else if (next.toLowerCase().contains('success')) {
      nextType = '✅ Success';
    } else if (next.toLowerCase().contains('error')) {
      nextType = '❌ Error';
    } else {
      nextType = 'ℹ️ Other';
    }

    // Determine type of previous state
    String prevType = '';
    if (prev.toLowerCase().contains('loading')) {
      prevType = '⏳ Loading';
    } else if (prev.toLowerCase().contains('success')) {
      prevType = '✅ Success';
    } else if (prev.toLowerCase().contains('error')) {
      prevType = '❌ Error';
    } else {
      prevType = 'ℹ️ Other';
    }

    print('-------------------------------------------');
    print('🟢 Bloc/Cubit: $blocName');
    print('   Previous State: $prev ($prevType)');
    print('   Next State    : $next ($nextType)');

    // If next is error and has a field 'apiErrorModel', print its message
    final nextState = change.nextState;
    try {
      if (nextState.apiErrorModel != null) {
        print('   API Error Message: ${nextState.apiErrorModel.message}');
      }
    } catch (_) {
      // Ignore if no apiErrorModel
    }

    print('-------------------------------------------\n');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('❌ Bloc/Cubit: ${bloc.runtimeType} Error: $error');
    super.onError(bloc, error, stackTrace);
  }
}
