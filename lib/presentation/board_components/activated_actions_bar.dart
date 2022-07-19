import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/presentation/color_constants.dart';
import 'package:realty_guys/providers/purchase_ui_provider.dart';

class PropertyAction extends StatelessWidget {
  const PropertyAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Purchase(),
      child: Consumer<Purchase>(
        builder: (context, value, child) {
          return Visibility(
              visible: value.ifCanBuy,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      value.toggleVisibility();
                      //toggle it
                      //if toggled to true pop dialog
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: value.purchaseVisibility
                            ? AppColors.activated
                            : AppColors.deactivated,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Icon(
                          value.purchaseVisibility
                              ? Icons.layers_rounded
                              : Icons.layers_clear_rounded,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
