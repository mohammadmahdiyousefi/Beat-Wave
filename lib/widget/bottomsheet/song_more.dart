import 'package:flutter/material.dart';

Future<Widget?> moreBottomSheet(
  final BuildContext context,
  final Widget title,
  final List<Widget> items,
) {
  return showModalBottomSheet(
    backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    elevation: Theme.of(context).bottomSheetTheme.elevation,
    shape: Theme.of(context).bottomSheetTheme.shape,
    context: context,
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              shape: Theme.of(context).bottomSheetTheme.shape,
              elevation: Theme.of(context).bottomSheetTheme.elevation,
              backgroundColor:
                  Theme.of(context).bottomSheetTheme.backgroundColor,
              automaticallyImplyLeading: false,
              pinned: true,
              centerTitle: true,
              toolbarHeight: 70,
              scrolledUnderElevation: 0,
              title: title,
              bottom: const PreferredSize(
                preferredSize: Size(double.infinity, 3),
                child: Divider(
                  thickness: 1,
                  height: 3,
                  indent: 16,
                  endIndent: 16,
                ),
              ),
            ),
            SliverList.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => items[index],
            ),
          ],
        ),
      );
    },
  );
}
