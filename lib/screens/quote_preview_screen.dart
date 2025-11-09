import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/quote_notifier.dart';
import '../models/app_models.dart';
import '../utils/formatters.dart';

// This is the "clean, printable layout" screen.
// It's non-editable and just displays the final quote.

class QuotePreviewScreen extends StatelessWidget {
  const QuotePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We only need to 'read' the notifier, as this screen doesn't change data.
    final notifier = context.read<QuoteNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              // TODO: Implement printing logic (e.g., using 'printing' package)
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: const EdgeInsets.all(32.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              const Text(
                'QUOTE',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              Text('Ref: ${notifier.jobReference}'),
              Text('Status: ${notifier.status.name[0].toUpperCase() + notifier.status.name.substring(1)}'),
              
              const SizedBox(height: 32),

              // --- Client Info ---
              const Text(
                'CLIENT:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                notifier.clientName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(notifier.clientAddress),
              
              const SizedBox(height: 32),

              // --- Line Items Table ---
              _buildLineItemsTable(notifier, context),

              const SizedBox(height: 32),

              // --- Totals ---
              _buildTotalsDisplay(notifier, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineItemsTable(QuoteNotifier notifier, BuildContext context) {
    return Column(
      children: [
        // Table Header
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFFF1F3F5), // Light grey header
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: const Row(
            children: [
              Expanded(flex: 4, child: Text('Product / Service', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 1, child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
              Expanded(flex: 2, child: Text('Rate', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
              Expanded(flex: 2, child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
            ],
          ),
        ),
        // Table Rows
        ...notifier.items.map((item) {
          double itemTotal = (notifier.taxMode == TaxMode.exclusive)
              ? item.subtotal + (item.subtotal * (item.taxPercent / 100))
              : item.subtotal;
              
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE9ECEF))),
            ),
            child: Row(
              children: [
                Expanded(flex: 4, child: Text(item.productName)),
                Expanded(flex: 1, child: Text(item.quantity.toString(), textAlign: TextAlign.right)),
                Expanded(flex: 2, child: Text(Formatters.currency.format(item.rate), textAlign: TextAlign.right)),
                Expanded(flex: 2, child: Text(Formatters.currency.format(itemTotal), textAlign: TextAlign.right)),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTotalsDisplay(QuoteNotifier notifier, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 250),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildTotalRow('Subtotal', notifier.subtotal),
              _buildTotalRow('Total Tax', notifier.totalTax),
              const Divider(height: 24, thickness: 1),
              _buildTotalRow('Grand Total', notifier.grandTotal, isGrandTotal: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow(String title, double amount, {bool isGrandTotal = false}) {
    final textStyle = TextStyle(
      fontSize: isGrandTotal ? 20 : 16,
      fontWeight: isGrandTotal ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textStyle),
          const SizedBox(width: 32),
          Text(
            Formatters.currency.format(amount),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}