class ItemRecord {
  final String image;
  final String description;
  final int currentPrice;
  final int originalPrice;

  final String uid;
  final String contact;

  ItemRecord(
      {this.contact,
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
      'uid': this.uid,
      'contact': this.contact
    };
  }
}
