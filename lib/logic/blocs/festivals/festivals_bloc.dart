import 'package:bloc/bloc.dart';
import 'package:festivals_exam_4/data/repositories/festivals_repositories.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_events.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_states.dart';
import 'package:stream_transform/stream_transform.dart';


class FestivalsBloc extends Bloc<FestivalsEvents, FestivalsState> {
  final FestivalsRepositories _festivalsRepositories;

  FestivalsBloc({required FestivalsRepositories festivalsRepositories})
      : _festivalsRepositories = festivalsRepositories,
        super(InitialFestivalsState()) {
    on<GetFestivalsEvent>(_getFestivals);
    on<GetFestivalWithinWeek>(_getFestivalsWithinWeek);
    on<IncrementFestivalAttendantsEvent> (_incrementFestivalAttendants);
    // on<AddFestivalEvent>(
    //   _addFestival,
    //   // funkisyani ichga tushiradi va keyingi 5 soniya kutadi
    //   //  transformer: (events, mapper) =>
    //   //     events.throttle(const Duration(seconds: 5)).switchMap(mapper),

    //   // 5 soniyani kutadi va keyin funksiyani chaqiradi
    //   // transformer: (events, mapper) => events
    //   //     .debounce(const Duration(seconds: 5), leading: false, trailing: true)
    //   //     .switchMap(mapper),
    // );
    // on<EditFestivalEvent>(_editProduct);
    // on<DeleteFestivalEvent>(_deleteProduct);
  }


  void _incrementFestivalAttendants(event, emit){
    emit(LoadingFestivalsState());
  }

  void _getFestivals(
    GetFestivalsEvent event,
    Emitter<FestivalsState> emit,
  ) async {
    emit(LoadingFestivalsState());

    try {
      // await emit.forEach(stream, onData: (data) {
      //   return LoadedProductsState(data);
      // });
      final festivals = await _festivalsRepositories.getFestivals();
      emit(LoadedFestivalsState(festivals));
    } catch (e) {
      emit(ErrorProductsState(e.toString()));
    }
  }

  void _getFestivalsWithinWeek(
    GetFestivalWithinWeek event,
    Emitter<FestivalsState> emit,
  ) async {
    emit(LoadingFestivalsState());

    try {
      // await emit.forEach(stream, onData: (data) {
      //   return LoadedProductsState(data);
      // });
      final comingFestivals = await _festivalsRepositories.getFestivalsWithinWeek();
      emit(LoadedFestivalsState(comingFestivals));
    } catch (e) {
      emit(ErrorProductsState(e.toString()));
    }
  }

  // void _addProduct(
  //   AddProductEvent event,
  //   Emitter<ProductsState> emit,
  // ) async {
  //   List<Product> existingProducts = [];
  //   if (state is LoadedProductsState) {
  //     existingProducts = (state as LoadedProductsState).products;
  //   }
  //   emit(LoadingProductsState());

  //   try {
  //     final product = await _productRepository.addProduct(event.title);
  //     existingProducts.add(product);
  //     emit(LoadedProductsState(existingProducts));
  //   } catch (e) {
  //     emit(ErrorProductsState(e.toString()));
  //   }
  // }

  // void _editProduct(
  //   EditProductEvent event,
  //   Emitter<ProductsState> emit,
  // ) async {
  //   List<Product> existingProducts = [];
  //   if (state is LoadedProductsState) {
  //     existingProducts = (state as LoadedProductsState).products;
  //   }
  //   emit(LoadingProductsState());

  //   try {
  //     await _productRepository.editProduct(event.id, event.newTitle);
  //     for (var product in existingProducts) {
  //       if (product.id == event.id) {
  //         product.title = event.newTitle;
  //       }
  //     }
  //     emit(LoadedProductsState(existingProducts));
  //   } catch (e) {
  //     emit(ErrorProductsState(e.toString()));
  //   }
  // }

  // void _deleteProduct(
  //   DeleteProductEvent event,
  //   Emitter<ProductsState> emit,
  // ) async {
  //   List<Product> existingProducts = [];
  //   if (state is LoadedProductsState) {
  //     existingProducts = (state as LoadedProductsState).products;
  //   }
  //   emit(LoadingProductsState());

  //   try {
  //     await _productRepository.deleteProduct(event.id);
  //     existingProducts.removeWhere((product) {
  //       return product.id == event.id;
  //     });
  //     emit(LoadedProductsState(existingProducts));
  //   } catch (e) {
  //     emit(ErrorProductsState(e.toString()));
  //   }
  // }
}