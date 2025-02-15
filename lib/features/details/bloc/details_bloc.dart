import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:qoruz/features/details/modal/details_modal.dart';
import 'package:qoruz/features/details/repo/details_repo.dart';
import 'package:qoruz/features/market_place/modal/market_place_modal.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsLoadingState()) {
    on<GetDetailsEvent>(getDetailsEvent);
    on<NavigateToBackEvent>(navigateToBackEvent);
    on<ButtonTapEvent>(buttonTapEvent);
  }

  FutureOr<void> getDetailsEvent(
    GetDetailsEvent event,
    Emitter<DetailsState> emit,
  ) async {
    emit(DetailsLoadingState());
    DetailsRepo detailsRepo = DetailsRepo();
    Response response = await detailsRepo.getDetails(event.id);
    if (response.statusCode != HttpStatus.ok) {
      emit(DetailsErrorState(errorMessage: "Something went wrong..."));
      return;
    }
    DetailsMeta detailsMeta = DetailsMeta.fromJson(response.data);
    emit(DetailsSuccesState(
      marketplaceRequest: detailsMeta.marketplaceRequest,
    ));
  }

  FutureOr<void> navigateToBackEvent(
    NavigateToBackEvent event,
    Emitter<DetailsState> emit,
  ) {
    emit(NavigateToBackState());
  }

  FutureOr<void> buttonTapEvent(
    ButtonTapEvent event,
    Emitter<DetailsState> emit,
  ) {
    emit(ButtonTapState(message: event.message));
  }
}
