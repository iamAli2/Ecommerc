import 'package:get/get.dart';

import '../Data/Repositories/store_repo.dart';
import '../Models/strore_Model.dart';
import '../Utils/utils.dart';

class HomePageController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxBool favouriteBool = false.obs;
  final HomeRepository _api = HomeRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final RxList<Store> userList = <Store>[].obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setError(String value) => error.value = value;

  void setUserList(List<Store> value) => userList.assignAll(value);

  void userListApi() {
    setRxRequestStatus(Status.LOADING);

    _api.userListApi().then(
      (value) {
        setRxRequestStatus(Status.COMPLETED);
        setUserList(value);
      },
    ).onError(
      (error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
      },
    );
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.userListApi().then(
      (value) {
        setRxRequestStatus(Status.COMPLETED);
        setUserList(value);
      },
    ).onError(
      (error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
      },
    );
  }
}
