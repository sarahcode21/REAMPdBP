import 'package:bloc/bloc.dart';
import 'package:reamp/core/config/levels.dart';
import 'package:reamp/datasource/state.dart';
import 'package:reamp/model/model.dart';

/// Events

abstract class ReampStateEvent {}

class ReampStateInit extends ReampStateEvent {}

class ReampStateReset extends ReampStateEvent {}

class ReampStatePresentationMode extends ReampStateEvent {}

class ReampStateBaseAnxietySet extends ReampStateEvent {
  final double anxiety;

  ReampStateBaseAnxietySet({required this.anxiety});
}

class ReampStateSessionFinished extends ReampStateEvent {
  final Level level;

  ReampStateSessionFinished({
    required this.level,
  });
}

class ReampStateBaseAssesmentAdded extends ReampStateEvent {
  final String id;
  final double result;

  ReampStateBaseAssesmentAdded({required this.id, required this.result});
}

class ReampStateCheckboxAdded extends ReampStateEvent {
  final String id;
  final bool result;

  ReampStateCheckboxAdded({required this.id, required this.result});
}

class ReampStateCheckboxAdded2 extends ReampStateEvent {
  final String id;
  final bool result;

  ReampStateCheckboxAdded2({required this.id, required this.result});
}

class ReampStateLevelCompletedAdded extends ReampStateEvent {
  final String id;
  final bool result;

  ReampStateLevelCompletedAdded({required this.id, required this.result});
}

class ReampStateOrderdListAdded extends ReampStateEvent {
  final List<String> orderdList;
  

  ReampStateOrderdListAdded({required this.orderdList});
}

class ReampStateOrderdListDelete extends ReampStateEvent {
  String element;
  ReampStateOrderdListDelete({required this.element});
}

class ReampStateDateTime extends ReampStateEvent {
  final DateTime mrtDate;
  ReampStateDateTime({required this.mrtDate});
}

class ReampStateSessionNumber extends ReampStateEvent{
  final int number;
  ReampStateSessionNumber({required this.number});

}

class ReampStateOnboardingFinished extends ReampStateEvent{
}
/// States

abstract class ReampStateState {}

class ReampStateInitializing extends ReampStateState {}

class ReampStateOnboarding extends ReampStateState {}

class ReampStateLoaded extends ReampStateState {
  final StateData data;

  ReampStateLoaded({required this.data});
}

/// Bloc

class ReampStateBloc extends Bloc<ReampStateEvent, ReampStateState> {
  final FileStateDataProvider _dataProvider = FileStateDataProvider(filename: "data.json");

  ReampStateBloc() : super(ReampStateInitializing()) {
    on<ReampStateInit>(_init);
    on<ReampStateReset>(_reset);
    on<ReampStateBaseAnxietySet>(_setBaseAnxiety);
    on<ReampStateSessionFinished>(_sessionFinished);
    on<ReampStatePresentationMode>(_presentationMode);
    on<ReampStateBaseAssesmentAdded>(_assesmentAdded);
    on<ReampStateCheckboxAdded>(_checkboxAdded);
    on<ReampStateCheckboxAdded2>(_checkboxAdded2);
    on<ReampStateLevelCompletedAdded>(_levelCompletedAdded);
    on<ReampStateOrderdListAdded>(_orderdListAdded);
    on<ReampStateOrderdListDelete>(_orderdListDelete);
    on<ReampStateDateTime>(_dateTimeAdd);
    on<ReampStateSessionNumber>(_sessionNumberAdd);
    on<ReampStateOnboardingFinished>(_onboardingFinished);





  }

  @override
  void onTransition(Transition<ReampStateEvent, ReampStateState> transition) async {
    super.onTransition(transition);

    final currentState = transition.currentState;
    final nextState = transition.nextState;
    if (currentState is! ReampStateInitializing && nextState is ReampStateLoaded) {
      await _dataProvider.write(nextState.data);
    }
  }

  Future<void> _init(ReampStateInit event, Emitter<ReampStateState> emit) async {
    final data = await _dataProvider.read();
    if (data != null) {
      emit(ReampStateLoaded(data: data));
    } else {
      emit(ReampStateOnboarding());
    }
  }

  Future<void> _reset(ReampStateReset event, Emitter<ReampStateState> emit) async {
    await _dataProvider.delete();
    emit(ReampStateOnboarding());
  }

  void _presentationMode(ReampStatePresentationMode event, Emitter<ReampStateState> emit) async{
    final ReampStateState currentState = state;
    if(currentState is ReampStateLoaded){
      emit(ReampStateLoaded(data: currentState.data.copyWith(presentationMode: true)));
    }
  }

  void _setBaseAnxiety(ReampStateBaseAnxietySet event, Emitter<ReampStateState> emit) async {
    final ReampStateState currentState = state;
    StateData next = StateData();
    if (currentState is ReampStateLoaded) {
      next = currentState.data;
    }
    emit(ReampStateLoaded(
      data: next.copyWith(
        baseAnxiety: event.anxiety,
      ),
    ));
  }

  void _assesmentAdded(ReampStateBaseAssesmentAdded event, Emitter<ReampStateState> emit) async {
    final ReampStateState currentState = state;
    if (currentState is ReampStateLoaded) {
      final Map<String, double> results = Map.from(currentState.data.assessmentResults);
      results[event.id] = event.result;

      emit(ReampStateLoaded(
        data: currentState.data.copyWith(
          assessmentResults: results,
        ),
      ));
    }
  }

    void _checkboxAdded(ReampStateCheckboxAdded event, Emitter<ReampStateState> emit) async {
    final ReampStateState currentState = state;
    if (currentState is ReampStateLoaded) {
      final Map<String, bool> results = Map.from(currentState.data.checkboxesVorab);
      results[event.id] = event.result;

      emit(ReampStateLoaded(
        data: currentState.data.copyWith(
         checkboxesVorab: results,
        ),
      ));
    }
  }


    void _checkboxAdded2(ReampStateCheckboxAdded2 event, Emitter<ReampStateState> emit) async {
    final ReampStateState currentState = state;
    if (currentState is ReampStateLoaded) {
      final Map<String, bool> results = Map.from(currentState.data.checkboxesMrtTag);
      results[event.id] = event.result;

      emit(ReampStateLoaded(
        data: currentState.data.copyWith(
         checkboxesMrtTag: results,
        ),
      ));
    }
  }

   void _levelCompletedAdded(ReampStateLevelCompletedAdded event, Emitter<ReampStateState> emit) async {
    final ReampStateState currentState = state;
    if (currentState is ReampStateLoaded) {
      final Map<String, bool> results = Map.from(currentState.data.levelscompleted);
      results[event.id] = event.result;

      emit(ReampStateLoaded(
        data: currentState.data.copyWith(
         levelscompleted: results,
        ),
      ));
    }
  }
  

   void _orderdListAdded(ReampStateOrderdListAdded event, Emitter<ReampStateState> emit) async {
    final ReampStateState currentState = state;
    if (currentState is ReampStateLoaded) {
      final List<String> orderdList =  event.orderdList;

      emit(ReampStateLoaded(
        data: currentState.data.copyWith(
         therapieElemente: orderdList,
        ),
      ));
    }
  }

void _orderdListDelete(ReampStateOrderdListDelete event, Emitter<ReampStateState> emit) async {
    final ReampStateState currentState = state;
    if (currentState is ReampStateLoaded) {
      List<String> orderdList =  List.from(currentState.data.therapieElemente);
      orderdList.remove(event.element);

      emit(ReampStateLoaded(
        data: currentState.data.copyWith(
        therapieElemente: orderdList,
        ),
      ));
    }
  }

  void _dateTimeAdd(ReampStateDateTime event, Emitter<ReampStateState> emit) async {
    final ReampStateState currentState = state;
    StateData next = StateData();
    if (currentState is ReampStateLoaded) {
      next = currentState.data;
    }
    emit(ReampStateLoaded(
      data: next.copyWith(
        mrtDate: event.mrtDate,
      ),
    ));
  }

 void _sessionNumberAdd(ReampStateSessionNumber event, Emitter<ReampStateState> emit) async {
  // final data = await _dataProvider.read();
   //final ReampStateState currentState = state;
    //StateData data = StateData();
    final data = (state as ReampStateLoaded).data;

     // && date.onoardingFinished = false
    final updated = <Level> [];
    for(final config in Levels.levels){
        final level = data.getLevelDataForConfig(config);
        final level2 = level.copyWith(sessionsNeededForCompletion : event.number);
        updated.add(level2);
      }
    final updatedall = data.copyWith(levels: updated );
    emit(ReampStateLoaded(data: updatedall));
      
  }

  void _onboardingFinished(ReampStateOnboardingFinished event, Emitter<ReampStateState> emit) async {
    final ReampStateState currentState = state;
    StateData next = StateData();
    if (currentState is ReampStateLoaded) {
      next = currentState.data;
    }
    emit(ReampStateLoaded(
      data: next.copyWith(
        onboardingFinished: true,
      ),
    ));
  }




  void _sessionFinished(ReampStateSessionFinished event, Emitter<ReampStateState> emit) async {
    if (state is! ReampStateLoaded) return;

    final data = (state as ReampStateLoaded).data;
    final nextData = data.copyWith(
      levels: [
        ...data.levels.where((e) => e.config.id != event.level.config.id),
        event.level,
      ],
    );

    emit(ReampStateLoaded(data: nextData));
  }
}
