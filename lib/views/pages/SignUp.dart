/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-29 21:43:01 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 03:46:20
 * 
*/

import "package:flutter/material.dart";

import "package:casual_learning_app/configs/DatabaseConnector.dart";
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/views/pages/SignIn.dart';
import "package:casual_learning_app/configs/CLATheme.dart";
import 'package:casual_learning_app/configs/Keys.dart';


class SignUp extends StatefulWidget {

	@override
	State<StatefulWidget> createState() {

		return _SignUpState();
	}
}

class _SignUpState extends State<SignUp> {

	TextEditingController _fullnameController = TextEditingController();
	TextEditingController _emailController	  = TextEditingController();
	TextEditingController _passwordController = TextEditingController();

	DatabaseConnector _connector = DatabaseConnector();

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			resizeToAvoidBottomPadding: false,
			appBar: CLAAppbar.customAppbar("Реєстрація користувача"),
			body: Center(
				child: Container(
					padding: EdgeInsets.all(80.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text(
								"Дані користувача",
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
									hintText: "Ім'я користувача"
								),
								controller: _fullnameController
							),
							TextFormField(
								decoration: InputDecoration(
									hintText: "Адреса ел. пошти"
								),
								controller: _emailController
							),
							TextFormField(
								decoration: InputDecoration(
									hintText: "Придумайте пароль",
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
										fontWeight: FontWeight.bold
									),
								),
								textColor: Colors.white,
								onPressed: () async {
									_connector.users("INSERT INTO users (fullname, email, userpassword) VALUES ('${_fullnameController.text}', '${_emailController.text}', '${_passwordController.text}')");
									Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => SignIn()));
								},
							)
						]
					)
				)
			)
		);
	}
}