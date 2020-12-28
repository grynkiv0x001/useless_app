/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-29 22:00:22 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 03:35:01
 * 
*/

import 'package:casual_learning_app/configs/Keys.dart';
import "package:flutter/material.dart";


class CLAAppbar {

	static String _title = "";

	static Widget customAppbar(String state) {

		_title = state;

		return AppBar(
			title: Text(
				_title,
				style: TextStyle(
					fontWeight: FontWeight.w600
				),
			),
			leading: IconButton(
				icon: Icon(Icons.arrow_back_ios),
				onPressed: () {
					Keys.navigatorState1.currentState.pop();
				},
			),
			centerTitle: true,
		);
	}
}