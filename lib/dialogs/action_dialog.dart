import 'package:flutter/material.dart';
import 'package:realty_guys/presentation/color_constants.dart';

class ActionDialog extends StatelessWidget {
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String? message;
  final EdgeInsets insetPadding;

  const ActionDialog({
    Key? key,
    this.onConfirm,
    this.onCancel,
    this.message,
    this.insetPadding =
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(0),
        scrollable: true,
        insetPadding: insetPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
        content: Column(
          children: [
            Expanded(
              flex: 2,
              child: Text('message'),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (onConfirm != null) {
                          onConfirm!();
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text('Yes'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onCancel ?? () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

showActionDialog(BuildContext context) {
  return showDialog(
      barrierColor: AppColors.dialogBarrier,
      context: context,
      builder: (context) {
        return const ActionDialog(message: 'Are you sure?');
      });
}
