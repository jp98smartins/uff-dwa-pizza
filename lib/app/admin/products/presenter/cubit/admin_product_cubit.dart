import '../../../../../core/core.dart';
import '../../data/admin_product_repository.dart';
import '../../domain/models/admin_product_model.dart';

part 'admin_product_states.dart';

final class AdminProductCubit extends Cubit<AdminProductState> {
  final AdminProductRepository _adminProductRepository;

  AdminProductCubit(
    this._adminProductRepository,
  ) : super(AdminProductLoading());

  Future<void> createProduct(AdminProductModel product) async {
    emit(AdminProductLoading());

    try {
      await _adminProductRepository.postProduct(product);
      final products = await _adminProductRepository.getProducts();
      emit(AdminProductLoaded(products, true, false));
    } on AppException catch (exception) {
      emit(AdminProductException(exception));
      await Future.delayed(const Duration(seconds: 1), () => createProduct(product));
    }
  }

  Future<void> deleteProduct(int id) async {
    emit(AdminProductLoading());

    try {
      await _adminProductRepository.deleteProduct(id);
      final products = await _adminProductRepository.getProducts();
      emit(AdminProductLoaded(products, false, false));
    } on AppException catch (exception) {
      emit(AdminProductException(exception));
      await Future.delayed(const Duration(seconds: 1), () => deleteProduct(id));
    }
  }

  Future<void> getProducts() async {
    emit(AdminProductLoading());

    try {
      final products = await _adminProductRepository.getProducts();
      emit(AdminProductLoaded(products, false, false));
    } on AppException catch (exception) {
      emit(AdminProductException(exception));
      await Future.delayed(const Duration(seconds: 1), getProducts);
    }
  }

  Future<void> updateProduct(AdminProductModel product) async {
    emit(AdminProductLoading());

    try {
      await _adminProductRepository.patchProduct(product);
      final products = await _adminProductRepository.getProducts();
      emit(AdminProductLoaded(products, true, false));
    } on AppException catch (exception) {
      emit(AdminProductException(exception));
      await Future.delayed(const Duration(seconds: 1), () => updateProduct(product));
    }
  }
}
