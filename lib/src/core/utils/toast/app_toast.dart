import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kuick_workflow/src/config/theme/app_colors.dart';
import 'package:kuick_workflow/src/core/utils/extensions/string_extensions.dart';

class AppToast {
  static void show(BuildContext con,String message, {ToastType? type,String? message1,EdgeInsetsGeometry? padding}) {
    final context = con;
    final snackBar = SnackBar(
      width: double.infinity * 0.95,
      content: CustomSnackBarContent(message: message,message1: message1, type: type,padding: padding,),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class CustomSnackBarContent extends StatelessWidget {
  final String message;
  final String? message1;
  final ToastType? type;
  final  EdgeInsetsGeometry? padding;

  const CustomSnackBarContent({super.key, required this.message,this.message1, this.type, this.padding});

  @override
  Widget build(BuildContext context) {
    String? assets = '';
    // if (type == ToastType.success) {
    //   assets = ImageConstants.tick;
    // } else if (type == ToastType.info) {
    //   assets = ImageConstants.info;
    // } else if (type == ToastType.error) {
    //   assets = ImageConstants.multiSign;
    // }
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColor.color5(context),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: AppColor.black.withValues(alpha: 0.25),
              blurRadius: 50,
              spreadRadius: 0,
              offset: Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding:padding?? EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(assets),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: message.asH3(context,size: 14),
                ),
              ],
            ),
            if(message1 != null)
              SizedBox(height: 2,),
            if(message1 != null)
              (message1 ?? "").asBody(context,size: 10),
          ],
        ),
      ),
    );
  }
}

enum ToastType { success, error, info }
