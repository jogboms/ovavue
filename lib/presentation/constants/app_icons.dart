import 'package:flutter/widgets.dart';
import 'package:tabler_icons/tabler_icons.dart';

abstract class AppIcons {
  static const IconData budget = TablerIcons.businessplan;
  static const IconData plans = TablerIcons.database;
  static const IconData categories = TablerIcons.category;
  static const IconData settings = TablerIcons.settings;
  static const IconData addBudget = TablerIcons.script_plus;
  static const IconData addPlan = TablerIcons.coins;
  static const IconData addCategory = TablerIcons.layout_grid_add;
  static const IconData addAllocation = TablerIcons.coin;
  static const IconData modifyAllocation =
      TablerIcons.adjustments; // TODO(jogboms): update to `adjustments_dollar` when available
  static const IconData removeAllocation = TablerIcons.coin_off;
  static const IconData duplicateBudget = TablerIcons.copy;
  static const IconData excessPlan = TablerIcons.anchor;
  static const IconData edit = TablerIcons.pencil;
  static const IconData plus = TablerIcons.plus;
  static const IconData delete = TablerIcons.trash_x;
  static const IconData expand = TablerIcons.arrows_maximize;
  static const IconData toggle = TablerIcons.transform;
  static const IconData menu = TablerIcons.layout_bottombar_expand;
  static const IconData arrowDropDown = TablerIcons.square_rounded_arrow_down;
  static const IconData toggleAll = TablerIcons.switch_icon;
  static const IconData close = TablerIcons.x;

  /// Would be great not to change the index of the icons. Append-only and/or Replace-only
  static final Map<int, IconData> categoryIcons = <IconData>{
    TablerIcons.windmill,
    TablerIcons.focus,
    TablerIcons.pig_money,
    TablerIcons.cash,
    TablerIcons.shopping_cart,
    TablerIcons.heart,
    TablerIcons.gift,
    TablerIcons.baby_carriage,
    TablerIcons.moneybag,
    TablerIcons.beach,
    TablerIcons.plane_tilt,
    TablerIcons.transfer_out,
    TablerIcons.device_gamepad_2,
    TablerIcons.home_dollar,
    TablerIcons.vaccine,
    TablerIcons.friends,
    TablerIcons.glass_full,
    TablerIcons.sofa,
    TablerIcons.salad,
    TablerIcons.building_bank,
    TablerIcons.pizza,
    TablerIcons.wallet,
    TablerIcons.bottle,
    TablerIcons.world,
  }.toList(growable: false).asMap();
}
