
// Button styles
import 'package:flutter/material.dart';
import 'package:stock_manager/styles/colors.dart';

final ButtonStyle kPrimaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryColor,
  padding: EdgeInsets.symmetric(vertical: 16.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
);

final ButtonStyle kSecondaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kSecondaryColor,
  padding: EdgeInsets.symmetric(vertical: 16.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
);

final ButtonStyle kOutlinedButtonStyle = OutlinedButton.styleFrom(
  foregroundColor: kPrimaryColor,
  padding: EdgeInsets.symmetric(vertical: 16.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
);