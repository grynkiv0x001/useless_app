/*
 * @Author: grynkiv0x001 
 * @Date: 2020-12-17 13:37:58 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:28:18
 * 
*/

import 'dart:math';

import 'package:casual_learning_app/views/widgets/CLAListView.dart';
import 'package:flutter/material.dart';

import 'package:casual_learning_app/configs/DatabaseConnector.dart';
import 'package:casual_learning_app/views/widgets/CLAListItem.dart';
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/models/Tutorial.dart';


class IT extends StatefulWidget {

	String category;

	IT(String category) {
		this.category = category;
	}

	@override
	State<StatefulWidget> createState() {

		return _ITState(this.category);
	}
}

class _ITState extends State<IT> {

	String category;

	_ITState(String category) {
		this.category = category;
	}
	
	CLAListItem claListItem;
	CLAListView claListView;

	List<Tutorial> tuts = List<Tutorial>();

	Future<List<Tutorial>> getAllMusicTutorials(String sql) async {

		DatabaseConnector connector = DatabaseConnector();

		List<Tutorial> tutorials = await connector.tutorials(sql);

		return tutorials;
	}

	void reallyGetMusicTuts(String sql) async {

		var tmp = await getAllMusicTutorials(sql);

		setState(() {
			tuts = tmp;
			claListView = CLAListView(tuts);
		});
	}

	// #1 Insertion sort
	List<Tutorial> insertionSort(List<Tutorial> list, int length) {

		reallyGetMusicTuts("SELECT * FROM tutorials WHERE category = '${this.category}' ORDER BY duration ASC");
		
		for (int j = 1; j < length; j++) {

			int key = list[j].getDuration;

			int i = j - 1;

			while (i >= 0 && list[i].getDuration > key) {

				list[i + 1].duration = list[i].getDuration;
				i = i - 1;
			}

			list[i + 1].duration = key;
		}

		return list;
	}

	// #2 Bubble sort
	List<Tutorial> bubbleSort(List<Tutorial> list) {

		reallyGetMusicTuts("SELECT * FROM tutorials WHERE category = '${this.category}' ORDER BY title ASC");

		int length = list.length;

		for (int i = 0; i < length - 1; i++) {

			for (int ii = 0; ii < length - i - 1; ii++) {

				if (list[ii].getTitle.compareTo(list[ii + 1].getTitle) != null) {

					int temp = list[ii].getStarred;

					list[ii].starred = list[ii + 1].getStarred;
					list[ii + 1].starred = temp;
				}
			}
		}

		return list;
	}

	// #3 Jump Search
	Tutorial jumpSearch(List<Tutorial> list, int stars) {

		reallyGetMusicTuts("SELECT * FROM tutorials WHERE category = '${this.category} ORDER BY DESC'");

		int n = list.length;

		int step = sqrt(n).toInt();

		int prev = 0;

		while (list[min(step, n) - 1].getStarred < stars) {

			prev = step;

			step += sqrt(n).toInt();

			if (prev >= n)
				return null;
		}

		while (list[prev].getStarred < stars) {

			prev++;

			if (prev == min(step, n)) {
				return null;
			}
		}

		if (list[prev].getStarred == stars)
			return list[prev];

		return null;
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: CLAAppbar.customAppbar("ІТ: для хобі та роботи"),
			body: claListView,
			bottomSheet: Row(
				children: [
					Text("Сортування за часом/назвою та пошук за відстеженнями"),
				],
				mainAxisAlignment: MainAxisAlignment.center
			),
			bottomNavigationBar: ButtonBar(
				alignment: MainAxisAlignment.spaceBetween,
				children: [
					RaisedButton(
						child: Text("Вибором"),
						shape: StadiumBorder(),
						color: Colors.indigo,
						onPressed: () {
							claListView = null;
							setState(() => insertionSort(tuts, tuts.length));
						},
					),
					RaisedButton(
						child: Text("Бульбашкове"),
						shape: StadiumBorder(),
						color: Colors.indigo,
						onPressed: () {
							claListView = null;
							setState(() => bubbleSort(tuts));
						},
					),
					RaisedButton(
						child: Text("Пошук стрибками"),
						shape: StadiumBorder(),
						color: Colors.indigo,
						onPressed: () {
							claListView = null;
							setState(() => jumpSearch(tuts, 0));
						},
					)
				],
			),
		);
	}
}