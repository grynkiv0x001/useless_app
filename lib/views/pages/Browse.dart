/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-29 21:44:30 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 03:25:40
 * 
*/

import 'package:casual_learning_app/configs/DatabaseConnector.dart';
import 'package:casual_learning_app/configs/Keys.dart';
import 'package:casual_learning_app/models/Tutorial.dart';
import 'package:casual_learning_app/views/pages/Founded.dart';
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/views/pages/Cooking.dart';
import 'package:casual_learning_app/views/pages/Casual.dart';
import 'package:casual_learning_app/views/pages/Music.dart';
import "package:casual_learning_app/views/pages/IT.dart";

import 'package:flutter/material.dart';


class Browse extends StatefulWidget{

	@override
	State<StatefulWidget> createState() {

		return _BrowseState();
	} 
}

class _BrowseState extends State<Browse> {

	List<Tutorial> tuts = [];

	Future<List<Tutorial>> getAllMusicTutorials() async {

		String sql = "SELECT * FROM tutorials";

		DatabaseConnector connector = DatabaseConnector();

		List<Tutorial> tutorials = await connector.tutorials(sql);

		setList(tutorials);

		// connector.close();

		return tutorials;
	}

	void setList(List<Tutorial> tutorials) {

		setState(() {
			tuts = tutorials;
		});
	}

	@override
	Widget build(BuildContext context) {

		TextEditingController _query = TextEditingController();

		return Scaffold(
			resizeToAvoidBottomPadding: false,
			appBar: CLAAppbar.customAppbar("Оберіть категорію"),
			body: Column(
				children: [
					SizedBox(
						height: 20
					),
					Container(
						child: TextField(
							decoration: InputDecoration(
								hintText: "або скористайтесь пошуком ...",
								hintStyle: TextStyle(
									color: Colors.black54,
									fontStyle: FontStyle.italic
								),
								prefixIcon: Icon(Icons.search),
							),
							style: TextStyle(
								fontSize: 16,
								color: Colors.black
							),
							onSubmitted: (value) {
								Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => Founded(value)));
							},
							// controller: _query,
						),
						width: 350,
					),
					SizedBox(
						height: 150
					),
					Row(
						children: [
							RaisedButton(
								child: Container(
									child: Text(
										"ІТ сфера",
										style: TextStyle(
											fontSize: 20,
											fontWeight: FontWeight.w600,
											color: Colors.white
										)
									),
									width: 110,
									height: 40,
									alignment: Alignment.center
								),
								padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
								color: Colors.indigo,
								onPressed: () {
									Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => IT("IT")));
								},
							),
							SizedBox(
								width: 15
							),
							RaisedButton(
								child: Container(
									child: Text(
										"Кулінарія",
										style: TextStyle(
											fontSize: 20,
											fontWeight: FontWeight.w600,
											color: Colors.white
										)
									),
									width: 110,
									height: 40,
									alignment: Alignment.center
								),
								padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
								color: Colors.orange,
								onPressed: () {
									Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => Cooking("Cooking")));
								}
							)
						],
						mainAxisAlignment: MainAxisAlignment.center
					),
					SizedBox(
						height: 15
					),
					Row(
						children: [
							RaisedButton(
								child: Container(
									child: Text(
										"Мистецтво",
										style: TextStyle(
											fontSize: 20,
											fontWeight: FontWeight.w600,
											color: Colors.white
										)
									),
									width: 110,
									height: 40,
									alignment: Alignment.center
								),
								padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
								color: Colors.lime,
								onPressed: () {
									Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => Music("Music")));
								}
							),
							SizedBox(
								width: 15
							),
							RaisedButton(
								child: Container(
									child: Text(
										"Різне",
										style: TextStyle(
											fontSize: 20,
											fontWeight: FontWeight.w600,
											color: Colors.white
										)
									),
									width: 110,
									height: 40,
									alignment: Alignment.center
								),
								padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
								color: Colors.red,
								onPressed: () {
									Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => Casual("Casual")));
								}
							)
						],
						mainAxisAlignment: MainAxisAlignment.center
					)
				]
			)
		);
	}
}