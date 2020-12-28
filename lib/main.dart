/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-29 19:07:24 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:24:58
 * 
*/

import "package:flutter/material.dart";

import "package:casual_learning_app/configs/CLATheme.dart";
import "package:casual_learning_app/views/pages/SignIn.dart";

import 'configs/Keys.dart';


class CasualLearningApp extends StatelessWidget {
	
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: "1000 уроків",
			theme: ThemeData(
				primaryColor: CLATheme.primaryColor,
				accentColor: CLATheme.accentColor,
				fontFamily: CLATheme.appFont
			),
			navigatorKey: Keys.navigatorState1,
			home: SignIn()
		);
	}
}

void main() {
	runApp(CasualLearningApp());
}