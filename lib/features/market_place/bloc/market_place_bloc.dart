import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:qoruz/features/market_place/modal/market_place_modal.dart';
import 'package:qoruz/features/market_place/repo/market_place_repo.dart';

part 'market_place_event.dart';
part 'market_place_state.dart';

class MarketPlaceBloc extends Bloc<MarketPlaceEvent, MarketPlaceState> {
  MarketPlaceBloc() : super(MarketPlaceLoadingState()) {
    on<GetPostsEvent>(getPostsEvent);
    on<ChangeChoiceEvent>(changeChoiceEvent);
    on<NavigateToDetailEvent>(navigateToDetailEvent);
    on<GetPaginationEvent>(getPaginationEvent);
    on<ButtonTapEvent>(buttonTapEvent);
  }

  FutureOr<void> getPostsEvent(
    GetPostsEvent event,
    Emitter<MarketPlaceState> emit,
  ) async {
    emit(MarketPlaceLoadingState());
    MarketPlaceRepo marketPlaceRepo = MarketPlaceRepo();
    Response response = await marketPlaceRepo.getMarketList(1);
    if (response.statusCode != HttpStatus.ok) {
      emit(MarketPlaceErrorState(errorMessage: "Something went wrong.."));
      return;
    }
    MarketMeta marketMeta = MarketMeta.fromJson(response.data);
    emit(MarketPlaceSucessState(marketMeta: marketMeta));
  }

  FutureOr<void> changeChoiceEvent(
    ChangeChoiceEvent event,
    Emitter<MarketPlaceState> emit,
  ) {
    emit(ChoiceChangedState(changedChoiceIndex: event.choiceIndex));
    emit(ButtonTapState(message: "Prefrence changed to ${event.choice}"));
  }

  FutureOr<void> navigateToDetailEvent(
    NavigateToDetailEvent event,
    Emitter<MarketPlaceState> emit,
  ) {
    emit(NavigateToDetailsState(id: event.id));
  }

  FutureOr<void> getPaginationEvent(
    GetPaginationEvent event,
    Emitter<MarketPlaceState> emit,
  ) async {
    MarketPlaceRepo marketPlaceRepo = MarketPlaceRepo();
    Response response = await marketPlaceRepo.getMarketList(event.page);
    if (response.statusCode != HttpStatus.ok) {
      emit(MarketPlaceErrorState(errorMessage: "Something went wrong.."));
      return;
    }
    MarketMeta marketMeta = MarketMeta.fromJson(response.data);
    emit(PaginatedState(
      marketPlaceRequestList: marketMeta.marketplaceRequests,
      pagination: marketMeta.pagination,
    ));
  }

  FutureOr<void> buttonTapEvent(
    ButtonTapEvent event,
    Emitter<MarketPlaceState> emit,
  ) {
    emit(ButtonTapState(message: event.message));
  }
}
