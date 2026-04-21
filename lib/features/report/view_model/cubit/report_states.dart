abstract class ReportStates {}

class ReportInitial extends ReportStates {}

class ReportUpdated extends ReportStates {}

class ReportInitialState extends ReportStates {}

class ReportLoadingState extends ReportStates {}

class ReportSuccessState extends ReportStates {}

// ✅ ضيف ده
class ReportErrorState extends ReportStates {
  final String message;

  ReportErrorState(this.message);
}