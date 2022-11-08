abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class FormSubmissionSuccess<T> extends FormSubmissionStatus {
  final T entity;

  FormSubmissionSuccess(this.entity);
}

class FormSubmissionFailed extends FormSubmissionStatus {
  final Object exception;

  FormSubmissionFailed(this.exception);
}
