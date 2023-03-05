import 'dart:developer';

import 'package:bq_admin/config/constants.dart';
import 'package:bq_admin/config/sub_urls.dart';
import 'package:bq_admin/http/http.dart';
import 'package:bq_admin/models/response/general_services.dart';
import 'package:bq_admin/models/simple/general_service.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class GeneralServicesController extends GetxController {
  RxList<GeneralService> genralServicesList = <GeneralService>[].obs;
  RxInt totalGeneralServices = 0.obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    fetchGeneralServices();
    super.onInit();
  }

  fetchGeneralServices() async {
    // loading(true);
    final result = await post(generalServicesListUrl, {
      'limit': "100",
      'offset': "0",
    });
    inspect(result);
    if (result != null) {
      final data = genralServicesFromJson(result?.body);
      genralServicesList(data.data!);
      totalGeneralServices(data.total);
    }
  }

  addSaloon({
    required String nameEn,
    required String nameAr,
    required XFile? image,
  }) async {
    try {
      loading(true);

      var request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + addGeneralService));
      request.fields['name_en'] = nameEn;

      request.fields['name_ar'] = nameAr;
      if (image != null) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath('image', image.path);
        request.files.add(multipartFile);
      }
      var res = await multirequestPost(request);
      return res;
    } catch (err) {
      print(err.toString());
    } finally {
      loading(false);
    }
  }
}
