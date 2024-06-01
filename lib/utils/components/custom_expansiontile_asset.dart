import 'package:flutter/material.dart';
import 'package:tractian/app/models/asset_model.dart';
import 'package:tractian/utils/colors/colors.dart';

// ignore: must_be_immutable
class CustomAssetExpansionTileAsset extends StatefulWidget {
  AssetModel asset;
  double leftPadding;
  Widget Function(AssetModel asset, {double leftPadding}) buildTile;

  CustomAssetExpansionTileAsset({
    super.key,
    required this.asset,
    required this.leftPadding,
    required this.buildTile,
  });

  @override
  State<CustomAssetExpansionTileAsset> createState() => _CustomAssetExpansionTileAssetState();
}

class _CustomAssetExpansionTileAssetState extends State<CustomAssetExpansionTileAsset> {
  bool _isExpanded = false;

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Image.asset(
              "assets/icons/tractian_asset.png",
            ),
          ),
          const SizedBox(width: 10),
          Text(
            widget.asset.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColorAssetTractianColor,
            ),
          ),
        ],
      ),
      leading: Icon(
        _isExpanded ? Icons.keyboard_arrow_down : Icons.arrow_forward_ios,
        size: _isExpanded ? 20 : 12,
      ),
      trailing: const SizedBox.shrink(),
      tilePadding: EdgeInsets.only(left: widget.leftPadding),
      children: [
        ...widget.asset.assetList
            .map((e) => widget.buildTile(e, leftPadding: 16 + widget.leftPadding)),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
    );
  }
}
