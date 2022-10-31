abstract class GetModelsStatus<T> {
  const GetModelsStatus({this.entities, this.error});

  final List<T>? entities;
  final String? error;
}

class InitialModelsStatus extends GetModelsStatus {
  const InitialModelsStatus();
}

class Submitting extends GetModelsStatus {}

class SubmissionSuccess<T> extends GetModelsStatus {
  final List<T> listEntities;

  SubmissionSuccess({required this.listEntities})
      : super(entities: listEntities);
}

class SubmissionFailed extends GetModelsStatus {
  final Object exception;

  SubmissionFailed(this.exception) : super(error: exception.toString());
}
