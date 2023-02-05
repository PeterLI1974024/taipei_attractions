class AttractionDetail {
  final int id;
  final String name;
  final String introduction;
  final String destric;
  final String tele;
  final String address;
  final remind;
  final String url;
  final images;

  AttractionDetail({
    required this.id,
    required this.name,
    required this.introduction,
    required this.destric,
    required this.tele,
    this.images,
    required this.address,
    this.remind,
    required this.url,
  });
}
