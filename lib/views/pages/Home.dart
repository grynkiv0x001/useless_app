/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-29 19:14:17 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:41:55
 * 
*/

import 'package:flutter/material.dart';

import 'package:casual_learning_app/configs/DatabaseConnector.dart';
import 'package:casual_learning_app/views/widgets/CLAListItem.dart';
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/models/Tutorial.dart';


class Home extends StatefulWidget {

	@override
	State<StatefulWidget> createState() {

		return _HomeState();
	}
}

class _HomeState extends State<Home> {

	String _sql = "SELECT * FROM tutorials";

	CLAListItem claListItem;
	
	@override
	Widget build(BuildContext context) {

		final GlobalKey starredState = GlobalKey();

		DatabaseConnector connector = DatabaseConnector();

		return Scaffold(
			appBar: CLAAppbar.customAppbar("Найголовніше"),
			body: FutureBuilder<List<Tutorial>>(
				future: connector.tutorials(_sql),
				initialData: List(),
				builder: (BuildContext context, AsyncSnapshot<List<Tutorial>> snapshot) {
					if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
						return ListView.builder(
							padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
							itemCount: snapshot.data.length,
							itemBuilder: (context, index) {
								claListItem = CLAListItem(snapshot.data[index]);
								return Container(
									padding: EdgeInsets.only(top: 5.0),
									child: claListItem
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
			),
		);
	}
}