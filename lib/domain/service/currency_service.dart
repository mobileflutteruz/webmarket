
import 'package:dio/dio.dart';
import 'package:web_shop/domain/model/currency_model.dart';

class CurrencyService {
  static Future<List<CurrencyModel>> getCurrency() async {
    Response res = await Dio().get("https://nbu.uz/uz/exchange-rates/json/");

    return (res.data as List).map((e) => CurrencyModel.fromJson(e)).toList();
  }
}