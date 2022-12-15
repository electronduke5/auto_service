class ClientValidation {
  String? message;

  ClientValidation(this.message);
  String get _requiredMessage => 'Обязательное поле';
  static const String _maxLengthMessage = 'Слишком длинное значение';
  static const String _minLengthMessage = 'Слишком короткое значение';
  static const String _alphabeticMessage = 'Только буквенные символы';

  ClientValidation.isValidSurname(String surname) {
    if(surname.isEmpty){
      message = _requiredMessage;
      return;
    }else if(isMaxLength(surname, 30)){
      message = _maxLengthMessage;
      return;
    }else if(isMinLength(surname, 3)){
      message = _minLengthMessage;
      return;
    }
    else if(!RegExp(r'^[а-яА-Я]{1,}$').hasMatch(surname)){
      message = _alphabeticMessage;
      return;
    }
  }

  ClientValidation.isValidName(String name) {
    if(name.isEmpty){
      message = _requiredMessage;
      return;
    }else if(isMaxLength(name, 30)){
      message = _maxLengthMessage;
      return;
    }else if(isMinLength(name, 2)){
      message = _minLengthMessage;
      return;
    } else if(!RegExp(r'^[а-яА-Я]{1,}$').hasMatch(name)){
      message = _alphabeticMessage;
      return;
    }
  }

  ClientValidation.isValidPhoneNumber(String phoneNumber) {
    RegExp regex = RegExp(r'^\+7{1} \([\d]{3}\) [\d]{3}-[\d]{2}-[\d]{2}$');

    if(phoneNumber.isEmpty){
      message = _requiredMessage;
      return;
    }else if (!regex.hasMatch(phoneNumber)) {
      message = 'Неправильный формат номера';
      return;
    }
  }

  ///Проверяет строку [value] на макимальное значение [maxLength]
  bool isMaxLength(String value, int maxLength) =>
      value.length > maxLength;

  ///Проверяет строку [value] на минимальное значение [minLength]
  bool isMinLength(String value, int minLength) =>
      value.length < minLength;
}
