import 'package:hood/controller/notification_badge_controller.dart';
import 'package:hood/ui/profile/profile_screen/profile_screen.dart';
import 'package:hood/ui/chat/chat_screen/chat_screen.dart';
import 'package:hood/ui/home/home_screen/home_screen.dart';
import 'package:hood/ui/exchange/exchange_screen.dart';
import 'package:hood/ui/widgets/custom_inkwell.dart';
import 'package:hood/ui/widgets/custom_text.dart';
import 'package:hood/utils/constants.dart';
import 'package:hood/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
//Bottom navigation with floating action button in the center
class NewMainScreen extends StatefulWidget {
  const NewMainScreen({super.key});

  @override
  State<NewMainScreen> createState() => _NewMainScreenState();
}

final List<String> _texts = [
  'Нүүр',
  'Солилцоо',
  '',
  'Чат',
  'Профайл',
];

class _NewMainScreenState extends State<NewMainScreen> {
  final NotificationBadgeController _notificationBadgeController = Get.put(NotificationBadgeController());
  late PageController _pageController = PageController();
  final list = List.filled(5, 0);
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _notificationBadgeController.listenToUnreadChats();
    _pageController = PageController(
      keepPage: true,
      initialPage: 0,
      viewportFraction: 1.0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _notificationBadgeController.stopListenToUnreadChats();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          const HomeScreen(),
          const ExchangeScreen(),
          Container(),
          const ChatScreen(),
          const ProfileScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => HapticFeedback.vibrate(),
        backgroundColor: HoodColors.hoodThemeColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(HoodDimension.hoodTwelve))),
        child: SvgPicture.asset('assets/svgs/bottomNavigation/camera.svg'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: HoodColors.hoodWhite,
        notchMargin: HoodDimension.hoodEight,
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(HoodDimension.hoodFifteen)),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(HoodDimension.hoodTen)),
          ),
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: HoodDimension.hoodEight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: list.asMap().entries.map((e) {
                final idx = e.key;
                if (idx == 2) {
                  return const SizedBox(
                    width: 60,
                    height: 60,
                  );
                } else {
                  return BottomAppBarItem(
                    index: idx,
                    selectedIndex: selectedIndex,
                    onClickListener: (index) async {
                      setState(() {
                        selectedIndex = index;
                      });
                      _pageController.jumpToPage(selectedIndex);
                    },
                  );
                }
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomAppBarItem extends StatelessWidget {
  BottomAppBarItem({
    Key? key,
    required this.index,
    required this.selectedIndex,
    required this.onClickListener,
  }) : super(key: key);
  final int index;
  final int selectedIndex;
  final Function(int) onClickListener;
  final NotificationBadgeController notificationBadgeController = Get.find<NotificationBadgeController>();
  @override
  Widget build(BuildContext context) {
    List<dynamic> icons = [
      SvgPicture.asset(
        'assets/svgs/bottomNavigation/home.svg',
        color: selectedIndex == 0 ? HoodColors.hoodButtonColor : HoodColors.hoodTextColorIconColor,
      ),
      SvgPicture.asset(
        'assets/svgs/bottomNavigation/exchange.svg',
        color: selectedIndex == 1 ? HoodColors.hoodButtonColor : HoodColors.hoodTextColorIconColor,
      ),
      SvgPicture.asset(
        'assets/svgs/bottomNavigation/chat.svg',
        color: selectedIndex == 2 ? HoodColors.hoodButtonColor : HoodColors.hoodTextColorIconColor,
      ),
      SvgPicture.asset(
        'assets/svgs/bottomNavigation/chat.svg',
        color: selectedIndex == 3 ? HoodColors.hoodButtonColor : HoodColors.hoodTextColorIconColor,
      ),
      SvgPicture.asset(
        'assets/svgs/bottomNavigation/profile.svg',
        color: selectedIndex == 4 ? HoodColors.hoodButtonColor : HoodColors.hoodTextColorIconColor,
      ),
    ];
    return CustomInkWell(
      onTap: () => onClickListener(index),
      child: Container(
        width: 62,
        height: HoodDimension.hoodSixtySmall,
        decoration: BoxDecoration(color: index == selectedIndex ? HoodColors.hoodBotNavSelectCon : Colors.white, borderRadius: BorderRadius.circular(HoodDimension.hoodTwelve)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            index == 3
                ? Obx(() {
                    return Badge(
                      badgeColor: HoodColors.hoodThemeColor,
                      padding: const EdgeInsets.all(HoodDimension.hoodFour),
                      badgeContent: CustomText(
                        text: notificationBadgeController.unreadChats.toString(),
                        color: HoodColors.hoodWhite,
                      ),
                      toAnimate: selectedIndex == 3,
                      animationType: BadgeAnimationType.slide,
                      child: icons[index],
                      showBadge: notificationBadgeController.unreadChats > 0,
                    );
                  })
                : icons[index],
            const SizedBox(height: HoodDimension.hoodFour),
            CustomText(
              isBold: selectedIndex == index ? true : false,
              text: _texts[index],
              color: selectedIndex == index ? HoodColors.hoodTextColorIconColor : HoodColors.hoodTextColorIconColor,
            )
          ],
        ),
      ),
    );
  }
}
