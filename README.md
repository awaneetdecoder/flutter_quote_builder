Flutter Product Quote Builder

This is a professional product quotation app built with Flutter, based on the "Flutter Dev - Product Quote Task".

The app allows a user to build a quote by entering client information and adding multiple line items. All calculations (per-item totals, subtotals, tax, and grand totals) are calculated in real-time. The app is fully responsive and features a clean, professional UI suitable for a B2B tool.

Features Implemented

This project successfully fulfills all core and bonus requirements from the task PDF.

Core Requirements

Client Info Form: Collects client name, address, and job reference.

Dynamic Line Items: Users can add or remove an unlimited number of product/service line items.

Real-time Calculations: All totals are updated instantly as the user types, using logic from Provider and ChangeNotifier.

Responsive Layout: The UI gracefully adapts from a mobile (single-column card view) to a desktop (two-column table view) layout.

Preview Section: A clean, printable preview screen mimics a professional invoice.

Bonus Features

Tax Mode: A toggle allows switching between Tax-Exclusive and Tax-Inclusive calculation modes.

Currency Formatting: All monetary values are formatted as currency (e.g., $2,362.50).

Status Tracking: The quote status (e.g., Draft, Sent, Accepted) can be set via a dropdown.

Save Simulation: A "Save" button simulates a save action by showing a SnackBar.

Tech Stack

Framework: Flutter

State Management: provider (using ChangeNotifier)

Utility Packages:

intl: For currency formatting.

uuid: For generating unique IDs for line items.

collection: For safe list operations in the notifier.

How to Run

Ensure you have the Flutter SDK installed.

Clone this repository.

Navigate to the project directory:

cd quote_builder


Install dependencies:

flutter pub get


Run the app:

flutter run


This project was built according to the provided task PDF.