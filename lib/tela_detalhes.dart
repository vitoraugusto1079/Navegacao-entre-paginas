//Vítor Augusto - 08/05 -DVB
import 'package:flutter/material.dart';
import 'main.dart';

class TelaDetalhes extends StatelessWidget {
  final Filme filme;
  final Color corFundoAtual;

  const TelaDetalhes({super.key, required this.filme, required this.corFundoAtual});

  @override
  Widget build(BuildContext context) {
    final isDark = corFundoAtual != Colors.white;
    final corTexto = isDark ? Colors.white : Colors.black;
    final corCard = isDark ? Colors.grey[800] : Colors.white;

    Widget buildSection({required IconData icon, required String title, required Widget content}) {
      return Card(
        elevation: 4,
        color: corCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.blue, size: 24),
                  const SizedBox(width: 10),
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                ],
              ),
              const Divider(height: 20, thickness: 1.5, color: Colors.blue),
              content,
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: corFundoAtual,
      appBar: AppBar(
        title: Text(filme.nome),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Compartilhando ${filme.nome}...'), duration: const Duration(seconds: 1)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(int.parse(filme.caminhoImagem!)),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
              ),
              child: const Center(child: Icon(Icons.local_movies, size: 80, color: Colors.white70)),
            ),
            const SizedBox(height: 25),

            buildSection(
              icon: Icons.description,
              title: 'Sinopse',
              content: Text(filme.descricao, style: TextStyle(fontSize: 16, height: 1.5, color: corTexto)),
            ),
            const SizedBox(height: 20),

            buildSection(
              icon: Icons.info_outline,
              title: 'Informações Adicionais',
              content: Column(
                children: [
                  _buildInfoRow(Icons.star, 'Avaliação', '4.5/5', corTexto),
                  _buildInfoRow(Icons.calendar_today, 'Ano', '2024', corTexto),
                  _buildInfoRow(Icons.access_time, 'Duração', '2h 15min', corTexto),
                  _buildInfoRow(Icons.people, 'Diretor', 'C. Nolan', corTexto),
                  _buildInfoRow(Icons.category, 'Gênero', 'Ação/Drama', corTexto),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color textoCor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue[700]),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: TextStyle(fontSize: 14, color: textoCor.withOpacity(0.7)))),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textoCor)),
        ],
      ),
    );
  }
}