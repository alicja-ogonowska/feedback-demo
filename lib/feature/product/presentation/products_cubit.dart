import 'package:equatable/equatable.dart';
import 'package:feedback_demo/feature/product/data/model/product.dart';
import 'package:feedback_demo/feature/product/data/products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required this.repository}) : super(ProductsInitial());
  final ProductsRepository repository;

  void loadProducts() async {
    emit(ProductsLoading());
    try {
      final products = await repository.fetchAllProducts();
      emit(ProductsLoaded(products));
    } catch (e, st) {
      emit(const ProductsError("Something went wrong"));
    }
  }
}

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  const ProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object> get props => [message];
}
