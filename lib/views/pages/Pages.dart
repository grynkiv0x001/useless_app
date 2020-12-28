/*
 * @Author: grynkiv0x001 
 * @Date: 2020-12-17 03:00:51 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 01:13:27
 * 
*/

import "package:flutter/material.dart";

import "package:casual_learning_app/configs/CLANavigationItem.dart";
import "package:casual_learning_app/models/User.dart";


// ignore: must_be_immutable
class Pages extends StatefulWidget {

	static User _loggedUser;

	Pages(User user) {
		_loggedUser = user;
	}

	static User get getLoggedUser => _loggedUser;
	static set setLoggedUser(User user) => _loggedUser = user;

	@override
	_PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {

	int _currentIndex = 0;

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			resizeToAvoidBottomPadding: false,
			body: IndexedStack(
				index: _currentIndex,
				children: [
					for (final tabItem in CLANavigationItem.items) tabItem.page,
				],
			),	
			bottomNavigationBar: BottomNavigationBar(
				currentIndex: _currentIndex,
				onTap: (int index) => setState(() => _currentIndex = index),
				items: [
					for (final tabItem in CLANavigationItem.items)
						BottomNavigationBarItem(
							icon: tabItem.icon,
							label: tabItem.title
						)
				],
			),
		);
	}
}