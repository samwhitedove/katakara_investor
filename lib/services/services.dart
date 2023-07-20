import 'package:katakara_investor/helper/helper.settings.dart';
import 'package:katakara_investor/models/register/register.dart';
import 'package:katakara_investor/models/services/model.service.response.dart';
import 'package:katakara_investor/services/service.endpoints.dart';
import 'package:katakara_investor/services/service.http.dart';
import 'package:katakara_investor/values/values.dart';

class Services {
  static fetchUser() async {
    RequestResponsModel response = await MyRequestClass.krequest(
        endPoint: EndPoint.fetchUser, method: Methods.get);
    userData = UserDataModel.fromJson(response.data);
    AppSettings.saveUserToLocal(userData.toJson());
  }
}
