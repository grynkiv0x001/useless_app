import 'package:flutter/material.dart';

import 'package:useless_app/TabNavigationItem.dart';


class Pages extends StatefulWidget {

	@override
	_PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {

	int _currentIndex = 0;

	// Widget _title;

	@override
	Widget build(BuildContext context) {

		// _title = TabNavigationItem.items.elementAt(_currentIndex).title;

		return Scaffold(
			body: IndexedStack(
				index: _currentIndex,
				children: [
					for (final tabItem in TabNavigationItem.items) tabItem.page,
				],
			),	
			bottomNavigationBar: BottomNavigationBar(
				currentIndex: _currentIndex,
				onTap: (int index) => setState(() => _currentIndex = index),
				items: [
					for (final tabItem in TabNavigationItem.items)
						BottomNavigationBarItem(
							icon: tabItem.icon,
							title: tabItem.title
						)
				],
			),
		);
	}
}