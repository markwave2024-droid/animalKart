class OrderModel {
  final String id;
  final String buffaloId;
  final String breed;
  final int age;
  final List<String> buffaloImages;
  final int price;
  final int insurance;
  final String orderStatus;
  final bool userVerified;
  final String? invoiceUrl;
  final String? orderPlacedOn;

  // ✅ NEW FIELDS
  final int cpfQuantity;      // how much CPF taken
  final int? paidAmount;     // how much amount paid (nullable)

  OrderModel({
    required this.id,
    required this.buffaloId,
    required this.breed,
    required this.age,
    required this.buffaloImages,
    required this.price,
    required this.insurance,
    required this.orderStatus,
    required this.userVerified,
    this.invoiceUrl,
    this.orderPlacedOn,

    // ✅ NEW
    required this.cpfQuantity,
    this.paidAmount,
  });
}
