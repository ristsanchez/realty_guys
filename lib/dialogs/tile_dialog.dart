import 'package:flutter/material.dart';
import 'package:realty_guys/presentation/board_ui_constraints.dart';
import 'package:realty_guys/presentation/color_constants.dart';
import 'package:realty_guys/presentation/property_card_widget.dart';
import 'package:realty_guys/presentation/special_tile.dart';
import 'package:realty_guys/models/tile.dart';

///Property dialog to display property [data]
class TileInfoDialog extends StatelessWidget {
  const TileInfoDialog({Key? key, required this.tileData}) : super(key: key);
  final dynamic tileData;

  @override
  Widget build(BuildContext context) {
    double boardSide = (MediaQuery.of(context).size.width - 20) / 7;

    double vertMargin =
        (((MediaQuery.of(context).size.width - 20) * 5 / 7) - 20) * 7 / 32;
    double extraPadding = tileData is Property ? 0 : vertMargin;
    return Dialog(
      alignment: Alignment.topCenter,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(
        top: boardSide + BoardConstraints.topRowPadding + 10 + extraPadding,
        left: (boardSide + 10) + 10,
        right: (boardSide + 10) + 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          tileData is Property
              ? PropertyCard(propertyData: tileData)
              : TileInfoCard(tileData: tileData)
        ],
      ),
    );
  }
}

showTileDialog(BuildContext context, dynamic data) {
  return showDialog(
      barrierColor: AppColors.dialogBarrier,
      context: context,
      builder: (_) => TileInfoDialog(tileData: data));
}


/*
 
 */