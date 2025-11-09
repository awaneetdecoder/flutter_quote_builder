Flutter Product Quote Builder

A professional, responsive product quotation app built in Flutter. This project allows users to dynamically create quotes with multiple line items, real-time calculations, and a clean, B2B-friendly UI.

This project was built to fulfill all Core and Bonus requirements of the "Flutter Dev - Product Quote Task".

Screenshots

(As required by the task submission, here are screenshots of the filled form and the final preview)

Mobile Form View

Preview View

<img src="URL_TO_YOUR_FILLED_FORM_SCREENSHOT.png" alt="Mobile Quote Form" width="300">

<img src="URL_TO_YOUR_PREVIEW_SCREENSHOT.png" alt="Quote Preview" width="300">

(Note: To add your screenshots, upload them to your GitHub repo and then replace the URL_TO_YOUR... paths with the direct links.)

Task Requirements Checklist

This project successfully implements all features specified in the task document.

✅ Core Requirements

[x] Client Info Form: Collects client name, address, and job reference.

[x] Dynamic Line Items: Users can add or remove an unlimited number of product/service line items.

[x] Real-time Calculations: All totals (per-item, subtotal, tax, grand total) are calculated instantly as the user types.

[x] Responsive Layout: The UI adapts from a mobile (single-column card view) to a desktop/tablet (two-column table view) layout.

[x] Preview Section: A clean, printable "invoice-style" preview screen is generated from the form data.

🎁 Bonus Features

[x] Tax Mode: A toggle allows switching between Tax-Exclusive and Tax-Inclusive calculation modes.

[x] Currency Formatting: All monetary values are formatted as currency (e.g., $2,362.50).

[x] Status Tracking: The quote status (e.g., Draft, Sent, Accepted) can be set via a dropdown.

[x] Save Simulation: The "Save" button simulates a save action by showing a SnackBar.

Technical Stack

Framework: Flutter

State Management: provider (using ChangeNotifier for reactive state)

Architecture: The UI is split into clean, reusable widgets (screens, widgets), separating logic (notifiers) and data (models).

Utility Packages:

intl: For currency and number formatting.

uuid: For generating unique IDs for new line items.

collection: For safe list operations in the notifier.

How to Run This Project

Clone the repository:

git clone [https://github.com/awaneetdecoder/flutter_quote_builder.git](https://github.com/awaneetdecoder/flutter_quote_builder.git)


Navigate to the project directory:

cd flutter_quote_builder


Install dependencies:

flutter pub get


Run the app:

flutter run
