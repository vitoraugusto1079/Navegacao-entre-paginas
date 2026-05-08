//Vítor Augusto - 08/05 -DVB
import 'package:flutter/material.dart';
import 'tela_detalhes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pirateflix',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const TelaPrincipal(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Filme {
  String nome;
  String descricao;
  String? caminhoImagem;

  Filme({required this.nome, required this.descricao, this.caminhoImagem});
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final List<Filme> _filmes = [];
  final _controllerNome = TextEditingController();
  final _controllerDescricao = TextEditingController();
  
  bool _isDark = false; 
  void _showMsg(String msg, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2), backgroundColor: cor),
    );
  }

  void _adicionarFilme() {
    if (_controllerNome.text.isEmpty || _controllerDescricao.text.isEmpty) {
      _showMsg('Preencha o nome e a descrição do filme!', Colors.red);
      return;
    }

    setState(() {
      _filmes.add(Filme(
        nome: _controllerNome.text,
        descricao: _controllerDescricao.text,
        caminhoImagem: Colors.primaries[_filmes.length % Colors.primaries.length].value.toString(),
      ));
      _controllerNome.clear();
      _controllerDescricao.clear();
    });
    _showMsg('Filme adicionado!', Colors.green);
  }

  @override
  void dispose() {
    _controllerNome.dispose();
    _controllerDescricao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final corFundo = _isDark ? Colors.grey[900]! : Colors.white;
    final corCard = _isDark ? Colors.grey[800] : Colors.white;
    final corTexto = _isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(
        title: const Text('Pirateflix'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => setState(() => _isDark = !_isDark),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Formulário
            Card(
              color: corCard,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controllerNome,
                      style: TextStyle(color: corTexto),
                      decoration: InputDecoration(labelText: 'Nome do filme', labelStyle: TextStyle(color: corTexto)),
                    ),
                    TextField(
                      controller: _controllerDescricao,
                      style: TextStyle(color: corTexto),
                      decoration: InputDecoration(labelText: 'Descrição', labelStyle: TextStyle(color: corTexto)),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed: _adicionarFilme,
                      icon: const Icon(Icons.add),
                      label: const Text('Adicionar Filme'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            Text(
              'Meus Filmes (${_filmes.length})',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: corTexto),
            ),
            const SizedBox(height: 10),
            
            Expanded(
              child: _filmes.isEmpty
                  ? Center(child: Text('Nenhum filme cadastrado.', style: TextStyle(color: corTexto)))
                  : ListView.builder(
                      itemCount: _filmes.length,
                      itemBuilder: (context, index) {
                        final filme = _filmes[index];
                        return Card(
                          color: corCard,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Color(int.parse(filme.caminhoImagem!)),
                              child: const Icon(Icons.movie, color: Colors.white),
                            ),
                            title: Text(filme.nome, style: TextStyle(color: corTexto, fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              filme.descricao,
                              style: TextStyle(color: corTexto.withOpacity(0.7)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis, 
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() => _filmes.removeAt(index));
                                _showMsg('Filme removido!', Colors.orange);
                              },
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TelaDetalhes(filme: filme, corFundoAtual: corFundo),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}