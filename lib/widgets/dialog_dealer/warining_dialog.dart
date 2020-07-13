import 'package:flutter/material.dart';
import '../action_dialog.dart';

class WarningDialog {
  static Future<bool> twoActionsDialog({
    BuildContext context,
    String titleText,
    String bodyText,
    String goodOption,
    String badOption,
  }) async {
    return showGeneralDialog(
      barrierColor: Colors.black38,
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animate1, animate2) {
        return;
      },
      transitionBuilder: (context, animation1, animation2, widget) {
        final curvedValue =
            Curves.easeInOutBack.transform(animation1.value) - 1.0;

        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
              opacity: animation1.value,
              child: ActionDialog(
                titleText: titleText,
                bodyText: bodyText,
                goodOption: goodOption,
                badOption: badOption,
              )),
        );
      },
    );
  }
}
