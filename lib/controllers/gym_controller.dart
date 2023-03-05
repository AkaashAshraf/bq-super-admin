import 'package:bq_admin/config/constants.dart';
import 'package:bq_admin/config/sub_urls.dart';
import 'package:bq_admin/http/http.dart';
import 'package:bq_admin/models/response/shops_response.dart';
import 'package:bq_admin/models/simple/shop.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class GymController extends GetxController {
  RxList<Shop> allList = <Shop>[].obs;
  RxList<Shop> activeList = <Shop>[].obs;
  RxList<Shop> deactiveList = <Shop>[].obs;

  RxInt totalAll = 0.obs;
  RxInt totalActive = 0.obs;
  RxInt totalDeactive = 0.obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    fetchGyms(type: "all");
    fetchGyms(type: "active");
    fetchGyms(type: "deactive");

    super.onInit();
  }

  fetchGyms({required String type}) async {
    try {
      loading(true);
      final result = await post(shopsListUrl, {
        'limit': "100",
        'offset': "0",
        "type": "gym",
        "status": type == "active"
            ? "1"
            : type == "deactive"
                ? "2"
                : "4"
      });
      if (result != null) {
        final data = shopsResponseFromJson(result?.body);

        assignData(data: data, type: type);
      }
    } finally {
      loading(false);
    }
  }

  blockUnblockGym({required int status, required int shopID}) async {
    try {
      loading(true);
      final result = await post(blockUnblockShopUrl,
          {"status": status.toString(), "shop_id": shopID.toString()});
      if (result != null) {
        fetchGyms(type: "all");
        fetchGyms(type: "active");
        fetchGyms(type: "deactive");

        return true;
      } else {
        return false;
      }
    } finally {
      loading(false);
    }
  }

  assignData({required ShopsResponse data, required String type}) {
    switch (type) {
      case "all":
        totalAll(data.total);
        allList(data.data);
        break;
      case "active":
        totalActive(data.total);
        activeList(data.data);
        break;
      case "deactive":
        totalDeactive(data.total);
        deactiveList(data.data);
        break;
      default:
    }
  }

  addGym({
    required String nameEn,
    required String nameAr,
    required String latitude,
    required String longitude,
    required String contact,
    required int city,
    required XFile? image,
  }) async {
    try {
      loading(true);

      var request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + addShopUrl));
      request.fields['name_en'] = nameEn;
      request.fields['type'] = "gym";

      request.fields['name_ar'] = nameAr;
      request.fields['contact'] = contact;
      request.fields['city'] = city.toString();

      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;

      if (image != null) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath('image', image.path);
        request.files.add(multipartFile);
      }
      var res = await multirequestPost(request);
      return res;
    } catch (err) {
      print(err.toString());

      return null;
    } finally {
      loading(false);
    }
  }
}
