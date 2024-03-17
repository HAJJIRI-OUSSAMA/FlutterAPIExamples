import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/photo.model.dart';

Future<List<Photo>> getPhotos(String motCle, {int page = 1}) async {
  final Uri url = Uri.parse(
      'https://api.unsplash.com/search/photos/?client_id=YJCphrQxX1aLi4hPlOmh_8q31HrdizRpx_th1BeZ4H8&query=' +
          motCle +
          '&page=$page');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    var tab = json.decode(response.body)['results'];
    return [...tab.map((e) => Photo.fromJson(e))];
  } else {
    throw Exception('Erreur');
  }
}
