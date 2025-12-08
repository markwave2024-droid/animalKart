import 'package:flutter_riverpod/legacy.dart';
import '../models/order_model.dart';

final ordersProvider =
    StateNotifierProvider<OrdersNotifier, List<OrderModel>>((ref) {
  return OrdersNotifier();
});

class OrdersNotifier extends StateNotifier<List<OrderModel>> {
  OrdersNotifier() : super([]);

  void loadOrders() {
    state = [
      OrderModel(
        id: "ORD-1001",
        buffaloId: "MURRAH-001",
        breed: "Murrah Buffalo",
        age: 3,
        buffaloImages: [
          "https://storage.googleapis.com/markwave-kart/productimages/murrah_1.jpeg"
        ],
        price: 175000,
        insurance: 13000,
        orderStatus: "pending",
        userVerified: false,
        invoiceUrl: null,
        orderPlacedOn: "2025-12-01",

        // ✅ NEW REQUIRED FIELDS
        cpfQuantity: 1,     // example: 5 CPF taken
        paidAmount: null,  // not paid yet
      ),

      OrderModel(
        id: "ORD-1002",
        buffaloId: "MURRAH-001",
        breed: "Murrah Buffalo",
        age: 3,
        buffaloImages: [
          "https://storage.googleapis.com/markwave-kart/productimages/murrah_1.jpeg"
        ],
        price: 175000,
        insurance: 13000,
        orderStatus: "confirmed",
        userVerified: true,
        invoiceUrl: "https://example.com/invoice_1002.pdf",
        orderPlacedOn: "2025-12-03",

        // ✅ NEW REQUIRED FIELDS
        cpfQuantity: 1,       // example: 10 CPF taken
        paidAmount: 50000,    // ✅ paid amount available
      ),
    ];
  }
}
