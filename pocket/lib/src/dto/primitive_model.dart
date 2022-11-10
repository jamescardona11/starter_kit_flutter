import 'i_pocket_model.dart';

class PrimitiveModel<D> extends IPocketModel {
  PrimitiveModel(this.id, this.data);

  @override
  final String id;

  final D data;

  @override
  Map<String, dynamic> toJson() => {id: data};
}
