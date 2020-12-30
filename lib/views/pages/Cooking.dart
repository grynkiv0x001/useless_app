/*
 * @Author: grynkiv0x001 
 * @Date: 2020-12-17 13:49:10 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:30:36
 * 
*/

import 'package:flutter/material.dart';

import 'package:casual_learning_app/configs/DatabaseConnector.dart';
import 'package:casual_learning_app/views/widgets/CLAListItem.dart';
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/models/Tutorial.dart';


class Cooking extends StatefulWidget {

	String category;

	Cooking(String category) {
		this.category = category;
	}

	@override
	State<StatefulWidget> createState() {

		return _CookingState(this.category);
	}
}

class _CookingState extends State<Cooking> {

	String category;

	_CookingState(String category) {
		this.category = category;
	}

	CLAListItem claListItem;

	@override
	Widget build(BuildContext context) {

		final GlobalKey starredState = GlobalKey();

		DatabaseConnector connector = DatabaseConnector();

		String _sql = "SELECT * FROM tutorials WHERE category = '${this.category}'";

		return Scaffold(
			appBar: CLAAppbar.customAppbar("Кулінарія"),
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
			bottomNavigationBar: BottomAppBar(
				child: IconButton(
					icon: Icon(Icons.filter_alt_outlined),
					onPressed: () {
						showDialog(context: context, child:
							AlertDialog(
								title: Text("Налаштування змісту"),
								content: Column(
									children: [
										SizedBox(
											height: 20
										),
										OutlineButton(
											child: Text("Бінарний пошук"),
											onPressed: () {},
										),
										SizedBox(
											height: 20
										),
										OutlineButton(
											child: Text("Сортування злиттям"),
											onPressed: () {},
										),
										SizedBox(
											height: 20
										),
										OutlineButton(
											child: Text("Жадібне сортування"),
											onPressed: () {},
										)
									]
								),
								contentPadding: EdgeInsets.all(0.0)
							)
						);
					}
				)
			)
		);
	}
}