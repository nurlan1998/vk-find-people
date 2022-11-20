import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vk_find_people/modules/vk/view/vk_friends_page.dart';
import 'package:vk_find_people/modules/vk/view/vk_profile_page.dart';
import 'package:vk_find_people/modules/vk/view/vk_search_page.dart';

class VkDashboardPage extends StatefulWidget {
  const VkDashboardPage({Key? key}) : super(key: key);

  @override
  State<VkDashboardPage> createState() => _VkDashboardPageState();
}

class _VkDashboardPageState extends State<VkDashboardPage>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<int> _activeTab = ValueNotifier(0);
  late TabController tabController;

  void changeTab(int index) {
    tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );

    tabController.addListener(() {
      if (_activeTab.value != tabController.index) {
        _activeTab.value = tabController.index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              brightness: Theme.of(context).brightness,
              title: const Text('Поиск друзей',style: TextStyle(color: Colors.black),),
              actions: [],
            ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _activeTab,
        builder: (context, int tab, child) => BottomNavigation(
          currentIndex: tab,
          onTabPressed: changeTab,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [VkFriendsPage(), VkSearchPage(), VkProfilePage()],
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final int? currentIndex;
  final Function(int)? onTabPressed;

  const BottomNavigation({
    Key? key,
    this.currentIndex,
    this.onTabPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey[600],
      //selectedItemColor: AppColors.primary,
      showUnselectedLabels: true,
      onTap: (int index) {
        onTabPressed!(index);
      },
      backgroundColor: Colors.white,
      currentIndex: currentIndex ?? 0,
      elevation: 8.0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.apps),
          label: 'Друзья',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Поиск',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Профиль',
        ),
      ],
    );
  }
}
