import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/quote_notifier.dart';
import './quote_preview_screen.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/client_info_card.dart';
import '../widgets/quote_settings.dart';
import '../widgets/line_item_row.dart';
import '../widgets/desktop_line_item_row.dart';
import '../widgets/totals_display.dart';

class QuoteFormScreen extends StatelessWidget {
  const QuoteFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quote'),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Save action tapped')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: ResponsiveLayout(
        mobileBody: _MobileQuoteForm(),
        desktopBody: _DesktopQuoteForm(),
      ),
    );
  }
}

// --- Mobile Layout Class ---
class _MobileQuoteForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<QuoteNotifier>();
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const ClientInfoCard(),
        const SizedBox(height: 8),
        const QuoteSettings(),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            'Line Items',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notifier.items.length,
          itemBuilder: (context, index) {
            final item = notifier.items[index];
            // FIX: Added 'notifier: notifier'
            return LineItemRow(item: item, notifier: notifier);
          },
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add Item'),
          onPressed: () => context.read<QuoteNotifier>().addLineItem(),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        const SizedBox(height: 16),
        const TotalsDisplay(),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const QuotePreviewScreen(),
              ),
            );
          },
          child: const Text('Preview Quote'),
        ),
      ],
    );
  }
}

// --- Desktop Layout Class ---
class _DesktopQuoteForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<QuoteNotifier>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const ClientInfoCard(),
              const SizedBox(height: 16),
              const QuoteSettings(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                child: Text(
                  'Line Items',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Product / Service', style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 1, child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 1, child: Text('Rate', style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 1, child: Text('Discount(%)', style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 1, child: Text('Tax(%)', style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 1, child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(width: 48), 
                  ],
                ),
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notifier.items.length,
                itemBuilder: (context, index) {
                  final item = notifier.items[index];
                  // FIX: Added 'notifier: notifier'
                  return DesktopLineItemRow(item: item, notifier: notifier);
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Item'),
                onPressed: () => context.read<QuoteNotifier>().addLineItem(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: const Color(0xFFF1F3F5),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Quote Summary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 24),
                const TotalsDisplay(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const QuotePreviewScreen(),
                      ),
                    );
                  },
                  child: const Text('Preview Quote'),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}