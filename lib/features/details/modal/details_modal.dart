import 'package:qoruz/features/market_place/modal/market_place_modal.dart';

class DetailsMeta {
  bool ok;
  MarketplaceRequest marketplaceRequest;

  DetailsMeta({
    required this.ok,
    required this.marketplaceRequest,
  });

  factory DetailsMeta.fromJson(Map<String, dynamic> json) => DetailsMeta(
        ok: json["ok"],
        marketplaceRequest: MarketplaceRequest.fromJson(
          json["web_marketplace_requests"],
        ),
      );
}
