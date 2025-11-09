import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/quote_notifier.dart';
import '../utils/formatters.dart';

/// This is the Card that displays Subtotal, Tax, and Grand Total.
class TotalsDisplay extends StatelessWidget {
  const TotalsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // We 'watch' here so this widget rebuilds every time a calculation changes
    final notifier = context.watch<QuoteNotifier>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTotalRow(
              context,
              'Subtotal',
              notifier.subtotal,
            ),
            _buildTotalRow(
              context,
              'Total Tax',
              notifier.totalTax,
            ),
            const Divider(height: 24, thickness: 0.5),
            _buildTotalRow(
              context,
              'Grand Total',
              notifier.grandTotal,
              isGrandTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(BuildContext context, String title, double amount, {bool isGrandTotal = false}) {
    final textStyle = isGrandTotal 
      ? Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
      : Theme.of(context).textTheme.titleMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textStyle),
          Text(
            Formatters.currency.format(amount),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}