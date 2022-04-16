import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../data.dart';
import 'package:get/get.dart';

class NetworkHelper extends GetxController {
  List success = [].obs;
  List failed = [].obs;
  var paddingValue = 200.0.obs;
  Set<String> saved = {};

  bool isVisible = false;
  linkchecker() {
    for (var i = 0; i < ftpSites.length; i++) {
      var url = ftpSites[i];

      getData(url);
      // progIndicator();
    }
  }

  Future<void> getData(url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        success.add(url);
      }
    } catch (e) {
      failed.add(url);
    }
  }

  // double progIndicator() {
  //   myValue.value = (((i) / ftpSites.length) * 100).toDouble();

  //   return myValue.value;
  // }

  Future<List> successList() async {
    return success;
  }

  Future<List> failedList() async {
    return failed;
  }

  /// Will get the startupnumber from shared_preferences
  /// will return 0 if null
  Future<Set<String>> getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? startupList = prefs.getStringList('startupList');
    if (startupList == null) {
      return {};
    }
    return startupList.toSet();
  }

  /// Reset the counter in shared_preferences to 0
  Future<void> saveList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedList = saved.toList();
    await prefs.setStringList('startupList', savedList);
  }

  /// Will Increment the startup number and store it then
  /// use setState to display in the UI
  Future<Set<String>> useTheList() async {
    final prefs = await SharedPreferences.getInstance();
    saved = await getIntFromSharedPref();
    return saved;
  }
}
