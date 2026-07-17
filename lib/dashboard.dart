
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
	const Dashboard({Key? key}) : super(key: key);

	@override
	_DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
	int _counter = 0;

	void _increment() {
		setState(() {
			_counter++;
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Dashboard'),
			),
			body: Center(
				child: Column(
					mainAxisSize: MainAxisSize.min,
					children: [
						const Text('You have pushed the button this many times:'),
						Text('$_counter', style: Theme.of(context).textTheme.headline4),
					],
				),
			),
			floatingActionButton: FloatingActionButton(
				onPressed: _increment,
				child: const Icon(Icons.add),
			),
		);
	}
}
