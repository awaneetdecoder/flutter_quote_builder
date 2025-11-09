import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/quote_notifier.dart';

class ClientInfoCard extends StatelessWidget {
  const ClientInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    // We use 'read' here because we are just sending data *to* the notifier
    // on 'onChanged'. The TextFormFields manage their own state.
    final notifier = context.read<QuoteNotifier>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Client Info',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Client Name'),
              initialValue: notifier.clientName,
              onChanged: (value) => notifier.updateClientName(value),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address'),
              initialValue: notifier.clientAddress,
              onChanged: (value) => notifier.updateClientAddress(value),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Job Reference'),
              initialValue: notifier.jobReference,
              onChanged: (value) => notifier.updateJobReference(value),
            ),
          ],
        ),
      ),
    );
  }
}