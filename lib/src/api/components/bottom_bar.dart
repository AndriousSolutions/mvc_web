// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/src/view.dart';

/// Displays a list of child widgets along the bottom of a webpage.
class BottomBar extends StatelessWidget {
  ///
  const BottomBar({Key? key, required this.children}) : super(key: key);

  ///
  final Column children;

  @override
  Widget build(BuildContext context) {
    // Determine the screen's size.
//    final smallScreen = ResponsiveWidget.isSmallScreen(context);
    final smallScreen = App.inSmallScreen;
    final textStyle = TextStyle(color: Colors.blueGrey[300], fontSize: 14);
    return Container(
      padding: const EdgeInsets.all(30),
      color: Theme.of(context).bottomAppBarColor,
      child: children,
    );
  }
}

/// Column
class BottomBarColumn extends StatelessWidget {
  /// Optional callback functions for the list of headings displayed in a column.
  const BottomBarColumn({
    required this.heading,
    this.s1,
    this.onPressedS1,
    this.s2,
    this.onPressedS2,
    this.s3,
    this.onPressedS3,
    Key? key,
  }) : super(key: key);

  ///
  final String heading;

  ///
  final String? s1;

  ///
  final VoidCallback? onPressedS1;

  ///
  final String? s2;

  ///
  final VoidCallback? onPressedS2;

  ///
  final String? s3;

  ///
  final VoidCallback? onPressedS3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (s1 != null) const SizedBox(height: 10),
          if (s1 != null)
            TextButton(
              onPressed: onPressedS1 ?? () {},
              child: Text(
                s1!,
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 14,
                ),
              ),
            ),
          if (s2 != null) const SizedBox(height: 5),
          if (s2 != null)
            TextButton(
              onPressed: onPressedS2 ?? () {},
              child: Text(
                s2!,
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 14,
                ),
              ),
            ),
          if (s3 != null) const SizedBox(height: 5),
          if (s3 != null)
            TextButton(
              onPressed: onPressedS3 ?? () {},
              child: Text(
                s3!,
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
