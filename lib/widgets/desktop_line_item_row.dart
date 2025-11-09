import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/app_models.dart';
import '../notifiers/quote_notifier.dart';
import '../utils/formatters.dart';

// This is the Desktop layout for a line item (the horizontal row)
class DesktopLineItemRow extends StatefulWidget {
  final LineItem item;
  final QuoteNotifier notifier;

  const DesktopLineItemRow({
    super.key,
    required this.item,
    required this.notifier,
  });

  @override
  State<DesktopLineItemRow> createState() => _DesktopLineItemRowState();
}

class _DesktopLineItemRowState extends State<DesktopLineItemRow> {
  late final TextEditingController _productController;
  late final TextEditingController _qtyController;
  late final TextEditingController _rateController;
  late final TextEditingController _discountController;
  late final TextEditingController _taxController;

  @override
  void initState() {
    super.initState();
    _productController = TextEditingController(text: widget.item.productName);
    _qtyController =
        TextEditingController(text: Formatters.numToString(widget.item.quantity));
    _rateController =
        TextEditingController(text: Formatters.numToString(widget.item.rate));
    
    // FIX: Corrected to discountPercent
    _discountController =
        TextEditingController(text: Formatters.numToString(widget.item.discountPercent)); 
    
    _taxController =
        TextEditingController(text: Formatters.numToString(widget.item.taxPercent));
  }

  @override
  void dispose() {
    _productController.dispose();
    _qtyController.dispose();
    _rateController.dispose();
    _discountController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  double _parseText(String text) {
    return double.tryParse(text) ?? 0.0;
  }

  // --- FIX: THIS METHOD IS NOW CORRECT ---
  void _updateItem() {
    widget.notifier.updateLineItem(
      widget.item.id,
      // We pass the new values as named parameters,
      // not with copyWith
      productName: _productController.text,
      quantity: _parseText(_qtyController.text),
      rate: _parseText(_rateController.text),
      discountPercent: _parseText(_discountController.text),
      taxPercent: _parseText(_taxController.text),
    );
  }
  // --- END OF FIX ---

  Widget _buildTextField(
    TextEditingController controller,
    String label, [
    bool isNumeric = true,
  ]) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        filled: false,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
      keyboardType: isNumeric
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: isNumeric
          ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))]
          : [],
      onChanged: (value) => _updateItem(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _buildTextField(_productController, 'Product', false),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: _buildTextField(_qtyController, 'Qty'),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: _buildTextField(_rateController, 'Rate'),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: _buildTextField(_discountController, 'Discount(%)'),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: _buildTextField(_taxController, 'Tax(%)'),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                // --- FIX: Changed from .currency() to .currency.format() ---
                Formatters.currency.format(widget.item.total),
                // --- END OF FIX ---
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          SizedBox(
            width: 48,
            child: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => widget.notifier.removeLineItem(widget.item.id),
            ),
          ),
        ],
      ),
    );
  }
}