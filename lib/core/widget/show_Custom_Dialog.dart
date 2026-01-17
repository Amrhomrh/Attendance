import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/AppColor_constants.dart';


Future<void> showCustomDialog({
  required String title,
  required String message,
  required BuildContext context,
  String confirmText = "ok",
  String? cancelText, // جعله nullable ليكون اختياريًا
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  String? lottieAsset,
  Widget? customWidget, // إضافة widget مخصص للتحكم الكامل
  Color backgroundColor = Colors.white,
  Color titleColor = Colors.black,
  Color messageColor = Colors.black87,
  Color confirmButtonColor = AppColors.primaryColor,
  Color? cancelButtonColor, // لون مخصص للزر الإلغاء
  IconData? icon,
  double iconSize = 60,
  double lottieHeight = 120,
  bool barrierDismissible = false,
  bool showCloseButton = false, // إضافة زر X للإغلاق
}) {
  return showDialog(
    context: context,
    builder: (context) =>
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // زر الإغلاق (اختياري)
            if (showCloseButton)
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context)
                  ,
                ),
              ),

            // المحتوى المرئي
            if (lottieAsset != null)
              Lottie.asset(lottieAsset, height: lottieHeight)
            else if (icon != null)
              Icon(icon, size: iconSize, color: confirmButtonColor),

            // المسافة الديناميكية
            SizedBox(height: (lottieAsset != null || icon != null) ? 20 : 0),

            // العنوان
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // الرسالة
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: messageColor,
              ),
              textAlign: TextAlign.center,
            ),

            // Widget مخصص إضافي
            if (customWidget != null) ...[
              const SizedBox(height: 16),
              customWidget,
            ],

            const SizedBox(height: 24),

            // الأزرار
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (cancelText != null && cancelText.isNotEmpty)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cancelButtonColor ?? Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onCancel?.call();
                      },
                      child: Text(
                        cancelText,
                        style: TextStyle(
                          color: cancelButtonColor != null
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),

                // المسافة بين الأزرار
                if (cancelText != null && cancelText.isNotEmpty)
                  const SizedBox(width: 10),

                // زر التأكيد
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: confirmButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm?.call();
                    },
                    child: Text(
                      confirmText,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    barrierDismissible: barrierDismissible,
  );
}