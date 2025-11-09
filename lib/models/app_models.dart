import 'package:uuid/uuid.dart';

// Use a global uuid generator
const uuid = Uuid();

// Enum for the Quote Status dropdown
enum QuoteStatus { draft, sent, accepted, rejected }

// Enum for the Tax Mode toggle
enum TaxMode { exclusive, inclusive }

class LineItem {
  final String id;
  final String productName;
  final double quantity;
  final double rate;
  final double discountPercent;
  final double taxPercent;

  LineItem({
    required this.productName,
    required this.quantity,
    required this.rate,
    this.discountPercent = 0.0,
    this.taxPercent = 0.0,
    String? id,
  }) : id = id ?? uuid.v4(); // Auto-generate ID if not provided

  /// Calculates the item's subtotal (Rate - Discount) * Quantity
  /// This is the pre-tax total.
  double get subtotal {
    final discountedRate = rate * (1 - (discountPercent / 100));
    return discountedRate * quantity;
  }

  /// Calculates the item's final total, including tax (if exclusive).
  /// This is a convenience getter.
  double get total {
    // This calculation is for Tax-Exclusive mode, as per the PDF
    final taxAmount = subtotal * (taxPercent / 100);
    return subtotal + taxAmount;
  }

  /// This is the 'copyWith' method that was missing.
  /// It allows us to create a new, updated copy of a LineItem.
  LineItem copyWith({
    String? id,
    String? productName,
    double? quantity,
    double? rate,
    double? discountPercent,
    double? taxPercent,
  }) {
    return LineItem(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      rate: rate ?? this.rate,
      discountPercent: discountPercent ?? this.discountPercent,
      taxPercent: taxPercent ?? this.taxPercent,
    );
  }
}