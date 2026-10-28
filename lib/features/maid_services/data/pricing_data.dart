// Centralised pricing data for salary estimation, mirroring the reference
// maid-service website's tier-based, per-service pricing tables.
//
// Each service key maps shift duration keys (e.g. '2h', '4h') to a
// [lowerBound, upperBound] salary range in INR per month.

class PricingData {
  PricingData._();

  // ─── Tier 1: Mumbai & Premium Navi Mumbai ────────────────────────────
  static const Map<String, Map<String, List<int>>> tier1 = {
    'house_maid': {
      '2h': [4000, 5000],
      '4h': [7000, 9000],
      '5h': [8500, 10000],
      '6h': [10000, 12000],
      '8h': [13000, 15000],
      '10h': [15000, 17000],
      '12h': [17000, 19000],
      '24h': [20000, 24000],
    },
    'cook': {
      '2h': [6000, 8000],
      '4h': [10000, 12000],
      '5h': [11500, 14000],
      '6h': [13000, 16000],
      '8h': [16000, 19000],
      '10h': [18000, 21000],
      '12h': [20000, 24000],
      '24h': [25000, 30000],
    },
    'baby_sitter': {
      '2h': [6000, 8000],
      '4h': [9000, 11000],
      '5h': [11000, 13000],
      '6h': [13000, 15000],
      '8h': [17000, 20000],
      '10h': [20000, 23000],
      '12h': [22000, 26000],
      '24h': [28000, 35000],
    },
    'patient_care': {
      '2h': [7000, 9000],
      '4h': [11000, 13000],
      '5h': [13000, 15000],
      '6h': [15000, 18000],
      '8h': [20000, 24000],
      '10h': [23000, 27000],
      '12h': [26000, 30000],
      '24h': [32000, 40000],
    },
    'elderly_care': {
      '2h': [6000, 8000],
      '4h': [10000, 12000],
      '5h': [12000, 14000],
      '6h': [14000, 16000],
      '8h': [18000, 21000],
      '10h': [21000, 24000],
      '12h': [24000, 28000],
      '24h': [30000, 36000],
    },
    'nanny': {
      '2h': [6000, 8000],
      '4h': [9000, 11000],
      '5h': [11000, 13000],
      '6h': [13000, 15000],
      '8h': [17000, 20000],
      '10h': [20000, 23000],
      '12h': [22000, 26000],
      '24h': [28000, 35000],
    },
    'japa_maid': {
      '2h': [8000, 10000],
      '4h': [15000, 20000],
      '5h': [18000, 24000],
      '6h': [22000, 28000],
      '8h': [28000, 35000],
      '10h': [32000, 40000],
      '12h': [35000, 45000],
      '24h': [50000, 70000],
    },
  };

  // ─── Tier 2/3: Thane, Kalyan, Ulwe & Others ──────────────────────────
  static const Map<String, Map<String, List<int>>> tier2 = {
    'house_maid': {
      '2h': [3000, 4000],
      '4h': [6000, 8000],
      '5h': [7000, 9000],
      '6h': [8000, 10000],
      '8h': [11000, 13000],
      '10h': [12000, 14000],
      '12h': [14000, 17000],
      '24h': [16000, 20000],
    },
    'cook': {
      '2h': [5000, 7000],
      '4h': [8000, 10000],
      '5h': [9500, 12000],
      '6h': [11000, 13000],
      '8h': [14000, 17000],
      '10h': [16000, 19000],
      '12h': [18000, 22000],
      '24h': [22000, 26000],
    },
    'baby_sitter': {
      '2h': [5000, 7000],
      '4h': [8000, 10000],
      '5h': [9500, 11000],
      '6h': [11000, 13000],
      '8h': [14000, 17000],
      '10h': [16000, 19000],
      '12h': [19000, 23000],
      '24h': [22000, 28000],
    },
    'patient_care': {
      '2h': [6000, 8000],
      '4h': [10000, 12000],
      '5h': [11500, 14000],
      '6h': [13000, 16000],
      '8h': [18000, 22000],
      '10h': [21000, 24000],
      '12h': [23000, 27000],
      '24h': [28000, 35000],
    },
    'elderly_care': {
      '2h': [5000, 7000],
      '4h': [9000, 11000],
      '5h': [10500, 13000],
      '6h': [12000, 14000],
      '8h': [16000, 19000],
      '10h': [19000, 22000],
      '12h': [21000, 25000],
      '24h': [25000, 30000],
    },
    'nanny': {
      '2h': [5000, 7000],
      '4h': [8000, 10000],
      '5h': [9500, 11000],
      '6h': [11000, 13000],
      '8h': [14000, 17000],
      '10h': [16000, 19000],
      '12h': [19000, 23000],
      '24h': [22000, 28000],
    },
    'japa_maid': {
      '2h': [7000, 9000],
      '4h': [12000, 18000],
      '5h': [16000, 22000],
      '6h': [20000, 25000],
      '8h': [25000, 32000],
      '10h': [28000, 35000],
      '12h': [30000, 40000],
      '24h': [45000, 60000],
    },
  };

  /// Keywords that identify a Tier 2 location.
  static const List<String> tier2Keywords = [
    'kalyan',
    'ulwe',
    'dombivli',
    'dombivali',
    'mira road',
    'bhiwandi',
    'ambernath',
    'ambarnath',
    'diva',
    'kalamboli',
    'kamothe',
  ];

  /// Maps service display titles used in the app to pricing-table keys.
  static const Map<String, String> serviceTitleToKey = {
    'House Maid': 'house_maid',
    'Cook for Home': 'cook',
    'Baby Sitter': 'baby_sitter',
    'Patient Care': 'patient_care',
    'Japa Maid': 'japa_maid',
    'Elderly Care': 'elderly_care',
    'Nanny': 'nanny',
  };

  /// Maps shift display labels (e.g. '2 Hrs') to pricing-table keys.
  static const Map<String, String> shiftTitleToKey = {
    '2 Hrs': '2h',
    '4 Hrs': '4h',
    '5 Hrs': '5h',
    '6 Hrs': '6h',
    '8 Hrs': '8h',
    '10 Hrs': '10h',
    '12 Hrs': '12h',
    '24 Hrs': '24h',
  };

  // ─── Helpers ─────────────────────────────────────────────────────────

  /// Determine pricing tier from a location name.
  static String getTierForLocation(String locationName) {
    final lower = locationName.toLowerCase();
    for (final keyword in tier2Keywords) {
      if (lower.contains(keyword)) return 'tier2';
    }
    return 'tier1';
  }

  /// Look up the `[low, high]` salary range for a given service title,
  /// shift title, and location name.
  ///
  /// Returns `null` if the combination is not found — callers should
  /// fall back to a sensible default.
  static List<int>? getSalaryRange({
    required String serviceTitle,
    required String shiftTitle,
    required String locationName,
  }) {
    final tier = getTierForLocation(locationName);
    final serviceKey = serviceTitleToKey[serviceTitle];
    final shiftKey = shiftTitleToKey[shiftTitle];

    if (serviceKey == null || shiftKey == null) return null;

    final tierData = tier == 'tier2' ? tier2 : tier1;
    return tierData[serviceKey]?[shiftKey];
  }

  /// Compute the final estimated salary string (e.g. "₹7,000 - ₹9,000")
  /// taking service, shift, location, and apartment size into account.
  static String computeEstimatedSalary({
    required String serviceTitle,
    required String shiftTitle,
    required String locationName,
    required double apartmentMultiplier,
  }) {
    final range = getSalaryRange(
      serviceTitle: serviceTitle,
      shiftTitle: shiftTitle,
      locationName: locationName,
    );

    // Fallback: use house_maid tier1 2h as baseline
    final baseLow = range?[0] ?? 4000;
    final baseHigh = range?[1] ?? 5000;

    final low = (baseLow * apartmentMultiplier).round();
    final high = (baseHigh * apartmentMultiplier).round();

    return '₹${_formatIndianCurrency(low)} - ₹${_formatIndianCurrency(high)}';
  }

  /// Format an integer to Indian number style (e.g. 25000 → "25,000").
  static String _formatIndianCurrency(int value) {
    final str = value.toString();
    if (str.length <= 3) return str;

    final lastThree = str.substring(str.length - 3);
    String remaining = str.substring(0, str.length - 3);

    // Insert commas every two digits from the right for the remaining part
    if (remaining.isNotEmpty) {
      final buffer = StringBuffer();
      int count = 0;
      for (int i = remaining.length - 1; i >= 0; i--) {
        buffer.write(remaining[i]);
        count++;
        if (count == 2 && i > 0) {
          buffer.write(',');
          count = 0;
        }
      }
      remaining = buffer.toString().split('').reversed.join();
    }

    return '$remaining,$lastThree';
  }
}
