import 'package:animation/bezier.dart';
import 'package:animation/clap.dart';
import 'package:animation/like.dart';
import 'package:animation/pie.dart';
import 'package:animation/translate.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Anim Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      onGenerateRoute: (RouteSettings settings) {
        String name = settings.name;
        Function routeBuilder = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => AnimationPage(
            title: name,
            builder: routeBuilder,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, Function> routes = {
    'Like animation': (context) => Like(),
    'Clap animation': (context) => Clap(),
    'Pie animation': (context) => TestPie(),
    'Transition animation': (context) => Transition(),
    'Bezier animation': (context) => Bezier(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Anim Demo'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          String route = routes.keys.toList()[index];
          String pageName = routes.keys.toList()[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, route, arguments: routes[route]);
            },
            title: Text(
              pageName,
              style: TextStyle(fontSize: 20.0),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: routes.length,
      ),
    );
  }
}

class AnimationPage extends StatelessWidget {
  AnimationPage({Key key, this.title, this.builder}) : super(key: key);

  final String title;
  final Function builder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: builder(context),
    );
  }
}
