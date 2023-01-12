import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../data.dart';
import 'package:get/get.dart';

class NetworkHelper extends GetxController {
  List success = [].obs;
  List failed = [].obs;
  var paddingValue = 200.0.obs;
  Set<String> saved = {
    'http://circleftp.net',
    'http://bongobd.com',
    'http://showtimebd.com',
    'http://patalpuri.com',
    'http://172.16.50.4',
    'http://ftpbd.net',
    'http://fs.ebox.live',
    'http://172.16.16.5'
  };

  bool isVisible = false;

  linkchecker() {
    for (var i = 0; i < ftpSites.length; i++) {
      var url = ftpSites[i];

      getData(url);
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

  Future<void> saveList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedList = saved.toList();
    await prefs.setStringList('startupList', savedList);
  }

  Future<Set<String>> useTheList() async {
    // final prefs = await SharedPreferences.getInstance();

    saved = await getIntFromSharedPref();
    return saved;
  }

  Future<bool> isFirstTime() async {
    final pref = await SharedPreferences.getInstance();
    var isFirstTime = pref.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      pref.setBool('first_time', false);
      return false;
    } else {
      pref.setBool('first_time', false);
      return true;
    }
  }
}
