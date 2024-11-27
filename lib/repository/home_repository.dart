import 'package:flutter_mvvm/data/network/network_api_services.dart';
import 'package:flutter_mvvm/model/model.dart';
import 'package:flutter_mvvm/model/ongkir/ongkir.dart';

class HomeRepository {
  final _apiServices = NetworkApiServices();

  Future<List<Province>> fetchProvinceList() async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/province');
      List<Province> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => Province.fromJson(e))
            .toList();
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<City>> fetchCityList(var provId) async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/city');
      List<City> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => City.fromJson(e))
            .toList();
      }

      List<City> selectedCities = [];
      for (var c in result) {
        if (c.provinceId == provId) {
          selectedCities.add(c);
        }
      }

      return selectedCities;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Ongkir>> fetchOngkirList(
      String origin, String destination, int weight, String courier) async {
    try {
      // Mengirim permintaan POST ke endpoint API
      dynamic response = await _apiServices.postApiResponse(
        '/starter/cost',
        body: {
          "origin": origin,
          "destination": destination,
          "weight": weight,
          "courier": courier,
        },
      );
      print("Response API: $response");
      List<Ongkir> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        // Parsing hasil dari respons API
        List<dynamic> costs = response['rajaongkir']['results'];
        result = costs.map((e) => Ongkir.fromJson(e)).toList();
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
