import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoFullscreenDialogTransitionPage(),
    );
  }
}

//First Page
class CupertinoFullscreenDialogTransitionPage extends StatefulWidget {
  const CupertinoFullscreenDialogTransitionPage({super.key});

  @override
  _CupertinoFullscreenDialogTransitionState createState() =>
      _CupertinoFullscreenDialogTransitionState();
}

class _CupertinoFullscreenDialogTransitionState
    extends State<CupertinoFullscreenDialogTransitionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Cupertino Screen Transition",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, _, __) {
                  return const FullDialogPage();
                },
              ),
            ),
            child: Container(
              height: 35,
              width: MediaQuery.of(context).size.width/1.5,
              padding: const EdgeInsets.only(left: 10,right: 10),
              alignment: Alignment.center,
                decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(50)
              ),
              child: const Text(
                "Next Page Cupertino Transition",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

//Second Page
class FullDialogPage extends StatefulWidget {
  const FullDialogPage({super.key});

  @override
  _FullDialogPageState createState() => _FullDialogPageState();
}

class _FullDialogPageState extends State<FullDialogPage>
    with TickerProviderStateMixin {
  late AnimationController _primary, _secondary;
  late Animation<double> _animationPrimary, _animationSecondary;

  @override
  void initState() {
    //Primaty
    _primary = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationPrimary = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _primary, curve: Curves.easeOut));
    //Secondary
    _secondary =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationSecondary = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _secondary, curve: Curves.easeOut));
    _primary.forward();
    super.initState();
  }

  @override
  void dispose() {
    _primary.dispose();
    _secondary.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoFullscreenDialogTransition(
      primaryRouteAnimation: _animationPrimary,
      secondaryRouteAnimation: _animationSecondary,
      linearTransition: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Colors.green,
            title: const Text("Successoft Infotech",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _primary.reverse();
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.of(context).pop();
                });
              },
            ),
          ),
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              _primary.reverse();
                Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pop();
              });
            },
            child: Container(
              height: 35,
              width: 120,
              alignment: Alignment.center,
                decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(50)
              ),
              child: const Text(
                "Go Back!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}