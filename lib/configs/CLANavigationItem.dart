/*
 * @Author: grynkiv0x001 
 * @Date: 2020-12-17 02:04:53 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 03:27:19
 * 
*/

import "package:flutter/material.dart";

import "package:casual_learning_app/views/pages/Home.dart";
import "package:casual_learning_app/views/pages/Browse.dart";
import "package:casual_learning_app/views/pages/Profile.dart";


class CLANavigationItem {

	final Widget page;
	final String title;
	final Icon icon;

	CLANavigationItem({
		@required this.page,
		@required this.title,
		@required this.icon
	});

	static List<CLANavigationItem> get items => [
		CLANavigationItem(
			page: Home(),
			icon: Icon(Icons.home),
			title: "Головна"
		),
		CLANavigationItem(
			page: Browse(),
			icon: Icon(Icons.search),
			title: "Огляд"
		),
		CLANavigationItem(
			page: Profile(),
			icon: Icon(Icons.account_circle_sharp),
			title: "Кабінет"
		)
	];
}