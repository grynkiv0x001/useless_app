/*
 * @Author: grynkiv0x001 
 * @Date: 2020-12-18 01:36:04 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:29:34
 * 
*/

import 'package:flutter/material.dart';

import 'package:casual_learning_app/configs/DatabaseConnector.dart';
import 'package:casual_learning_app/views/widgets/CLAListItem.dart';
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/models/Tutorial.dart';


class Founded extends StatefulWidget {

	String query;

	Founded(String category) {
		this.query = category;
	}

	@override
	State<StatefulWidget> createState() {

		return _FoundedState(this.query);
	}
}

class _FoundedState extends State<Founded> {

	String query;

	_FoundedState(String query) {
		this.query = query;
	}

	CLAListItem claListItem;

	@override
	Widget build(BuildContext context) {

		final GlobalKey starredState = GlobalKey();

		DatabaseConnector connector = DatabaseConnector();

		String _sql = "SELECT * FROM tutorials";

		return Scaffold(
			appBar: CLAAppbar.customAppbar("Результати пошуку"),
			body: FutureBuilder<List<Tutorial>>(
				future: connector.tutorials(_sql),
				initialData: List(),
				builder: (BuildContext context, AsyncSnapshot<List<Tutorial>> snapshot) {
					if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
						return ListView.builder(
							padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
							itemCount: snapshot.data.length,
							itemBuilder: (context, index) {
								if (snapshot.data[index].getTitle.contains(this.query)) {
									claListItem = CLAListItem(snapshot.data[index]);
									return Container(
										padding: EdgeInsets.only(top: 5.0),
										child: claListItem
									);
								}

								return SizedBox();
							}
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
}