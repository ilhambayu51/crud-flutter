import 'package:flutter/material.dart';
import 'package:uas_crud/sqlhelper.dart';

class MySecondPage extends StatefulWidget {
  const MySecondPage({super.key, required this.title});
  final String title;

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController prodiController = TextEditingController();
  TextEditingController nilaiUtsController = TextEditingController();

  @override
  void initState() {
    refreshnilai();
    super.initState();
  }

  //get data
  List<Map<String, dynamic>> nilaiutsmhs = [];

  void refreshnilai() async {
    final data = await SQLHelperSec.getNilaiUtsMhs();
    setState(() {
      nilaiutsmhs = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(nilaiutsmhs);
    return Scaffold(
      body: ListView.builder(
        itemCount: nilaiutsmhs.length,
        itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.all(15),
        child: ListTile(
          title: Text(nilaiutsmhs[index]['nama']),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nilaiutsmhs[index]['nim']),
                Text(nilaiutsmhs[index]['prodi']),
                Text(nilaiutsmhs[index]['nilaiUts']),
              ],
            ),
          trailing: SizedBox(width: 100, 
            child: Row(
              children: [
                IconButton(
                  onPressed: () => modalForm(nilaiutsmhs[index]['id']), 
                  icon: const Icon(Icons.edit)
                ),
                IconButton(
                   icon: Icon(Icons.delete),
                   onPressed: () => deleteNilai(nilaiutsmhs[index]['id'])
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
    await SQLHelperSec.inputNilai(
      namaController.text, nimController.text, prodiController.text, nilaiUtsController.text
    );
    refreshnilai();
  }

  //update data
  Future<void> updateNilai(int id) async {
    await SQLHelperSec.updateNilai(
      id, namaController.text, nimController.text, prodiController.text, nilaiUtsController.text
    );
    refreshnilai();
  }

  //delete data
  Future<void> deleteNilai(int id) async {
    await SQLHelperSec.deleteNilai(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success Delete Data")));
    refreshnilai();
  }

  void modalForm(int? id) async {
    if(id != null) {
      final datanilai = nilaiutsmhs.firstWhere((element) => element['id'] == id);
      namaController.text = datanilai['nama'];
      nimController.text = datanilai['nim'];
      prodiController.text = datanilai['prodi'];
      nilaiUtsController.text = datanilai['nilaiUts'];
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
          controller: nilaiUtsController,
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
          nilaiUtsController.text = '';
          Navigator.pop(context);
        },
        child: Text(id == null ? 'tambah' : 'udpate'))
      ],
      ),
      ),
    ));
  }
}
