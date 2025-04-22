import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),

        title: const Text('Início', 
        style: TextStyle(color: Colors.white)),

        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
                  "lib/views/assets/logo.png",
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundColor: Colors.white, 
            child: Icon(Icons.person, 
            color: Colors.black)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("HOME", style: TextStyle(fontSize: 22, 
            fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFBBDEFB),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    _buildGridButton(context, Icons.task_alt, "Tarefas", "/tarefas"),
                    _buildGridButton(context, Icons.person_add, "Cadastro", "/cadastro"),
                    _buildGridButton(context, Icons.settings, "Configurações", null),
                    _buildGridButton(context, Icons.person_pin_circle_rounded, "Sobre", null),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1565C0),
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.refresh), label: 'Recarregar'),
        ],
        onTap: (index) {
          if (index == 1) Navigator.pushReplacementNamed(context, '/');
        },
      ),
    );
  }

  Widget _buildGridButton(BuildContext context, IconData icon, String label, String? route) {
    return InkWell(
      onTap: route != null ? () => Navigator.pushNamed(context, route) : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF1565C0)),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
