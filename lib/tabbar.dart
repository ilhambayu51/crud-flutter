// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:uas_crud/tabdua.dart';
import 'package:uas_crud/tabsatu.dart';
import 'package:uas_crud/sqlhelper.dart';

class tabBarMain extends StatefulWidget {
  const tabBarMain({Key? key}) : super(key: key);

  @override
  _tabBarMainState createState() => _tabBarMainState(); 
}

class _tabBarMainState extends State<tabBarMain>
  with SingleTickerProviderStateMixin{
    late TabController controller;

    @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('CRUD SQL'),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: controller,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          tabs: const <Widget>[
            Tab(
              text: 'Nilai UAS',
              icon: Icon(Icons.task_outlined),
              ),
            Tab(
              text: 'Nilai UTS',
              icon: Icon(Icons.task_outlined),
              ),
          ]),
      ),
      body: TabBarView(
        controller: controller,
        children: const <Widget> [MyHomePage(title: 'CRUD SQL'), MySecondPage(title: 'CRUD SQL')],
      ),
    );
  }
}