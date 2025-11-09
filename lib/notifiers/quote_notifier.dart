import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../models/app_models.dart';

class QuoteNotifier extends ChangeNotifier {
  // --- STATE ---
  String _clientName = 'Acme Corporation';
  String _clientAddress = '123 Innovation Drive, Tech City, 12345';
  String _jobReference = 'Q-2024-001';
  QuoteStatus _status = QuoteStatus.draft;
  TaxMode _taxMode = TaxMode.exclusive;
  
  List<LineItem> _items = [
    // Initial dummy data to match design
    LineItem(
      productName: 'Website Design & Development',
      quantity: 1,
      rate: 2500,
      discountPercent: 10,
      taxPercent: 5,
    ),
  ];

  // --- GETTERS (PUBLIC) ---
  String get clientName => _clientName;
  String get clientAddress => _clientAddress;
  String get jobReference => _jobReference;
  QuoteStatus get status => _status;
  TaxMode get taxMode => _taxMode;
  List<LineItem> get items => List.unmodifiable(_items);

  // --- CALCULATED GETTERS ---

  /// The total of all item subtotals (pre-tax).
  double get subtotal {
    return _items.fold<double>(0.0, (sum, item) => sum + item.subtotal);
  }
  
  /// The total tax amount.
  double get totalTax {
    if (_taxMode == TaxMode.exclusive) {
      // Tax is calculated on top of the subtotal
      return _items.fold<double>(0.0, (sum, item) {
        return sum + (item.subtotal * (item.taxPercent / 100));
      });
    } else {
      // Tax is included in the subtotal
      // (Total * Tax%) / (100% + Tax%)
      return _items.fold<double>(0.0, (sum, item) {
        final taxRate = item.taxPercent / 100;
        final taxAmount = (item.subtotal * taxRate) / (1 + taxRate);
        return sum + taxAmount;
      });
    }
  }

  /// The final grand total.
  double get grandTotal {
    if (_taxMode == TaxMode.exclusive) {
      // Subtotal + Tax
      return subtotal + totalTax;
    } else {
      // The subtotal *is* the grand total, as tax is included
      return subtotal;
    }
  }

  // --- METHODS (PUBLIC) ---

  // Client Info Updaters
  void updateClientName(String name) {
    _clientName = name;
    notifyListeners();
  }
  
  void updateClientAddress(String address) {
    _clientAddress = address;
    notifyListeners();
  }

  void updateJobReference(String ref) {
    _jobReference = ref;
    notifyListeners();
  }

  // Quote Settings Updaters
  void setStatus(QuoteStatus newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  void setTaxMode(TaxMode newMode) {
    _taxMode = newMode;
    notifyListeners();
  }

  // Line Item Updaters

  // --- FIX: Added all required fields ---
  void addLineItem() {
    _items.add(LineItem(
      productName: '',
      quantity: 1,
      rate: 0,
      discountPercent: 0,
      taxPercent: 0,
    ));
    notifyListeners();
  }
  // --- END OF FIX ---

  void removeLineItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  // --- FIX: Replaced the old logic with this correct version ---
  void updateLineItem(
    String id, {
    String? productName,
    double? quantity,
    double? rate,
    double? discountPercent,
    double? taxPercent,
  }) {
    // Find the item
    final item = _items.firstWhereOrNull((item) => item.id == id);
    if (item == null) return;

    // Find its index
    final index = _items.indexOf(item);

    // Create a new copy with the updated values
    _items[index] = item.copyWith(
      productName: productName,
      quantity: quantity,
      rate: rate,
      discountPercent: discountPercent,
      taxPercent: taxPercent,
    );
    
    // Notify all listeners of the change
    notifyListeners();
  }
  // --- END OF FIX ---
}