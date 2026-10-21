// ============================================================
//  SESSION FOCUS: State Lifecycle & Navigation
// ============================================================
//  1. StatefulWidget lifecycle: initState, didChangeDependencies,
//     build, didUpdateWidget, setState, deactivate, dispose.
//     Notice WHEN each one runs (watch the console prints).
//
//  2. Navigator basics: push, pop, pushNamed.
//     Sending data to a screen, and returning data with pop.
//
//  3. go_router intro: context.go vs context.push,
//     and when to use each.
//
//  4. Why go_router: URL-based routing, named routing
//     path/query parameters(there is more to go in go_router in next section )

import 'package:flutter/material.dart';
import 'package:full_shopping_app_1/home_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      name: "homePage",
      path: "/home",
      builder: (context, state) {
        return HomePage(name: state.uri.queryParameters['name'] ?? "noName");
      },
    ),
    // go_router path parameter route: /profile/Atef
    // GoRoute(
    //   name: "profile",
    //   path: "/profile/:name",
    //   builder: (context, state) {
    //     return HomePage(name: state.pathParameters['name'] ?? "noName");
    //   },
    // ),
    GoRoute(path: "/", builder: (context, state) => LoginPage()),
  ],
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigator: MaterialApp with named routes (comment MaterialApp.router below)
    // return MaterialApp(
    //   title: "FullShoppingApp",
    //   home: LoginPage(),
    //   routes: {
    //     "/home": (context) => HomePage(
    //       name: ModalRoute.of(context)!.settings.arguments as String? ?? "noName",
    //     ),
    //   },
    // );

    return MaterialApp.router(title: "FullShoppingApp", routerConfig: _router);
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String welcomePage = "First time ? Welcome to our page ";

  // setState demo
  // int counter = 0;

  // Lifecycle: initState (runs once when the State is created)
  // @override
  // void initState() {
  //   super.initState();
  //   print("LoginPage: initState");
  // }

  // Lifecycle: didChangeDependencies (runs after initState and when inherited data changes)
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   print("LoginPage: didChangeDependencies");
  // }

  // Lifecycle: didUpdateWidget (runs when the parent rebuilds this widget with new data)
  // @override
  // void didUpdateWidget(covariant LoginPage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print("LoginPage: didUpdateWidget");
  // }

  // Lifecycle: deactivate (runs when the widget is removed from the tree)
  // @override
  // void deactivate() {
  //   print("LoginPage: deactivate");
  //   super.deactivate();
  // }

  // Lifecycle: dispose (runs once when the State is destroyed forever)
  // @override
  // void dispose() {
  //   print("LoginPage: dispose");
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // Lifecycle: build (runs first time and after every setState)
    // print("LoginPage: build");

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(welcomePage),
            // setState demo: counter
            // Text("counter = $counter"),
            // ElevatedButton(
            //   onPressed: () {
            //     setState(() {
            //       counter++;
            //     });
            //   },
            //   child: Text("Increase"),
            // ),
            // didUpdateWidget demo
            // LifecycleParent(),
            TextField(),
            TextField(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // welcomePage = await Navigator.of(
                  //   context,
                  // ).pushNamed();
                  // welcomePage =
                  //     await Navigator.of(context).pushNamed("/home") as String;
                  // setState(() {});

                  // Navigator.push: send data with constructor, receive data with await
                  // final String? pushResult = await Navigator.of(context).push<String>(
                  //   MaterialPageRoute(builder: (context) => HomePage(name: "Atef")),
                  // );
                  // if (pushResult != null) {
                  //   setState(() {
                  //     welcomePage = pushResult;
                  //   });
                  // }

                  // Navigator.pushNamed: send data with arguments, receive data with await
                  // final String? namedResult = await Navigator.of(
                  //   context,
                  // ).pushNamed<String>("/home", arguments: "Atef");
                  // if (namedResult != null) {
                  //   setState(() {
                  //     welcomePage = namedResult;
                  //   });
                  // }

                  // go_router context.go: replaces the stack (no back button, no result)
                  // context.go("/home?name=Atef");

                  // go_router context.push: keeps LoginPage in the stack, can await a result
                  // final String? goPushResult = await context.push<String>(
                  //   "/home?name=Atef",
                  // );
                  // if (goPushResult != null) {
                  //   setState(() {
                  //     welcomePage = goPushResult;
                  //   });
                  // }

                  // go_router path parameter: /profile/Atef
                  // context.goNamed("profile", pathParameters: {"name": "Atef"});

                  context.goNamed(
                    "homePage",
                    pathParameters: {},
                    queryParameters: {"name": "Atef"},
                  );
                },
                child: Text("Log in "),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// didUpdateWidget demo: parent calls setState and rebuilds child with new value
// class LifecycleParent extends StatefulWidget {
//   @override
//   State<LifecycleParent> createState() {
//     return LifecycleParentState();
//   }
// }
//
// class LifecycleParentState extends State<LifecycleParent> {
//   int value = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         LifecycleChild(value: value),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               value++;
//             });
//           },
//           child: Text("Update child"),
//         ),
//       ],
//     );
//   }
// }
//
// class LifecycleChild extends StatefulWidget {
//   final int value;
//
//   LifecycleChild({required this.value});
//
//   @override
//   State<LifecycleChild> createState() {
//     return LifecycleChildState();
//   }
// }
//
// class LifecycleChildState extends State<LifecycleChild> {
//   @override
//   void didUpdateWidget(covariant LifecycleChild oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     print("LifecycleChild: didUpdateWidget old=${oldWidget.value} new=${widget.value}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Text("child value = ${widget.value}");
//   }
// }
