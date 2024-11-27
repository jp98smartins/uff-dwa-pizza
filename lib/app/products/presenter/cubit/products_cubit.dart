import '../../../../core/core.dart';

part 'products_states.dart';

final class ProductsCubit extends Cubit<ProductsState> {
  final CoreRepository _coreRepository;

  ProductsCubit(
    this._coreRepository,
  ) : super(ProductsLoading());

  Future<void> getProducts() async {
    emit(ProductsLoading());

    try {
      final entity = await _coreRepository.readAuthLocally();
      if (entity == null) {
        throw const AppException.business(
          AppExceptionTags.invalidCredentials,
          segment: 'Products',
          step: 'Get Products',
        );
      }

      emit(ProductsLoaded(entity));
    } on AppException catch (exception) {
      emit(ProductsException(exception));
    }
  }

  Future<void> logout() async {
    emit(ProductsLoading());

    try {
      await _coreRepository.clearAuth();
      emit(ProductsLogout());
    } on AppException catch (exception) {
      emit(ProductsException(exception));
    }
  }
}
