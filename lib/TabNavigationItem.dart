import 'package:flutter/material.dart';

import 'Home.dart';
import 'Browse.dart';
import 'Profile.dart';


class TabNavigationItem {
	final Widget page;
	final Widget title;
	final Icon icon;

	TabNavigationItem({
		@required this.page,
		@required this.title,
		@required this.icon,
	});

	static List<TabNavigationItem> get items => [
		TabNavigationItem(
			page: Home(),
			icon: Icon(Icons.home),
			title: Text("Home"),
		),
		TabNavigationItem(
			page: Browse(),
			icon: Icon(Icons.search),
			title: Text("Browse"),
		),
		TabNavigationItem(
			page: Profile(),
			icon: Icon(Icons.account_box),
			title: Text("Profile"),
		),
	];
}
