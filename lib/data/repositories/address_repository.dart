import '../../core/client.dart';
import '../../core/utils/result.dart';
import '../models/address_model.dart';

class AddressRepository {
  final ApiClient _client;

  AddressRepository({required ApiClient client}) : _client = client;

  Future<Result<List<AddressModel>>> getAddresses() async {
    final result = await _client.get<List<dynamic>>('/addresses/list');

    return result.fold(
          (error) => Result.error(error),
          (value) => Result.ok(
        value.map((e) => AddressModel.fromJson(e)).toList(),
      ),
    );
  }
}