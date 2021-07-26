class ListData {
  ListData({
    this.title,
    this.isSelected,
  });

  String? title;
  bool? isSelected;

  factory ListData.fromMap(Map<String, dynamic> json) => ListData(
    title: json["id"] == null ? null : json["id"],
    isSelected: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": title == null ? null : title,
    "name": isSelected == null ? null : isSelected,
  };
}