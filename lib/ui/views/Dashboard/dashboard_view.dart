import 'package:flutter/material.dart';

import 'package:retailhub/constants/app_colors.dart';
import 'package:retailhub/constants/string.dart';
import 'package:retailhub/ui/views/Profile/profile_view.dart';
import 'package:retailhub/ui/views/Search/search_view.dart';
import 'package:retailhub/ui/views/Tickets/tickets_view.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/custom_strings.dart';
import '../../../utill/app_text_style.dart';
import '../HomeView/home_view.dart';
import 'dashboard_viewmodel.dart';

class DashboardView extends StatefulWidget {
  final int initialTab;
  DashboardView({required this.initialTab});
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  String title = appName;
  @override
  void initState() {
    _controller =
        TabController(vsync: this, length: 4, initialIndex: widget.initialTab);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    SearchView(),
    TicketsView(),
    ProfileView()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder:
          (BuildContext? context, DashboardViewModel viewModel, Widget? child) {
        return Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
                backgroundColor: black,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
                backgroundColor: black,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: '',
                backgroundColor: black,
              ),
              BottomNavigationBarItem(
                backgroundColor: black,
                icon: PopupMenuButton(
                  offset: const Offset(300, -170),
                  // position: PopupMenuPosition.under,
                  icon: const Icon(Icons.person),

                  itemBuilder: (_) => <PopupMenuItem>[
                    PopupMenuItem(
                        value: 'test1',
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: primaryColor, shape: BoxShape.circle),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.h, vertical: 2.h),
                                  child: Row(
                                    children: [
                                      Text(
                                        viewModel.firstName.isNotEmpty
                                            ? viewModel.firstName[0]
                                                .toUpperCase()
                                            : 'R',
                                        style: TextStyle(
                                          color: backgroundColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        viewModel.lastName.isNotEmpty
                                            ? viewModel.lastName[0]
                                                .toUpperCase()
                                            : 'J',
                                        style: TextStyle(
                                            color: backgroundColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // fname!+"",
                                  "${viewModel?.fullName.toString()}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Normal',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  // "RetailHub.com",
                                  "${viewModel?.email.toString()}",
                                  // "",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Normal',
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        )),
                    PopupMenuItem(
                        value: 'test2',
                        child: InkWell(
                          onTap: (() {
                            viewModel?.navigateToProfile();
                            // Get.toNamed(RoutesName.settingsScreen);
                          }),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.settings,
                                color: Colors.black54,
                                size: 40,
                              ),
                              SizedBox(width: 4.w),
                              const Text(
                                'Settings',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Normal',
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )),
                    PopupMenuItem(
                        value: 'test3',
                        child: InkWell(
                          onTap: (() {
                            showDialog(
                              barrierColor: Colors.black26,
                              context: context!,
                              builder: (context) {
                                return logoutDialog(viewModel);
                              },
                            );
                          }),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.logout,
                                color: Colors.black54,
                                size: 40,
                              ),
                              SizedBox(width: 4.w),
                              const Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Normal',
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            backgroundColor: appbarcolor,
            unselectedItemColor: unselectedBottomBarItem,
            selectedItemColor: selectedBottomBarItem,
            onTap: _onItemTapped,
            showUnselectedLabels: true,
            showSelectedLabels: true,
          ),
        );
      },
      viewModelBuilder: () => DashboardViewModel(),
      onModelReady: (DashboardViewModel model) {
        model.initMethod(context);
      },
    );
  }

  logoutDialog(DashboardViewModel model) {
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(CustomStrings.signOut, style: MyTextStyle.scoutCard),
          const SizedBox(height: 15),
          Text(
              textAlign: TextAlign.center,
              CustomStrings.signoutdesc,
              style: MyTextStyle.scoutyear),
          const SizedBox(height: 20),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                    child: Center(
                      child: Text("Cancel", style: MyTextStyle.scoutyear),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                ),
                InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    model.logout(context);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                    child: Center(
                      child: Text("Sign Out", style: MyTextStyle.scoutyear),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
