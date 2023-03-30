import 'package:bloc/bloc.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/model/level/level.dart';
import 'package:reamp/model/result/result.dart';

/// Events

abstract class LevelEvent {}

class LevelResultAdded extends LevelEvent {
  LevelResult result;

  LevelResultAdded({required this.result});
}

class LevelCompletedEarly extends LevelEvent {}

class LevelRequestedHints extends LevelEvent {}

class LevelContinued extends LevelEvent {}

class SesssionNeededChange extends LevelEvent {
  int numberOfSessions;

  SesssionNeededChange({required this.numberOfSessions});
}

/// States

abstract class LevelState {
  final Level level;

  LevelState({required this.level});
}

class LevelBefore extends LevelState {
  LevelBefore({required Level level}) : super(level: level);
}

class LevelAfter extends LevelState {
  final LevelResult prev;

  LevelAfter({required Level level, required this.prev}) : super(level: level);
}

class LevelDialog extends LevelState {
  final LevelDialogType type;

  LevelDialog({required Level level, required this.type}) : super(level: level);
}

enum LevelDialogType {
  lowTension, highTension,
}

class LevelDone extends LevelState {
  final LevelDoneType type;

  LevelDone({required Level level, LevelDoneType? type})
    : type = type ?? (level.completed ? LevelDoneType.completed : LevelDoneType.none),
      super(level: level);
}

enum LevelDoneType {
  hints, completed, none,
}

/// Bloc

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  final ReampStateBloc stateBloc;

  LevelBloc({required Level level, required this.stateBloc}) : super(LevelBefore(level: level)) {
    on<LevelResultAdded>(_addResult);
    on<LevelCompletedEarly>(_completedEarly);
    on<LevelContinued>((_, emit) => emit(LevelDone(level: state.level)));
    on<LevelRequestedHints>((_, emit) => emit(LevelDone(
      level: state.level,
      type: LevelDoneType.hints,
    )));
   // on<SesssionNeededChange>(_changeSessionNeeded);

  }

  @override
  void onTransition(Transition<LevelEvent, LevelState> transition) {
    super.onTransition(transition);
    if (transition.nextState is LevelDone) {
      stateBloc.add(ReampStateSessionFinished(level: transition.nextState.level));
    }
  }

  void _completedEarly(LevelCompletedEarly event, Emitter<LevelState> emit) {
    final level = state.level.copyWith(
      sessionsNeededForCompletion: state.level.sessionsCompleted,
    );

    emit(LevelBefore(level: level));
  }

  void _addResult(LevelResultAdded event, Emitter<LevelState> emit) {
    final localState = state;
    if (localState is LevelBefore) {
      emit(LevelAfter(
        level: localState.level,
        prev: event.result,
      ));
    } else if (localState is LevelAfter) {
      _sessionFinished(localState.prev, event.result, emit);
    }
  }


  /* void _changeSessionNeeded(SesssionNeededChange event, Emitter<LevelState> emit) {
    final sessionNumbers = event.numberOfSessions;
    //state.level.sessionsNeededForCompletion = event.numberOfSessions;
   
     final level = state.level.copyWith(
      sessionsNeededForCompletion: sessionNumbers,
    );

    emit(LevelBefore(level: level));
  }*/

  void _sessionFinished(LevelResult before, LevelResult after, Emitter<LevelState> emit) async {
    Level level = state.level.copyWith(
      results: [
        ...state.level.results,
        before,
        after,
      ],
    );

    if (after.tension < 2 && level.config.skippable && !level.completed) {
      emit(LevelDialog(
        level: level,
        type: LevelDialogType.lowTension,
      ));
    } else if (after.tension >= 6) {
      if (level.completed) {
        level = level.copyWith(sessionsNeededForCompletion: level.sessionsNeededForCompletion + 1);
      }
      emit(LevelDialog(
        level: level,
        type: LevelDialogType.highTension,
      ));
    } else {
      emit(LevelDone(level: level));
    }
  }
}
