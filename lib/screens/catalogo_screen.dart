import 'package:flutter/material.dart';
import 'package:lacazuela_mobile/services/catalogo_service.dart';
import 'package:lacazuela_mobile/widgets/data_table.dart';

class CatalogoScreen extends StatefulWidget {
  @override
  _CatalogoScreenState createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  List<Map<String, dynamic>> catalogos = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadCatalogos();
  }

  // Método para cargar los catálogos
  Future<void> _loadCatalogos() async {
    final result = await catalogoService.getCatalogos();
    if (result['status'] == 200) {
      setState(() {
        catalogos = List<Map<String, dynamic>>.from(result['data']);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = result['error']?['message'] ?? 'Error al cargar los catálogos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catálogos')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
              : DataTableWidget(
                  data: catalogos,
                  columns: [
                    {'header': 'ID', 'accessor': 'idCatalogo'},
                    {'header': 'Nombre', 'accessor': 'nombre'},
                    {'header': 'Descripción', 'accessor': 'descripcion'},
                    {'header': 'Estado', 'accessor': 'estaActivo'},
                  ],
                  renderActions: (item) {
                    return IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Lógica para editar el catálogo
                        print('Editando catálogo con ID: ${item['idCatalogo']}');
                      },
                    );
                  },
                ),
    );
  }
}
