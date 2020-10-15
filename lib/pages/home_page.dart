
import 'package:catalogocarros/domain/carro.dart';
import 'package:catalogocarros/drawer_list.dart';
import 'package:catalogocarros/pages/carro_form_page.dart';
import 'package:catalogocarros/pages/carros_page.dart';
import 'package:catalogocarros/pages/favoritos_page.dart';
import 'package:catalogocarros/search/carros_sarch.dart';
import 'package:catalogocarros/utils/alerts.dart';
import 'package:catalogocarros/utils/nav.dart';
import 'package:catalogocarros/utils/prefs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController tabController;

  @override
  initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);

    Prefs.getInt("tabIndex").then((idx) {
      tabController.index = idx;
    });

    tabController.addListener(() async {
      int idx = tabController.index;

      Prefs.setInt("tabIndex", idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _onClickSearch,
          )
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: "Clássicos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Esportivos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Luxo",
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: "Favoritos",
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CarrosPage(TipoCarro.classicos),
          CarrosPage(TipoCarro.esportivos),
          CarrosPage(TipoCarro.luxo),
          FavoritosPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _onClickAdd();
        },
      ),
      drawer: DrawerList(),
    );
  }

  void _onClickSearch() async {
    final carro = await showSearch<Carro>(
        context: context, delegate: CarrosSearch());
    if (carro != null) {
      alert(context, "Busca", carro.nome);
    }
  }

  void _onClickAdd() async {
    push(context, CarroFormPage());
  }

  @override
  void dispose() {
    super.dispose();

    //eventBus.close();
  }
}