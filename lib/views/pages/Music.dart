/*
 * @Author: grynkiv0x001 
 * @Date: 2020-12-18 00:31:54 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:26:15
 * 
*/

import 'package:casual_learning_app/configs/Keys.dart';
import 'package:casual_learning_app/views/widgets/CLAListView.dart';
import 'package:flutter/material.dart';

import 'package:casual_learning_app/configs/DatabaseConnector.dart';
import 'package:casual_learning_app/views/widgets/CLAListItem.dart';
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/models/Tutorial.dart';


class Music extends StatefulWidget {

	String category;

	Music(String category) {
		this.category = category;
	}

	@override
	State<StatefulWidget> createState() {

		return _MusicState(this.category);
	}
}

class _MusicState extends State<Music> {

	String category;

	_MusicState(String category) {
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

	// #1 Quick Sort
	List<Tutorial> quickSort(List<Tutorial> list, int low, int high) {

		reallyGetMusicTuts("SELECT * FROM tutorials WHERE category = '${this.category}' ORDER BY duration ASC");

		if (low < high) {
			int pivot = partition(list, low, high);

			quickSort(list, low, pivot - 1);
			quickSort(list, pivot + 1, high);
		}

		return list;
	}

	int partition(List<Tutorial> list, int low, int high) {
		
		if (list.isEmpty)
			return 0;

		int pivot = list[high].getDuration;

		int i = low - 1;

		for (int j = low; j < high; j++) {

			if (list[j].getDuration < pivot) {
				i++;
				swap(list, i, j);
				print(list[j].getDuration);
			}
		}
		
		swap(list, i + 1, high);

		return i + 1;
	}

	void swap(List<Tutorial> list, int i, int j) {
		
		int temp = list[i].getDuration;

		list[i].duration = list[j].getDuration;
		list[j].duration = temp;
	}

	// #2 Insertion sort
	List<Tutorial> insertionSort(List<Tutorial> list, int length) {

		reallyGetMusicTuts("SELECT * FROM tutorials WHERE category = '${this.category}' ORDER BY starred ASC");
		
		for (int j = 1; j < length; j++) {

			int key = list[j].getStarred;

			int i = j - 1;

			while (i >= 0 && list[i].getStarred > key) {

				list[i + 1].starred = list[i].getStarred;
				i = i - 1;
			}

			list[i + 1].starred = key;

			print(key);
		}

		return list;
	}

	Tutorial linearSearch(int x) {

		reallyGetMusicTuts("SELECT * FROM tutorials WHERE duration = '$x'");
 		
		for(int i = 0; i < tuts.length; i++)
  	  		if(tuts[i].getStarred == x)
      			return tuts[i];

		return null;
  	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: CLAAppbar.customAppbar("Мистецтво"),
			body: claListView,
			bottomNavigationBar: ButtonBar(
				alignment: MainAxisAlignment.center,
				children: [
					RaisedButton(
						child: Text("Швидке сортування"),
						onPressed: () {
							quickSort(tuts, 0, tuts.length - 1);
						},
					),
					RaisedButton(
						child: Text("Вставками"),
						onPressed: () {
							insertionSort(tuts, tuts.length);
						},
					),
					RaisedButton(
						child: Text("Лінійний пошук"),
						onPressed: () {
							linearSearch(90);
						},
					)
				],
			),
		);
	}
}