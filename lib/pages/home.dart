import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ellys/pages/services.dart';

class HOMEPage extends StatefulWidget {
  const HOMEPage({super.key});

  @override
  _HOMEPageState createState() => _HOMEPageState();
}

class _HOMEPageState extends State<HOMEPage> {
  // Função para buscar dados do Firestore
  Future<void> _fetchData() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('reservations');
    QuerySnapshot querySnapshot = await collection.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData); // Apenas para depuração
  }

  @override
  void initState() {
    super.initState();
    _fetchData(); // Chama a função para buscar dados ao inicializar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/wallpaper.jpg'), // Certifique-se de que o caminho está correto
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ELLYS BARBEARIA',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ServicesPages()),
                  );
                },
                child: const Text('Obtenha um corte com estilo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
