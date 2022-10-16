mixin ValidationMixin{
  bool isFieldEmpty(String fieldValue) => fieldValue?.isEmpty ?? true;

  bool isFieldMaxLength(String fieldValue, int max) => fieldValue.length <= max;

  bool isFieldMinLength(String fieldValue, int min) => fieldValue.length >= min;

  
}