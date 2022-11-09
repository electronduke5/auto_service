abstract class DeleteStatus {
  final String? message;

  const DeleteStatus({this.message});
}

class InitialDeleteStatus extends DeleteStatus {
  const InitialDeleteStatus();
}

class SubmittingDelete extends DeleteStatus {}

class SubmissionDeleteSuccess extends DeleteStatus {
  final String successMessage;

  SubmissionDeleteSuccess({required this.successMessage})
      : super(message: successMessage);
}

class SubmissionDeleteFailed extends DeleteStatus {
  final String errorMessage;

  SubmissionDeleteFailed({required this.errorMessage})
      : super(message: errorMessage);
}
