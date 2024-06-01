import 'package:flutter/material.dart';
import 'package:tractian/app/models/asset_model.dart';
import 'package:tractian/app/models/location_model.dart';
import 'package:tractian/utils/colors/colors.dart';

// ignore: must_be_immutable
class CustomExpansionTileLocation extends StatefulWidget {
  LocationModel location;
  double leftPadding;
  Widget Function(LocationModel location, {double leftPadding}) buildTile;
  Widget Function(AssetModel asset, {double leftPadding}) buildAssetTile;

  CustomExpansionTileLocation({
    super.key,
    required this.location,
    required this.leftPadding,
    required this.buildTile,
    required this.buildAssetTile,
  });

  @override
  State<CustomExpansionTileLocation> createState() => _CustomExpansionTileLocationState();
}

class _CustomExpansionTileLocationState extends State<CustomExpansionTileLocation> {
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
              "assets/icons/tractian_location.png",
            ),
          ),
          const SizedBox(width: 10),
          Text(
            widget.location.name,
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
        ...widget.location.childLocations
            .map((e) => widget.buildTile(e, leftPadding: 16 + widget.leftPadding)),
        ...widget.location.assetLists
            .map((e) => widget.buildAssetTile(e, leftPadding: 16 + widget.leftPadding)),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
    );
  }
}
