import 'package:flutter/material.dart';
import 'package:tractian/utils/colors/colors.dart';

// ignore: must_be_immutable
class CompanyMenuButton extends StatelessWidget {
  String name;
  void Function() onTap;

  CompanyMenuButton({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 76,
          width: 317,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            color: menuButtonTractianColor,
          ),
          child: Center(
            child: Row(
              children: [
                const SizedBox(width: 20),
                Image.asset(
                  'assets/icons/tractian_asset_icon.png',
                ),
                const SizedBox(width: 20),
                Text(
                  name,
                  style: const TextStyle(
                    color: whiteButtonTractianColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
