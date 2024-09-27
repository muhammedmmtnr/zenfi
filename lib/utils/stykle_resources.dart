import 'dart:ui';

import 'package:flutter/material.dart';


import 'color_resources.dart';

class StyleResources {
  static TextStyle normalBlackText14(BuildContext context) {
    return const TextStyle(
      color: ColorResource.greyColor,
      fontSize: 14.0,
    );
  }

  static TextStyle normalWhiteText14(BuildContext context) {
    return const TextStyle(
      color: ColorResource.whiteTextColor,
      fontSize: 14.0,
    );
  }

  static TextStyle normalWhiteText10(BuildContext context) {
    return const TextStyle(
      color: ColorResource.whiteTextColor,
      fontSize: 10.0,
    );
  }

  static TextStyle normalBlackText10(BuildContext context) {
    return const TextStyle(
      color: ColorResource.greyColor,
      fontSize: 10.0,
    );
  }

  static TextStyle normalWhiteText8(BuildContext context) {
    return const TextStyle(
      color: ColorResource.whiteTextColor,
      fontSize: 8.0,
    );
  }

  static TextStyle mediumBlackText14(BuildContext context) {
    return const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
    );
  }

  static TextStyle mediumBlackText12(BuildContext context) {
    return const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
    );
  }

  static TextStyle mediumBlackText(BuildContext context, double size) {
    return TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      fontSize: size,
    );
  }

  static TextStyle mediumGreyText(BuildContext context, double size) {
    return TextStyle(
      color: ColorResource.greyColor,
      fontWeight: FontWeight.w500,
      fontSize: size,
    );
  }

  static TextStyle mediumGreyText12(BuildContext context) {
    return const TextStyle(
      color: ColorResource.greyColor,
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
    );
  }

  static TextStyle mediumGreyText8(BuildContext context) {
    return const TextStyle(
      color: ColorResource.greyColor,
      fontWeight: FontWeight.w500,
      fontSize: 8.0,
    );
  }

  static TextStyle mediumGreyText14(BuildContext context) {
    return const TextStyle(
      color: ColorResource.greyColor,
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
    );
  }

  static TextStyle mediumWhiteText14(BuildContext context) {
    return const TextStyle(
      color: ColorResource.whiteTextColor,
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
    );
  }

  static TextStyle mediumWhiteText26(BuildContext context) {
    return const TextStyle(
      color: ColorResource.whiteTextColor,
      fontWeight: FontWeight.w500,
      fontSize: 26.0,
    );
  }

  static TextStyle mediumGreyText16(BuildContext context) {
    return const TextStyle(
      color: ColorResource.greyColor,
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    );
  }

  static TextStyle mediumGreyText18(BuildContext context) {
    return const TextStyle(
      color: ColorResource.greyColor,
      fontWeight: FontWeight.w500,
      fontSize: 18.0,
    );
  }

  static TextStyle boldBlackText(BuildContext context, double size) {
    return TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w600,
      fontSize: size,
    );
  }

  static TextStyle boldGreenText(BuildContext context, double size) {
    return TextStyle(
      color: ColorResource.primaryColor,
      fontWeight: FontWeight.w600,
      fontSize: size,
    );
  }

  static TextStyle mediumBoldText(BuildContext context, double size) {
    return TextStyle(
      color: ColorResource.greyColor,
      fontWeight: FontWeight.w600,
      fontSize: size,
    );
  }

  static TextStyle mediumBoldBlueText(BuildContext context, double size) {
    return TextStyle(
      color: ColorResource.invoicePrimaryColor,
      fontWeight: FontWeight.w600,
      fontSize: size,
    );
  }
}
