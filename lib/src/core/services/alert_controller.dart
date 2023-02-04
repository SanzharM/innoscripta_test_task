import 'package:fluttertoast/fluttertoast.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';

class AlertController {
  static void showMessage(String message, {bool isSuccess = false}) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: AppStyles.titleSmall.fontSize,
      gravity: ToastGravity.TOP,
      backgroundColor: isSuccess ? AppColors.greenLight : AppColors.greyDark,
      textColor: isSuccess ? AppColors.greyDark : AppColors.white,
    );
    return;
  }
}
