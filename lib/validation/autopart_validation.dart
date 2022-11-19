import 'package:auto_service/blocs/autoparts/add_edit_autopart_bloc/autopart_bloc.dart';

class AutopartValidation {
  String? nameMessage;
  String? purchaseMessage;
  String? saleMessage;
  String? countMessage;
  String? categoryMessage;

  String? isValidName({required AutopartState state}) {
    return state.isValidName ? null : 'Это обязательное поле';
  }

  AutopartValidation.validated({required AutopartState state}) {
    nameMessage =
        state.name.length <= 255 ? null : 'Максимальная длина - 255 символов';
    nameMessage = state.isValidName ? null : 'Это обязательное поле';

    if (!state.isValidCount) {
      countMessage = 'Это обязательное поле';
    } else if (int.tryParse(state.count) == null) {
      countMessage = 'Значение должно быть целочисленным';
    } else if (int.parse(state.count) <= 0) {
      countMessage = 'Число должно быть больше 0';
    }

    final purchasePrice = double.tryParse(state.purchasePrice);
    final salePrice = double.tryParse(state.salePrice);

    if (!state.isValidPurchase) {
      purchaseMessage = 'Это обязательное поле';
    } else if (purchasePrice == null) {
      purchaseMessage = 'Только число';
    } else if (double.parse(state.purchasePrice) <= 0.0) {
      purchaseMessage = 'Число должно быть больше 0';
    }

    if (!state.isValidSale) {
      saleMessage = 'Это обязательное поле';
    } else if (salePrice == null) {
      saleMessage = 'Только число';
    } else if (double.parse(state.salePrice) <= 0.0) {
      saleMessage = 'Число должно быть больше 0';
    }
    saleMessage = (purchasePrice != null && salePrice != null) &&
            salePrice < purchasePrice
        ? 'Должна быть больше закупочной'
        : saleMessage;

    categoryMessage = state.isNotEmptyCategory ? null : 'Это обязательное поле';
  }
}
