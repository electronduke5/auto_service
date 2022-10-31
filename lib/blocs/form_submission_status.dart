abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess<T> extends FormSubmissionStatus {
  final T entity;
  SubmissionSuccess(this.entity);
}

class SubmissionFailed extends FormSubmissionStatus {
  final Object exception;

  SubmissionFailed(this.exception);
}
