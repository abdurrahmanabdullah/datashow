import 'package:get/get.dart';
import 'package:job_preparation/models/user_model.dart';
import 'package:job_preparation/services/api_service.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var userData = UserDataModel().obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      // isLoading(true);
      var fetchedData = await _apiService.fetchUserData();
      // userData.value = fetchedData;
      userData(fetchedData);
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      isLoading(false);
    }
  }
}