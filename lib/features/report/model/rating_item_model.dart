class RatingItemModel {
  final String key; // 👈 بدل title
  double value;

  RatingItemModel({
    required this.key,
    this.value = 5,
  });
}