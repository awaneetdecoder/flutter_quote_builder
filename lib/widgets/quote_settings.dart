import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/quote_notifier.dart';
import '../models/app_models.dart';

/// This widget holds the Status dropdown and Tax Mode toggle
class QuoteSettings extends StatelessWidget {
  const QuoteSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<QuoteNotifier>();

    return Card(
      margin: const EdgeInsets.all(0), // No vertical margin, handled by ListView
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // --- Status Dropdown ---
                Row(
                  children: [
                    const Text('Status: ', style: TextStyle(color: Color(0xFF495057))),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<QuoteStatus>(
                        value: notifier.status,
                        items: QuoteStatus.values.map((status) => DropdownMenuItem(
                          value: status,
                          // Capitalize first letter
                          child: Text(status.name[0].toUpperCase() + status.name.substring(1)),
                        )).toList(),
                        onChanged: (value) {
                          if (value != null) notifier.setStatus(value);
                        },
                      ),
                    ),
                  ],
                ),
                // --- Tax Mode Toggle ---
                SegmentedButton<TaxMode>(
                  segments: const [
                    ButtonSegment(value: TaxMode.exclusive, label: Text('Exclusive')),
                    ButtonSegment(value: TaxMode.inclusive, label: Text('Inclusive')),
                  ],
                  selected: {notifier.taxMode},
                  onSelectionChanged: (Set<TaxMode> newSelection) {
                    notifier.setTaxMode(newSelection.first);
                  },
                  style: SegmentedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}