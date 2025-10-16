import '../../core/client.dart';
import '../../core/utils/result.dart';
import '../models/address_model.dart';

class AddressRepository {
  final ApiClient _client;

  AddressRepository({required ApiClient client}) : _client = client;

  Future<Result<List<AddressModel>>> getAddresses() async {
    final result = await _client.get<List<dynamic>>('/addresses');

    return result.fold(
      (error) => Result.error(error),
      (value) => Result.ok(
        value.map((e) => AddressModel.fromJson(e)).toList(),
      ),
    );
  }

  Future<Result<AddressModel>> saveAddress(AddressModel address) async {
    final Map<String, dynamic> dataToSend = address.toJson();

    final result = await _client.post<Map<String, dynamic>>(
      '/addresses',
      data: dataToSend,
    );

    return result.fold(
      (error) => Result.error(error),
      (value) => Result.ok(AddressModel.fromJson(value)),
    );
  }

  Future<Result<void>> deleteAddress(int id) async {
    final result = await _client.delete('/addresses/$id');

    return result.fold(
      (error) => Result.error(error),
      (_) => const Result.ok(null),
    );
  }
}
