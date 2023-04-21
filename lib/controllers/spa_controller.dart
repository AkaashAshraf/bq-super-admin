import 'package:bq_admin/config/constants.dart';
import 'package:bq_admin/config/sub_urls.dart';
import 'package:bq_admin/http/http.dart';
import 'package:bq_admin/models/response/saloons_list.dart';
import 'package:bq_admin/models/simple/saloon.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SpaController extends GetxController {
  RxList<Saloon> allList = <Saloon>[].obs;
  RxList<Saloon> activeList = <Saloon>[].obs;
  RxList<Saloon> deactiveList = <Saloon>[].obs;

  RxInt totalAll = 0.obs;
  RxInt totalActive = 0.obs;
  RxInt totalDeactive = 0.obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    fetchSpa(type: "all");
    fetchSpa(type: "active");
    fetchSpa(type: "deactive");

    super.onInit();
  }

  fetchSpa({required String type}) async {
    try {
      loading(true);
      final result = await post(saloonListUrl, {
        'limit': "100",
        'offset': "0",
        "type": "spa",
        "blockStatus": type == "deactive"
            ? "1"
            : type == "active"
                ? "0"
                : "2"
      });
      if (result != null) {
        final data = saloonsFromJson(result?.body);

        assignData(data: data, type: type);
      }
    } finally {
      loading(false);
    }
  }

  blockUnblockSpa({required int status, required int spaID}) async {
    try {
      loading(true);
      final result = await post(blockUnblockSaloonUrl,
          {"status": status.toString(), "saloon_id": spaID.toString()});
      if (result != null) {
        fetchSpa(type: "all");
        fetchSpa(type: "active");
        fetchSpa(type: "deactive");

        return true;
      } else {
        return false;
      }
    } finally {
      loading(false);
    }
  }

  assignData({required Saloons data, required String type}) {
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

  addUpdateSpa({
    required String nameEn,
    required int id,
    required String nameAr,
    required String latitude,
    required String longitude,
    required String descriptionEn,
    required String contact,
    required String descriptionAr,
    required int city,
    required XFile? image,
  }) async {
    try {
      loading(true);

      var request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + (id > 0 ? updateSaloonUrl : addSaloonUrl)));
      request.fields['name_en'] = nameEn;
      request.fields['type'] = "spa";
      request.fields['id'] = id.toString();

      request.fields['name_ar'] = nameAr;
      request.fields['contact'] = contact;
      request.fields['city'] = city.toString();

      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;

      request.fields['description_en'] = descriptionEn;
      request.fields['description_ar'] = descriptionAr;
      if (image != null) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath('image', image.path);
        request.files.add(multipartFile);
      }
      var res = await multirequestPost(request);
      var resData = await res.stream.toBytes();
      var fRes = String.fromCharCodes(resData);
      return fRes;
    } catch (err) {
      print(err.toString());
    } finally {
      loading(false);
    }
  }
}
