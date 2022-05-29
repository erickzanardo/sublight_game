import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sublight_game/ui/ui.dart';

Future<T?> showOverlayPanel<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) async {
  if (context.isVerticalScreen()) {
    return showCupertinoModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => SizedBox(
        height: context.bottomSheetHeight(),
        child: builder(context),
      ),
    );
  } else {
    return showGeneralDialog<T>(
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(1, 0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          alignment: Alignment.topRight,
          child: SizedBox(
            width: context.dialogWidth(),
            child: builder(context),
          ),
        );
      },
    );
  }
}
