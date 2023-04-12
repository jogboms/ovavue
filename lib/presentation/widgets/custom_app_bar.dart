import 'package:flutter/material.dart';

import '../theme.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions = const <Widget>[],
    this.asSliver = false,
    this.backgroundColor,
    this.centerTitle,
  });

  static const CustomAppBar empty = CustomAppBar(title: Text(''));

  final Widget title;
  final List<Widget> actions;
  final bool asSliver;
  final Color? backgroundColor;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    final Color backgroundColor = this.backgroundColor ?? theme.colorScheme.surface;
    final Widget? leading =
        ModalRoute.of(context)?.canPop == true ? BackButton(color: theme.colorScheme.onSurface) : null;
    final DefaultTextStyle title = DefaultTextStyle(
      style: theme.textTheme.titleMedium!.copyWith(
        height: 1,
        fontWeight: AppFontWeight.semibold,
      ),
      child: this.title,
    );

    if (asSliver) {
      return SliverAppBar(
        pinned: true,
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: leading,
        centerTitle: centerTitle ?? false,
        surfaceTintColor: Colors.transparent,
        title: title,
        actions: actions,
      );
    }

    return AppBar(
      elevation: 0,
      leading: leading,
      backgroundColor: backgroundColor,
      title: title,
      centerTitle: centerTitle ?? true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
