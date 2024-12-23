import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/api_response.dart';
import 'package:flutter_mvvm/model/model.dart';
import 'package:flutter_mvvm/model/ongkir/ongkir.dart';
import 'package:flutter_mvvm/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _homePage = HomeRepository();
  ApiResponse<List<Province>> provinceList = ApiResponse.loading();

  setProvinceList(ApiResponse<List<Province>> response) {
    provinceList = response;
    notifyListeners();
  }

  Future<void> getProvinceList() async {
    setProvinceList(ApiResponse.loading());
    _homePage.fetchProvinceList().then((value) {
      setProvinceList(ApiResponse.completed(value));
    }).onError((error, StackTrace) {
      setProvinceList(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<List<City>> cityList = ApiResponse.loading();

  setCityList(ApiResponse<List<City>> response) {
    cityList = response;
    notifyListeners();
  }

  Future<void> getCityList(var provId) async {
    setCityList(ApiResponse.loading());
    _homePage.fetchCityList(provId).then((value) {
      setCityList(ApiResponse.completed(value));
    }).onError((error, StackTrace) {
      setCityList(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<List<City>> cityListOrigin = ApiResponse.loading();
  ApiResponse<List<City>> cityListDest = ApiResponse.loading();
  setCityListOrigin(ApiResponse<List<City>> response) {
    cityListOrigin = response;
    notifyListeners();
  }

  setCityListDest(ApiResponse<List<City>> response) {
    cityListDest = response;
    notifyListeners();
  }

  Future<void> getCityListForOrigin(var provId) async {
    setCityListOrigin(ApiResponse.loading());
    _homePage.fetchCityList(provId).then((value) {
      setCityListOrigin(ApiResponse.completed(value));
    }).onError((error, StackTrace) {
      setCityListOrigin(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getCityListForDest(var provId) async {
    setCityListDest(ApiResponse.loading());
    _homePage.fetchCityList(provId).then((value) {
      setCityListDest(ApiResponse.completed(value));
    }).onError((error, StackTrace) {
      setCityListDest(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<List<Ongkir>> ongkirList = ApiResponse.loading();
  setOngkirList(ApiResponse<List<Ongkir>> response) {
    ongkirList = response;
    print("Ongkir List Updated: ${response.data}");
    notifyListeners();
  }

  Future<void> getOngkirList(
      String origin, String destination, int weight, String courier) async {
    setOngkirList(ApiResponse.loading());
    _homePage
        .fetchOngkirList(origin, destination, weight, courier)
        .then((value) {
      // Parsing hanya `costs` dari response API
      setOngkirList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOngkirList(ApiResponse.error(error.toString()));
    });
  }
}
