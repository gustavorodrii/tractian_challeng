class CompanyModel {
  String id;
  String name;

  CompanyModel({
    required this.id,
    required this.name,
  });

  static fromJson(Map<String, dynamic> data) {
    return CompanyModel(
      id: data['id'],
      name: data['name'],
    );
  }
}
