import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Needed only if you use Navigator.push to LoginPage below
// import 'package:full_shopping_app_1/main.dart';

class HomePage extends StatefulWidget {
  String name;

  HomePage({required this.name});

  @override
  State<HomePage> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  // Lifecycle: initState (runs once when the State is created)
  // @override
  // void initState() {
  //   super.initState();
  //   print("HomePage: initState");
  // }

  // Lifecycle: didChangeDependencies (runs after initState and when inherited data changes)
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   print("HomePage: didChangeDependencies");
  // }

  // Lifecycle: didUpdateWidget (runs when the parent rebuilds this widget with new data)
  // @override
  // void didUpdateWidget(covariant HomePage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print("HomePage: didUpdateWidget");
  // }

  // Lifecycle: deactivate (runs when the widget is removed from the tree)
  // @override
  // void deactivate() {
  //   print("HomePage: deactivate");
  //   super.deactivate();
  // }

  // Lifecycle: dispose (runs once when the State is destroyed forever)
  // @override
  // void dispose() {
  //   print("HomePage: dispose");
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // Lifecycle: build (runs first time and after every setState)
    // print("HomePage: build");

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LoginPage() ));
            // Navigator.of(context).pop("Welcome again , Atef");

            // Navigator.pop: return data to the previous screen (use with Navigator.push / pushNamed)
            // Navigator.of(context).pop("Welcome again , ${widget.name}");

            // go_router context.pop: return data (use only when page was opened with context.push)
            // context.pop("Welcome again , ${widget.name}");

            context.go("/");
          },
          child: Text("we are in home ${widget.name} "),
        ),
      ),
    );
  }
}
