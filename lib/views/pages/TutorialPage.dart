/*
 * @Author: grynkiv0x001 
 * @Date: 2020-12-10 01:37:20 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-17 13:39:07
 * 
*/

import "package:flutter/material.dart";

import "package:casual_learning_app/configs/DatabaseConnector.dart";
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/models/Tutorial.dart';


class TutorialPage extends StatefulWidget {

	TutorialPage(int id, String title) {
		this.id = id;
		this.title = title;
	}

	int id;
	String title;

	@override
	State<StatefulWidget> createState() {

		return _TutorialPageState(this.id, this.title);
	}
}

class _TutorialPageState extends State<TutorialPage> {

	_TutorialPageState(int id, String title) {
		this.id = id;
		this.title = title;
	}

	int id;
	String title;

	@override
	Widget build(BuildContext context) {

		DatabaseConnector _connector = DatabaseConnector();

		String _sql = "SELECT * FROM tutorials WHERE id = '${this.id}'";

		return Scaffold(
			appBar: CLAAppbar.customAppbar(this.title),
			body: FutureBuilder<List<Tutorial>>(
				future: _connector.tutorials(_sql),
				initialData: List(),
				builder: (BuildContext context, AsyncSnapshot<List<Tutorial>> snapshot) {
					if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
						return ListView.builder(
							padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
							itemCount: snapshot.data.length,
							itemBuilder: (context, index) {
								return Container(
									padding: EdgeInsets.only(top: 5.0),
									child: showTutorial(snapshot.data[index])
								);
							},
						);
					} else if (snapshot.hasError) {
						return Center(
							child: Text("Failed: ${snapshot.error}", style: TextStyle(color: Colors.red)),
						);
					}

					return Center(
						child: CircularProgressIndicator()
					);
				}
			)
		);
	}

	static Widget showTutorial(Tutorial tutorial) {

		return Column(
			children: [
				Row(
					children: [
						Container(
							child: Image.network(tutorial.getImage),
							width: 300,
							height: 200,
						)
					],
					mainAxisAlignment: MainAxisAlignment.center
				),
				SizedBox(
					height: 20
				),
				Container(
					child: Text(tutorial.getContent)
				),
				FlatButton(
					child: Text("Перейти до відео"),
					textColor: Colors.white,
					shape: StadiumBorder(),
					color: Colors.green,
					onPressed: () {},
				),
				SizedBox(
					height: 10
				)
			],
		);
	}
}