import 'package:lacazuela_mobile/api/api.dart';
import 'package:lacazuela_mobile/helpers/handle_request.dart';

class CatalogoService {
  Future<Map<String, dynamic>> getCatalogos() async {
    return await HandleRequest.request(() => api.get('/Catalogo'));
  }

  Future<Map<String, dynamic>> createCatalogo(Map<String, dynamic> catalogo) async {
    return await HandleRequest.request(() => api.post('/Catalogo', data: catalogo));
  }
}

final catalogoService = CatalogoService();
