import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'router/locations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) :super(key : key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'radish app',
      theme: ThemeData(
          primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              '당큰마켓 클론코딩',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            ),
          ),
        ),
        body: FutureBuilder(
            future: Future.delayed(Duration(seconds: 10), () => 100),
            builder: (context, snapshot) {
              return AnimatedSwitcher(
              duration: Duration(milliseconds: 900),
                child: _splashLodingWidget(snapshot),
              );
            }
            ),
      ),
    );

  }
  StatelessWidget _splashLodingWidget(AsyncSnapshot<Object> snapshot) {
    if (snapshot.hasError) {print('에러가 발생했습니다.');  return Text('error');}
    else if (snapshot.hasData) {return RadishApp();}
    else {return SplashScreen();}
  }
}

class RadishApp extends StatelessWidget {
  const RadishApp({Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    // beamer에게 모든 페이지 이동권한을 줌
    return MaterialApp.router(
      // 하위 서브 클래스들이 init을 할 수 있도록 해주는 역할
      routeInformationParser: BeamerParser(),
      // routerDelegate : 'beamer instance name' parser가 해석한 정보를 전달받을 객체
      routerDelegate: _routerDelegate,
    );
  }
}

final _routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      // beamLocations 는 Beamer에게 어떤 화면을 맡길지 알려주는 파라미터입니다.
      beamLocations: [HomeLocation()]
    )
);