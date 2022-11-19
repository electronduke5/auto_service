part of 'autopart_bloc.dart';

class AutopartState {
  final String name;
  final String purchasePrice;
  final String salePrice;
  final String count;
  final CategoryDto? categoryId;
  final FormSubmissionStatus formStatus;

  bool get isValidName => name.isNotEmpty;

  bool get isValidCount => count.isNotEmpty;

  bool get isValidPurchase => purchasePrice.isNotEmpty;

  bool get isValidSale => salePrice.isNotEmpty;

  bool get isNotEmptyCategory => categoryId != null;

  AutopartState({
    this.name = '',
    this.purchasePrice = '',
    this.salePrice = '',
    this.count = '',
    this.categoryId,
    this.formStatus = const InitialFormStatus(),
  });

  AutopartState copyWith({
    String? name,
    String? purchasePrice,
    String? salePrice,
    String? count,
    CategoryDto? categoryId,
    FormSubmissionStatus? formStatus,
  }) =>
      AutopartState(
        name: name ?? this.name,
        purchasePrice: purchasePrice ?? this.purchasePrice,
        salePrice: salePrice ?? this.salePrice,
        categoryId: categoryId ?? this.categoryId,
        count: count ?? this.count,
        formStatus: formStatus ?? this.formStatus,
      );
}
