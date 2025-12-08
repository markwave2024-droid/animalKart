import 'package:animal_kart_demo2/orders/screens/invoice_screen.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
 import '../models/order_model.dart';

class BuffaloOrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTapInvoice;

  const BuffaloOrderCard({
    super.key,
    required this.order,
    this.onTapInvoice,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isPending = order.orderStatus.toLowerCase() == "pending";
    final bool isConfirmed = order.orderStatus.toLowerCase() == "confirmed";

    final Color statusColor = isPending
        ? Colors.orange
        : isConfirmed
            ? Colors.green
            : Colors.grey;

    return Container(
      // Removed bottom margin to control spacing via ListView padding only
      padding: const EdgeInsets.all(12), // slightly smaller padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row → Order ID + Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order.id}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.038,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (order.orderPlacedOn != null)
                      Text(
                        "Order Placed: ${order.orderPlacedOn}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  order.orderStatus.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
            ],
          ),
           const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  //width: screenWidth / 3, // 1/3 width
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 3,
                        offset: const Offset(1, 2),
                      ),
                    ],
                  ),
                ),
              ),

          const SizedBox(height: 8),

          // Divider
        // Replace your Image + Details + Invoice section with this:
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Image
    Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.network(
          order.buffaloImages.isNotEmpty
              ? order.buffaloImages.first
              : "https://via.placeholder.com/150",
          fit: BoxFit.cover,
        ),
      ),
    ),
    const SizedBox(width: 12),
    
    // Details + Invoice Button
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.breed,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: screenWidth * 0.036,
            ),
          ),
          const SizedBox(height: 4),
          Text(
  "Age: ${order.age} yrs",
  style: TextStyle(
    fontSize: screenWidth * 0.03,
    color: Colors.grey[600],
  ),
),
const SizedBox(height: 4),

// ✅ CPF Quantity
const SizedBox(height: 6),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // ✅ CPF BUTTON (LEFT)
    Container(
  padding: EdgeInsets.symmetric(
    horizontal: screenWidth * 0.032,
    vertical: 6,
  ),
  decoration: BoxDecoration(
    color: Colors.transparent, // ✅ No background
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Colors.black, // ✅ Outline color
      width: 1.2,
    ),
  ),
  child: Text(
    "${order.cpfQuantity}x Unit",
    style: TextStyle(
      color: Colors.black,
      fontSize: screenWidth * 0.028,
      fontWeight: FontWeight.w600,
    ),
  ),
),


   // const SizedBox(width: 8),

    // ✅ PAID AMOUNT BUTTON (MIDDLE)
    if (order.paidAmount != null)
     if (order.paidAmount != null)
  Container(
    padding: EdgeInsets.symmetric(
      horizontal: screenWidth * 0.032,
      vertical: 6,
    ),
    decoration: BoxDecoration(
      color: Colors.transparent, // ✅ No background
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.black, // ✅ Green outline for paid
        width: 1.2,
      ),
    ),
    child: Text(
      "₹${order.paidAmount} Paid",
      style: TextStyle(
        color: Colors.black,
        fontSize: screenWidth * 0.028,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),


   // const Spacer(), // ✅ pushes Invoice to the right
   if (order.invoiceUrl != null)
  InkWell(
    onTap: onTapInvoice, // ✅ THIS WAS MISSING
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        "Invoice",
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ),

// if (order.invoiceUrl != null)
//   InkWell(
//     // onTap: () {
//     //   Navigator.push(
//     //     context,
//     //     MaterialPageRoute(
//     //       builder: (_) => InvoiceScreen(order: order),
//     //     ),
//     //   );
//     // },
// onTap: () async {
//   final path = await InvoiceGenerator.generateInvoice(order);
//   await OpenFile.open(path);
// },

//     // ✅ INVOICE BUTTON (RIGHT)
//     // if (order.invoiceUrl != null)
//     //   InkWell(
//     //     onTap: onTapInvoice,
//     //     borderRadius: BorderRadius.circular(16),
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: screenWidth * 0.04,
//             vertical: 6,
//           ),
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Text(
//             "Invoice",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: screenWidth * 0.03,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//   )
  ]
      ),
  ],
),


// ✅ Paid Amount


          // Align Invoice button at bottom right of this column
        
 ) ],
      ),
    


]
)
         
      
    );
  }
}
