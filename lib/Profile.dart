import 'package:flutter/material.dart';


class Profile extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: PreferredSize(
				preferredSize: Size.fromHeight(50),
				child: AppBar(
					title: Text("Good morning!", style: TextStyle(color: Colors.black54)),
					leading: Builder(
						builder: (BuildContext context) {
							return IconButton(
								icon: Icon(Icons.exit_to_app, color: Colors.black54, size: 24),
								onPressed: () { print("Logout from profile"); },
							);
						}
					),
					centerTitle: true,
					actions: [
						Padding(
							padding: EdgeInsets.only(right: 20.0),
							child: GestureDetector(
								onTap: () {},
								child: Icon(
									Icons.settings,
									size: 24,
									color: Colors.black54,
								),
								// onTapDown: () {print("Setting clicked");},
							),
						),
					],
					backgroundColor: Colors.transparent,
					elevation: 0,
				),
			),
			body: Column(
				crossAxisAlignment: CrossAxisAlignment.center,
				children: [
					SizedBox(
						height: 10
					),
					Center(
						child: Container(
							child: ClipRRect(
								borderRadius: BorderRadius.circular(300.0),
								child: Image.network("https://img.freepik.com/free-photo/handsome-young-businessman-shirt-eyeglasses_85574-6228.jpg?size=626&ext=jpg", height: 150, width: 150),
							),
							decoration: BoxDecoration(
								boxShadow: [
									BoxShadow(
										color: Colors.black38,
										spreadRadius: 3,
										blurRadius: 7,
										offset: Offset(0, 3)
									)
								],
								shape: BoxShape.circle
							),
						),
						
					),
					SizedBox(
						height: 30
					),
					Center(
						child: Text(
							"Hello, World!",
							style: TextStyle(
								fontSize: 22,
								fontWeight: FontWeight.bold
							),
						),
					),
					SizedBox(height: 10),
					Center(
						child: Text(
							"Another text, but a lot smaller",
							style: TextStyle(
								fontSize: 14,
							),
						),
					),
					SizedBox(height: 20),
					Center(
						child:
							RaisedButton(
								onPressed: () {},
								child: SizedBox(
									width: 200,
									child: Text(
										"Statistics",
										style: TextStyle(
											fontSize: 20
										),
										textAlign: TextAlign.center,
									),
								),
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(15.0)
								),
								color: Colors.amber[300],
							),
					),
					SizedBox(height: 10),
					Center(
						child:
							RaisedButton(
								onPressed: () {},
								child: SizedBox(
									width: 200,
									child: Text(
										"Something else",
										style: TextStyle(
											fontSize: 20
										),
										textAlign: TextAlign.center,
									),
								),
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(15.0)
								),
								color: Colors.amber[300],
							),
					),
					SizedBox(height: 10),
					Center(
						child:
							RaisedButton(
								onPressed: () {},
								child: SizedBox(
									width: 200,
									child: Text(
										"Another one",
										style: TextStyle(
											fontSize: 20
										),
										textAlign: TextAlign.center,
									),
								),
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(15.0)
								),
								color: Colors.amber[300],
							),
					),
					SizedBox(height: 10),
					Center(
						child:
							RaisedButton(
								onPressed: () {},
								child: SizedBox(
									width: 200,
									child: Text(
										"Finally last",
										style: TextStyle(
											fontSize: 20
										),
										textAlign: TextAlign.center,
									),
								),
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(15.0)
								),
								color: Colors.amber[300],
							),
					)
				],
			),
			// margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
		);
	}
}