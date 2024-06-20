import 'package:flutter/material.dart';
import 'package:flutter1/widgets/appcolors.dart';

Failedsnackbar({required BuildContext context, required String msg}) {
  double screenWidth = MediaQuery.of(context).size.width;

  final snackBar = SnackBar(
    content: Text(
      msg,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: AppColors.text),
      textScaleFactor: 1,
    ),
    backgroundColor: AppColors.red,
    padding: EdgeInsets.all(15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    behavior: SnackBarBehavior.floating,
    //elevation: 80,
    //width: screenWidth/1.2,
    duration: Duration(seconds: 2),
    margin: EdgeInsets.symmetric(horizontal: 8),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

successSnackBar({required BuildContext context, required String msg}) {
  final snackBar = SnackBar(
    content: Text(msg,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColors.text),
        textScaleFactor: 1),
    backgroundColor: AppColors.green,
    padding: EdgeInsets.all(15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    behavior: SnackBarBehavior.fixed,
    elevation: 80,
    duration: Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

ExitSnackBar({required BuildContext context, required String msg}) {
  double screenWidth = MediaQuery.of(context).size.width;

  final snackBar = SnackBar(
    content: Text(msg,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColors.text),
        textScaleFactor: 1),
    backgroundColor: AppColors.grey,
    padding: EdgeInsets.all(15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    behavior: SnackBarBehavior.floating,
    //elevation: 80,
    //width: screenWidth/1.2,
    duration: Duration(seconds: 2),
    margin: EdgeInsets.symmetric(horizontal: 8),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

loadingSnackBar({required BuildContext context, required String msg}) {
  final snackBar = SnackBar(
    content: Text(msg,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColors.black),
        textScaleFactor: 1),
    backgroundColor: AppColors.grey,
    padding: EdgeInsets.all(15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    behavior: SnackBarBehavior.fixed,
    //elevation: 80,
    duration: Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

snackBarForLoading(
    {required BuildContext context,
    required String msg,
    required int seconds}) {
  final snackBar = SnackBar(
    content: Text(msg,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColors.black),
        textScaleFactor: 1),
    backgroundColor: AppColors.grey,
    padding: EdgeInsets.all(15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    behavior: SnackBarBehavior.fixed,
    //elevation: 80,
    duration: Duration(seconds: seconds),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
