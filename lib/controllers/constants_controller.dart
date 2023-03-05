import 'package:bq_admin/config/sub_urls.dart';
import 'package:bq_admin/http/http.dart';
import 'package:bq_admin/models/response/constants.dart';
import 'package:bq_admin/models/simple/city.dart';
import 'package:get/state_manager.dart';

class ConstantsController extends GetxController {
  RxList<City> cities = <City>[].obs;

  @override
  void onInit() {
    getConstants();
    super.onInit();
  } //onInit

  getConstants() async {
    try {
      var raw = await post(constantsUrl, {});
      if (raw.statusCode == 200) {
        var response = constantsFromJson(raw.body);
        cities(response.cities);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
