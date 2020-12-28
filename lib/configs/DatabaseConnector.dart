/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-29 18:52:30 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-17 04:50:19
 * 
*/

import "dart:async";

import "package:postgres/postgres.dart";

import "package:casual_learning_app/models/User.dart";
import "package:casual_learning_app/models/Tutorial.dart";


class DatabaseConnector {

	var _connection = PostgreSQLConnection("ec2-3-208-224-152.compute-1.amazonaws.com",
											5432, "d95rg60v36qbt",
											username: "gworowbzfbayzp", 
											password: "653ab130471ea886f24d44503be6b8f010548c1cf43e7d00d637a72691b08d9d",
											useSSL: true);

	DatabaseConnector();

	Future<List<User>> users(String strQuery) async {

		await _connection.open();

		var query = await _connection.query(strQuery);

		List<User> list = List<User>();

		for (int i = 0; i < query.length; i++) {
			list.add(User(int.parse(query[i][0].toString()), query[i][1].toString(), query[i][2].toString(), query[i][3].toString(), int.parse(query[i][4].toString()), int.parse(query[i][5].toString())));
		}

		// await _connection.close();

		return list;
	}

	Future<List<Tutorial>> tutorials(String strQuery) async {

		await _connection.open();

		var query = await _connection.query(strQuery);

		List<Tutorial> list = List<Tutorial>();

		for (int i = 0; i < query.length; i++) {
			list.add(Tutorial(
				int.parse(query[i][0].toString()),
				query[i][1].toString(),
				query[i][2].toString(),
				int.parse(query[i][3].toString()),
				query[i][4].toString(),
				int.parse(query[i][5].toString()),
				int.parse(query[i][6].toString()),
				query[i][7].toString()
			));
		}

		await _connection.close();

		return list;
	}
}