/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-29 21:43:41 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 03:40:24
 * 
*/

import 'package:casual_learning_app/configs/Keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:casual_learning_app/models/User.dart';
import 'package:casual_learning_app/configs/CLATheme.dart';
import 'package:casual_learning_app/views/pages/SignUp.dart';
import 'package:casual_learning_app/views/pages/Pages.dart';
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/configs/DatabaseConnector.dart';


class SignIn extends StatefulWidget {

	@override 
	State<StatefulWidget> createState() {

		return _SignInState();
	}
}

class _SignInState extends State<SignIn> {

	TextEditingController _emailController 	  = TextEditingController();
	TextEditingController _passwordController = TextEditingController();

	List<User> users = List<User>();

	String sql = "SELECT * FROM users";

	String _invalidLogin = "";

	DatabaseConnector _connector = DatabaseConnector();

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			// Disable widget resizing when keyboard appears
			resizeToAvoidBottomPadding: false,
			appBar: CLAAppbar.customAppbar("Увійти"),
			body: Center(
				child: Container(
					padding: EdgeInsets.all(80.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text(
								"Особистий кабінет",
								style: TextStyle(
									color: CLATheme.accentColor,
									fontSize: 24,
									fontWeight: FontWeight.bold
								)
							),
							SizedBox(
								height: 30,
							),
							TextFormField(
								decoration: InputDecoration(
									hintText: "Ел. пошта"
								),
								style: TextStyle(
									fontSize: 18
								),
								controller: _emailController
							),
							TextFormField(
								decoration: InputDecoration(
									hintText: "Пароль",
								),
								style: TextStyle(
									fontSize: 18
								),
								obscureText: true,
								controller: _passwordController
							),
							SizedBox(
								height: 24
							),
							RaisedButton(
								color: CLATheme.accentColor,
								child: Text(
									"ДАЛІ",
									style: TextStyle(
										fontWeight: FontWeight.bold,
									),
								),
								textColor: Colors.white,
								onPressed: () async {

									users = await _connector.users(sql);

									setState(() {
										for (final user in users) {
											if (user.getEmail == _emailController.text && user.getPassword == _passwordController.text) {
												Pages.setLoggedUser = user;
												Keys.navigatorState1.currentState.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Pages(user)), (Route<dynamic> route) => false);
											} else {
												_invalidLogin = "Невірно введені дані!";
											}
										}
									});
								}
							),
							SizedBox(
								height: 20,
							),
							Center(
								child: RichText(
									text: TextSpan(
										text: "Вперше тут?",
										style: TextStyle(
											color: Colors.black,
											fontSize: 16
										),
										children: <TextSpan>[
											TextSpan(
												text: " Новий користувач.",
												style: TextStyle(
													color: Colors.blueAccent,
													fontSize: 16
												),
												recognizer: TapGestureRecognizer()
													..onTap = () {
														Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => SignUp()));
													}	
											)
										]
									),
								),
							),
							SizedBox(
								height: 20,
							),
							Center(
								child: Text(
									_invalidLogin,
									style: TextStyle(
										color: Colors.red,
										fontSize: 18,
										fontWeight: FontWeight.w600
									)
								)
							)
						],
					),
				),
			)
		);
	}
}