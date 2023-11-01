import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:spacepictures/data/API/api.dart';
import 'package:spacepictures/data/models/mars_photo.dart';
import 'package:spacepictures/utils/hive_managment.dart';

class Repo {
  late API _api;

  Repo() {
    _api = API();
  }

  Future<List<MarsPhoto>> fetchPhotos(DateTime earthDate) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      List<dynamic> jsonList = await _api.fetchPhotos(earthDate.toString());
      final photosList = jsonList.map((e) => MarsPhoto.fromJson(e)).toList();
      HiveManagment.storeMarsPhotos(photosList);
      return photosList;
    } else {
      return HiveManagment.getEarthDatePhotos(earthDate);
    }
  }
}
