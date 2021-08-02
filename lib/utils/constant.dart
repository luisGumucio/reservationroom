import 'package:flutter/material.dart';
import 'package:reservationroom/screens/authenticate/sign_in_page.dart';
import 'package:reservationroom/screens/booking/booking_home.dart';
import 'package:reservationroom/screens/configuration/information/information.dart';
import 'package:reservationroom/screens/room/room_home.dart';

//COLORS
const Color profile_info_background = Color(0xFF3775FD);
const Color profile_info_categories_background = Color(0xFFF6F5F8);
const Color profile_info_address = Color(0xFF8D7AEE);
const Color profile_info_privacy = Color(0xFFF369B7);
const Color profile_info_general = Color(0xFFFFC85B);
const Color profile_info_notification = Color(0xFF5DD1D3);
const Color profile_item_color = Color(0xFFC4C5C9);
const String imagePath = 'assets/image';

const Color furnitureCateDisableColor = Color(0xFF939BA9);
const List lampsImage = [
  {'image': '$imagePath/a.jpg'},
  {'image': '$imagePath/b.jpg'},
  {'image': '$imagePath/c.jpg'},
  {'image': '$imagePath/d.jpg'},
  {'image': '$imagePath/e.jpg'},
  {'image': '$imagePath/f.jpg'},
];
List<ProfileMenu> lampList = [
  ProfileMenu(title: 'Landscape', subTitle: '384'),
  ProfileMenu(title: 'Discus Pendant', subTitle: '274'),
  ProfileMenu(title: 'Mushroom Lamp', subTitle: '374'),
  ProfileMenu(title: 'Titanic Pendant', subTitle: '562'),
  ProfileMenu(title: 'Torn Lighting', subTitle: '105'),
  ProfileMenu(title: 'Abduction Pendant', subTitle: '365'),
];
const List profileItems = [
  {'count': '846', 'name': 'Cuartos'},
  {'count': '51', 'name': 'Likes'},
  {'count': '267', 'name': 'Confiable'},
];

List<Catg> listProfileCategories = [
  Catg(name: 'Wallet', icon: CustomIcon.account_balance_wallet, number: 0),
  Catg(name: 'Delivery', icon: CustomIcon.truck, number: 0),
  Catg(name: 'Message', icon: CustomIcon.chat, number: 2),
  Catg(name: 'Service', icon: CustomIcon.money, number: 0),
];

List<FurnitureCatg> furnitureCategoriesList = [
  FurnitureCatg(icon: Icons.desktop_windows, elivation: true),
  FurnitureCatg(icon: CustomIcon.account_balance_wallet, elivation: false),
  FurnitureCatg(icon: Icons.security, elivation: false),
  FurnitureCatg(icon: CustomIcon.chat, elivation: false),
  FurnitureCatg(icon: CustomIcon.money, elivation: false),
];

List<ProfileMenu> profileMenuList = [
  ProfileMenu(
      title: 'Cuartos',
      subTitle: 'Todos los cuartos registrados',
      iconColor: profile_info_address,
      icon: Icons.domain_rounded,
      page: RoomHome()),
  ProfileMenu(
      title: 'Reservas',
      subTitle: 'Muestra mis reservas de cuartos',
      iconColor: profile_info_privacy,
      icon: Icons.home_repair_service,
      page: EditProfilePage()),
  ProfileMenu(
      title: 'Pedidos',
      subTitle: 'Muestra todas las cuartos reservados',
      iconColor: profile_info_notification,
      icon: Icons.home,
      page: BookingHome()),
  ProfileMenu(
      title: 'Salir',
      subTitle: 'Salir de la applicacion',
      iconColor: profile_info_general,
      icon: Icons.logout,
      page: SignInPage()),
];

class ProfileMenu {
  String title;
  String subTitle;
  IconData icon;
  Color iconColor;
  Widget page;
  ProfileMenu(
      {this.icon, this.title, this.iconColor, this.subTitle, this.page});
}

class Catg {
  String name;
  IconData icon;
  int number;
  Catg({this.icon, this.name, this.number});
}

class FurnitureCatg {
  IconData icon;
  bool elivation;
  FurnitureCatg({this.icon, this.elivation});
}

class CustomIcon {
  CustomIcon._();

  static const _icomoon = 'icomoon';
  static const _kFontFam = 'MyFlutterApp';

  static const IconData truck = const IconData(0xe800, fontFamily: _kFontFam);
  static const IconData chat = const IconData(0xe801, fontFamily: _kFontFam);
  static const IconData money = const IconData(0xe802, fontFamily: _kFontFam);
  static const IconData account_balance_wallet =
      const IconData(0xf008, fontFamily: _kFontFam);

  static const IconData wallet = const IconData(0xe910, fontFamily: _icomoon);
  static const IconData delivery = const IconData(0xe904, fontFamily: _icomoon);
  static const IconData message = const IconData(0xe900, fontFamily: _icomoon);
  static const IconData service = const IconData(0xe90f, fontFamily: _icomoon);
}
