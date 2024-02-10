// ignore_for_file: must_call_super, avoid_print, use_build_context_synchronously, unnecessary_null_comparison, unused_element, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:uas_crud/sqlhelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD SQL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CRUD SQL'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController prodiController = TextEditingController();
  TextEditingController nilaiUasController = TextEditingController();

  @override
  void initState() {
    refreshnilai();
    super.initState();
  }

  //get data
  List<Map<String, dynamic>> nilaimhs = [];

  void refreshnilai() async {
    final data = await SQLHelper.getNilaiMhs();
    setState(() {
      nilaimhs = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(nilaimhs);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: nilaimhs.length,
        itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.all(15),
        child: ListTile(
          title: Text(nilaimhs[index]['nama']),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nilaimhs[index]['nim']),
                Text(nilaimhs[index]['prodi']),
                Text(nilaimhs[index]['nilaiUas']),
              ],
            ),
          trailing: SizedBox(width: 100, 
            child: Row(
              children: [
                IconButton(
                  onPressed: () => modalForm(nilaimhs[index]['id']), 
                  icon: const Icon(Icons.edit)
                ),
                IconButton(
                   icon: Icon(Icons.delete),
                   onPressed: () => deleteNilai(nilaimhs[index]['id'])
                ),
              ],
            )
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modalForm(null);
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //input data
  Future<void> tambahNilai() async {
    await SQLHelper.inputNilai(
      namaController.text, nimController.text, prodiController.text, nilaiUasController.text
    );
    refreshnilai();
  }

  //update data
  Future<void> updateNilai(int id) async {
    await SQLHelper.updateNilai(
      id, namaController.text, nimController.text, prodiController.text, nilaiUasController.text
    );
    refreshnilai();
  }

  //delete data
  Future<void> deleteNilai(int id) async {
    await SQLHelper.deleteNilai(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success Delete Data")));
    refreshnilai();
  }

  void modalForm(int? id) async {
    if(id != null) {
      final datanilai = nilaimhs.firstWhere((element) => element['id'] == id);
      namaController.text = datanilai['nama'];
      nimController.text = datanilai['nim'];
      prodiController.text = datanilai['prodi'];
      nilaiUasController.text = datanilai['nilaiUas'];
    }
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      height: 800,
      child: SingleChildScrollView(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        TextField(
          controller: namaController,
          decoration: const InputDecoration(hintText: 'Nama'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: nimController,
          decoration: const InputDecoration(hintText: 'NIM'),
        ),const SizedBox(
          height: 10,
        ),
        TextField(
          controller: prodiController,
          decoration: const InputDecoration(hintText: 'Prodi'),
        ),const SizedBox(
          height: 10,
        ),
        TextField(
          controller: nilaiUasController,
          decoration: const InputDecoration(hintText: 'Nilai Uas'),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            if (id == null) {
          await tambahNilai();
            } else {
              await updateNilai(id);
            }
          namaController.text = '';
          nimController.text = '';
          prodiController.text = '';
          nilaiUasController.text = '';
          Navigator.pop(context);
        },
        child: Text(id == null ? 'tambah' : 'udpate'))
      ],
      ),
      ),
    ));
  }

}
