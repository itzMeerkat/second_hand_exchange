class ItemRecord {
  final String image;
  final String description;
  final int currentPrice;
  final int originalPrice;

  final String uid;
  final String contact;
  final String email;

  ItemRecord(
      {this.contact,
      this.email,
      this.image,
      this.description,
      this.currentPrice,
      this.originalPrice,
      this.uid});

  Map<String, dynamic> toJSON() {
    return {
      'image': this.image,
      'description': this.description,
      'currentPrice': this.currentPrice,
      'originalPrice': this.originalPrice,
      'uid': this.uid
    };
  }
}
