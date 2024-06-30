import 'package:flutter/material.dart';

MyTabBar(TabController tabController, BuildContext context) {
  {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: TabBar(
        controller: tabController,
        indicatorWeight: 6,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: Theme.of(context).textTheme.headlineSmall,
        unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,

        tabs: const [
          Tab(
            text: "Chats",
          ),
          Tab(
            text: "Groups",
          ),
          Tab(
            text: "Calls",
          ),
        ],
      ),
    );
  }
}
