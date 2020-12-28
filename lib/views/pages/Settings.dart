/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-29 21:44:40 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-17 07:07:00
 * 
*/

import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:flutter/material.dart';


class Settings extends StatefulWidget {

	@override
	State<StatefulWidget> createState() {

		return _SettingsState();
	} 
}

class _SettingsState extends State<Settings> {

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: CLAAppbar.customAppbar("App configuration"),
			body: Center(
				child: Text("Settings page..."),
			),
		);
	}
}