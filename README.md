# nibit
A beautiful and responsive Flutter cryptocurrency tracker that displays live coin data, price trends, and detailed statistics.  
Built with GetX, StreamBuilder, and the CoinGecko API, this app demonstrates reactive UI updates, persistent caching, offline support, and chart visualization.

---

##  Features

✅ Real-time Coin Data
- Displays live price updates using a Stream from the CoinGecko API.
- Automatically refreshes every 30 seconds.

✅ Offline Persistence
- Cached data is preserved and shown during network downtime.
- Avoids unnecessary rebuilds or empty states when navigating back and forth.

✅ Favorites Management
- Mark and save your favorite coins for quick access.

✅ Coin Detail Screen
- Shows extended information such as market cap, volume, and price percentage change.
- Includes a price trends chart using `fl_chart`.

✅ Search Functionality
- Quickly find any coin by name or symbol.

✅ Pull-to-Refresh Support
- Manually refresh the list using a swipe gesture.

---

## 🔌 API Integration

All coin data is fetched from the **[CoinGecko API](https://www.coingecko.com/en/api/documentation)

---

## Price Trends Chart

- Implemented using fl_chart.
- Displays a line chart of recent price changes.
- Grid lines show price values on the Y-axis and time intervals on the X-axis.
- Supports smooth curved animations and touch interactions.

---

## ## 🔗 Links

GitHub Repository:https://github.com/Veektorrh/NiBit.git
Demo Video Link: https://drive.google.com/file/d/1QxCYoXYmMz1kPLQFjIr-ZnbQ-dDqrG6e/view?usp=sharing
Direct APK Download: https://drive.google.com/file/d/1N_Wi8titj_7JcrQsfhU_jRQlELq49w7C/view?usp=sharing

---

##  Installation

1 Clone the repository

git clone https://github.com/Veektorrh/NiBit.git


2 Install dependencies
flutter pub get

3 Run the app
flutter run

⚙️ Notes

Requires Flutter 3.22 or higher.

If you encounter errors with fl_chart and vector_math, ensure Flutter is up to date:

flutter upgrade

Or use:

fl_chart: ^0.63.0


---



Author:
Veektorrh
gitHub: https://github.com/Veektorrh



