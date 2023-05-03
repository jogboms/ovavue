import 'package:flutter/widgets.dart';
import 'package:tabler_icons/tabler_icons.dart';

abstract class AppIcons {
  static const IconData budget = TablerIcons.businessplan;
  static const IconData plans = TablerIcons.database;
  static const IconData categories = TablerIcons.category;
  static const IconData settings = TablerIcons.settings;
  static const IconData addBudget = TablerIcons.square_rounded_plus;
  static const IconData addPlan = TablerIcons.coins;
  static const IconData addCategory = TablerIcons.layout_grid_add;
  static const IconData addAllocation = TablerIcons.coin;
  static const IconData modifyAllocation =
      TablerIcons.adjustments; // TODO(jogboms): update to `adjustments_dollar` when available
  static const IconData removeAllocation = TablerIcons.coin_off;
  static const IconData duplicateBudget = TablerIcons.copy;
  static const IconData excessPlan = TablerIcons.fire_hydrant;
  static const IconData edit = TablerIcons.pencil;
  static const IconData plus = TablerIcons.plus;
  static const IconData delete = TablerIcons.trash_x;
  static const IconData expand = TablerIcons.arrows_maximize;
  static const IconData toggle = TablerIcons.transform;
  static const IconData menu = TablerIcons.layout_bottombar_expand;
  static const IconData arrowDown = TablerIcons.caret_down;
  static const IconData toggleAll = TablerIcons.switch_icon;
  static const IconData close = TablerIcons.x;
  static const IconData amount = TablerIcons.premium_rights;
  static const IconData date = TablerIcons.calendar_event;
  static const IconData title = TablerIcons.heading;
  static const IconData description = TablerIcons.letter_case;

  /// Would be great not to change the index of the icons. Append-only and/or Replace-only
  static final Map<int, IconData> categoryIcons = <IconData>{
    TablerIcons.folder,
    TablerIcons.focus,
    TablerIcons.pig_money,
    TablerIcons.cash,
    TablerIcons.shopping_cart,
    TablerIcons.heart,
    TablerIcons.gift,
    TablerIcons.baby_carriage,
    TablerIcons.moneybag,
    TablerIcons.beach,
    TablerIcons.dog,
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
    TablerIcons.mood_smile_beam,
    TablerIcons.device_tv,
    TablerIcons.chart_pie,
    TablerIcons.package,
  }.toList(growable: false).asMap();
}
