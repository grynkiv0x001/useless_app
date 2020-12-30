/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-29 21:44:51 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 03:34:27
 * 
*/

import 'package:casual_learning_app/configs/Keys.dart';
import "package:casual_learning_app/views/widgets/CLAAppbar.dart";
import "package:casual_learning_app/views/pages/Pages.dart";
import "package:casual_learning_app/views/pages/SignIn.dart";
import "package:casual_learning_app/views/pages/Settings.dart";
import "package:casual_learning_app/models/User.dart";

import "package:flutter/material.dart";


class Profile extends StatefulWidget {

	@override
	State<StatefulWidget> createState() {

		return _ProfileState();
	} 
}

class _ProfileState extends State<Profile> {

	User userProfile = Pages.getLoggedUser;

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: CLAAppbar.customAppbar("Мій кабінет"),
			body: Column(
				children: [
					Row(
						children: [
							Container(
								child: Column(
									children: [
										Row(
											children: [
												IconButton(
													icon: Icon(Icons.settings),
													color: Colors.white,
													iconSize: 24,
													onPressed: () {
														Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => Settings()));
													},
												)
											],
										),
										Row(
											children: [
												Container(
													child: Text(
														userProfile.getFullname,
														style: TextStyle(
															fontSize: 28,
															color: Colors.white
														),
													),
												)
											],
											mainAxisAlignment: MainAxisAlignment.center
										),
										SizedBox(
											height: 20
										),
										Row(
											children: [
												Container(
													child: Text(
														"Пройдених занять: 6",
														style: TextStyle(
															fontSize: 16,
															color: Colors.black
														),
													)
												)
											],
											mainAxisAlignment: MainAxisAlignment.center
										),
										SizedBox(
											height: 30
										)
									],
									mainAxisAlignment: MainAxisAlignment.center
								),
								// padding: EdgeInsets.only(top: 120.0),
								color: Colors.indigoAccent,
								width: MediaQuery.of(context).size.width
							)
						],
					),
					SizedBox(
						height: 10,
					),
					Row(
						children: [
							Container(
								child: Column(
									children: [
										Row(
											children: [
												Container(
													child: FlatButton(
														child: Row(
															children: [
																Icon(Icons.add, color: Colors.white),
																Text(" Моя статистика", style: TextStyle(color: Colors.white))
															]
														),
														color: Colors.indigo,
														minWidth: 350,
														onPressed: () {}
													)
												)
											]
										),
										SizedBox(
											height: 10
										),
										Row(
											children: [
												Container(
													child: FlatButton(
														child: Row(
															children: [
																Icon(Icons.add, color: Colors.white),
																Text(" Історія", style: TextStyle(color: Colors.white))
															]
														),
														color: Colors.indigo,
														minWidth: 350,
														onPressed: () {}
													)
												)
											]
										),	
										SizedBox(
											height: 10
										),
										Row(
											children: [
												Container(
													child: FlatButton(
														child: Row(
															children: [
																Icon(Icons.add, color: Colors.white),
																Text(" Запропонувати урок", style: TextStyle(color: Colors.white))
															]
														),
														color: Colors.indigo,
														minWidth: 350,
														onPressed: () {}
													)
												)
											]
										),
										SizedBox(
											height: 10
										),
										Row(
											children: [
												Container(
													child: FlatButton(
														child: Row(
															children: [
																Icon(Icons.add, color: Colors.white),
																Text(" Покинути кабінет", style: TextStyle(color: Colors.white))
															]
														),
														color: Colors.indigo,
														minWidth: 350,
														onPressed: () {
															Keys.navigatorState1.currentState.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignIn()), (Route<dynamic> route) => false);
														}
													)
												)
											]
										),	
									],
								),
							)
						],
						mainAxisAlignment: MainAxisAlignment.center
					)
				]
			)
		);
	}
}