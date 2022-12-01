part of 'autopart_bloc.dart';

class AutopartState {
  final String name;
  final String purchasePrice;
  final String salePrice;
  final String count;
  final CategoryDto? category;
  final FormSubmissionStatus formStatus;
  final GetModelsStatus modelsStatus;
  final String searchQuery;
  final String message;
  final DeleteStatus deleteStatus;

  bool get isValidName => name.isNotEmpty;

  bool get isValidCount => count.isNotEmpty;

  bool get isValidPurchase => purchasePrice.isNotEmpty;

  bool get isValidSale => salePrice.isNotEmpty;

  bool get isNotEmptyCategory => category != null;

  AutopartState({
    this.name = '',
    this.purchasePrice = '',
    this.salePrice = '',
    this.count = '',
    this.category,
    this.searchQuery = '',
    this.formStatus = const InitialFormStatus(),
    this.modelsStatus = const InitialModelsStatus(),
    this.message = '',
    this.deleteStatus = const InitialDeleteStatus(),
  });

  AutopartState copyWith({
    String? name,
    String? purchasePrice,
    String? salePrice,
    String? count,
    CategoryDto? category,
    FormSubmissionStatus? formStatus,
    GetModelsStatus? modelsStatus,
    String? searchQuery,
    String? message,
    DeleteStatus? deleteStatus,
  }) =>
      AutopartState(
        name: name ?? this.name,
        purchasePrice: purchasePrice ?? this.purchasePrice,
        salePrice: salePrice ?? this.salePrice,
        category: category ?? this.category,
        count: count ?? this.count,
        formStatus: formStatus ?? this.formStatus,
        modelsStatus: modelsStatus ?? this.modelsStatus,
        searchQuery: searchQuery ?? this.searchQuery,
        message: message ?? this.message,
        deleteStatus: deleteStatus ?? this.deleteStatus,
      );
}
