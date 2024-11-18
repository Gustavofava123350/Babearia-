import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ellys/pages/reservation.dart';

class ServicesPages extends StatelessWidget {
  const ServicesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Serviços')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Olá Seja bem-vindo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(216, 216, 13, 1)),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('services').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var services = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        var service = services[index].data() as Map<String, dynamic>;
                        return ServiceTile(serviceName: service['name']);
                      },
                    );
                  },
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ReservationPage()),
                  );
                },
                child: const Text('Faça sua reserva agora'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String serviceName;

  const ServiceTile({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(serviceName),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selecionado: $serviceName')),
        );
      },
    );
  }
}
