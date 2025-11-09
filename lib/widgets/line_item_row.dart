import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/app_models.dart';
import '../notifiers/quote_notifier.dart';

// FIX: This import line was missing
import '../utils/formatters.dart';

// This is the Mobile layout for a line item (the vertical card)
class LineItemRow extends StatefulWidget {
  final LineItem item;
  final QuoteNotifier notifier;

  const LineItemRow({
    super.key,
    required this.item,
    required this.notifier,
  });

  @override
  State<LineItemRow> createState() => _LineItemRowState();
}

class _LineItemRowState extends State<LineItemRow> {
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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: _productController,
              decoration: const InputDecoration(labelText: 'Product / Service'),
              onChanged: (value) => _updateItem(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _qtyController,
                    decoration: const InputDecoration(labelText: 'Qty'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    onChanged: (value) => _updateItem(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _rateController,
                    decoration: const InputDecoration(labelText: 'Rate'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    onChanged: (value) => _updateItem(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _discountController,
                    decoration: const InputDecoration(labelText: 'Discount (%)'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    onChanged: (value) => _updateItem(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _taxController,
                    decoration: const InputDecoration(labelText: 'Tax (%)'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    onChanged: (value) => _updateItem(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => widget.notifier.removeLineItem(widget.item.id),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      // --- FIX: Changed from .currency() to .currency.format() ---
                      Formatters.currency.format(widget.item.total),
                      // --- END OF FIX ---
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}