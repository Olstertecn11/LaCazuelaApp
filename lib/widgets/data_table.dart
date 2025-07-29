import 'package:flutter/material.dart';

class DataTableWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final List<Map<String, dynamic>> columns;
  final List<int> pageSizeOptions;
  final int defaultPageSize;
  final Function(Map<String, dynamic>)? renderActions;
  final String title;
  final Color colorScheme;

  DataTableWidget({
    required this.data,
    required this.columns,
    this.pageSizeOptions = const [5, 10, 15],
    this.defaultPageSize = 5,
    this.renderActions,
    this.title = 'DataTable',
    this.colorScheme = Colors.yellow,
  });

  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  int currentPage = 1;
  int itemsPerPage = 5;

  // Calcular los items a mostrar según la página actual
  List<Map<String, dynamic>> get currentItems {
    final indexOfLastItem = currentPage * itemsPerPage;
    final indexOfFirstItem = indexOfLastItem - itemsPerPage;
    return widget.data.sublist(indexOfFirstItem, indexOfLastItem);
  }

  // Total de páginas
  int get totalPages {
    return (widget.data.length / itemsPerPage).ceil();
  }

  // Función para cambiar la página
  void paginate(int pageNumber) {
    setState(() {
      currentPage = pageNumber.clamp(1, totalPages); // Asegura que el número de página esté dentro de los límites
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: widget.colorScheme.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: widget.colorScheme),
            ),
          ),
          // Selector de tamaño de página
          Row(
            children: [
              Text('Items por página: '),
              DropdownButton<int>(
                value: itemsPerPage,
                items: widget.pageSizeOptions.map((size) {
                  return DropdownMenuItem<int>(
                    value: size,
                    child: Text(size.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    itemsPerPage = value!;
                    currentPage = 1; // Resetear a la primera página
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          // Tabla
          DataTable(
            columns: widget.columns
                .map(
                  (col) => DataColumn(label: Text(col['header'])),
                )
                .toList(),
            rows: currentItems.map((item) {
              return DataRow(
                cells: widget.columns.map((col) {
                  return DataCell(
                    Text(
                      col['render'] != null
                          ? col['render'](item[col['accessor']], item).toString()
                          : item[col['accessor']].toString(),
                    ),
                  );
                }).toList()
                  ..add(
                    DataCell(
                      widget.renderActions != null
                          ? Row(
                              children: [
                                widget.renderActions!(item),
                              ],
                            )
                          : Container(),
                    ),
                  ),
              );
            }).toList(),
          ),
          // Paginación
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: currentPage > 1
                    ? () => paginate(currentPage - 1)
                    : null,
              ),
              Text('$currentPage / $totalPages'),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: currentPage < totalPages
                    ? () => paginate(currentPage + 1)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
