import 'package:flutter/material.dart';
import 'package:realty_guys/presentation/board_ui_constraints.dart';
import 'package:realty_guys/presentation/card_widgets/property_card_widget.dart';
import 'package:realty_guys/presentation/color_constants.dart';

class BuyPropertyDialog extends StatelessWidget {
  const BuyPropertyDialog({
    Key? key,
    required this.propertyData,
    required this.onSelectYes,
  }) : super(key: key);

  final dynamic propertyData;
  final VoidCallback onSelectYes;

  _dialogOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('Buy')),
        ElevatedButton(
            onPressed: onSelectYes,
            //update purchase provider
            //  then pop context

            child: const Text('Auction')),
        //depending on the game settings
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.map_outlined),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double boardSide = (MediaQuery.of(context).size.width - 20) / 7;
    return Dialog(
      alignment: Alignment.topCenter,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(
        top: boardSide + BoardConstraints.topRowPadding + 10,
        left: (boardSide + 10) + 10,
        right: (boardSide + 10) + 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PropertyCard(propertyData: propertyData),
          const Divider(height: 12),
          _dialogOptions(context),
        ],
      ),
    );
  }
}

showBuyDialog(BuildContext context, dynamic data) {
  return showDialog(
      barrierColor: AppColors.dialogBarrier,
      context: context,
      builder: (_) => BuyPropertyDialog(
            propertyData: data,
            onSelectYes: () {},
          ));
}
