/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-30 09:04:06 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:54:47
 * 
*/

import 'package:casual_learning_app/configs/CLATheme.dart';
import 'package:casual_learning_app/configs/Keys.dart';
import 'package:casual_learning_app/views/pages/TutorialPage.dart';
import "package:flutter/material.dart";

import 'package:casual_learning_app/models/Tutorial.dart';


class CLAListItem extends StatefulWidget {

	Tutorial _tutorial;

	CLAListItem(Tutorial tutorial) {
		this._tutorial = tutorial;
	}

	@override
	State<StatefulWidget> createState() {

		return _CLAListItemState(this._tutorial);
	}
}

class _CLAListItemState extends State<CLAListItem> {

	Tutorial _tutorial;

	Color _starColor = Colors.white;
	Color _starredColor = Colors.yellowAccent;

	Icon _star = Icon(Icons.star_outline);
	Icon _starred = Icon(Icons.star);

	bool isStarred = false;

	_CLAListItemState(Tutorial tutorial) {
		this._tutorial = tutorial;
	}

	@override
	Widget build(BuildContext context) {

		return customListItem(this._tutorial);
	}

	Widget customListItem(Tutorial tutorial) {

		return Container(
			child: ListTile(
				leading: CircleAvatar(
					radius: 20,
					backgroundColor: Colors.black87,
					backgroundImage: NetworkImage(tutorial.getImage)
				),
				title: Text(
					tutorial.getTitle,
					style: TextStyle(
						color: Colors.white
					),
				),
				subtitle: Text(
					"Потрібний час: ${(_tutorial.getDuration / 60).toStringAsFixed(1)} год.",
					style: TextStyle(
						color: Colors.white
					),
					maxLines: 1,
				),
				isThreeLine: false,
				tileColor: CLATheme.primaryColor,
				trailing: IconButton(
					icon: !isStarred ? _star : _starred,
					color: !isStarred ? _starColor : _starredColor,
					onPressed: () {
						setState(() {
							isStarred = !isStarred;
							if (isStarred)
								tutorial.starred = tutorial.getStarred + 1;
							else
								tutorial.starred = tutorial.getStarred - 1;
						});
					}
				),
				onTap: () {
					Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => TutorialPage(tutorial.getId, tutorial.getTitle)));
				},
			)
		);
	}
}