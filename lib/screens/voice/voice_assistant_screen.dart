// ╔══════════════════════════════════════════════════════════════════════════════╗
// ║  MONEY BUDDY — VOICE ASSISTANT                                             ║
// ║  The PRIMARY feature. Manage 80-90% of your finances by voice.             ║
// ║  Supports: English, Hindi, Hinglish                                        ║
// ║  Offline-first, rule-based NLP, no cloud API needed.                       ║
// ╚══════════════════════════════════════════════════════════════════════════════╝

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../core/router/app_router.dart';
import '../../core/database/database_helper.dart';
import '../../models/transaction_model.dart';
import '../../models/borrow_lend_model.dart';
import '../../models/reminder_model.dart';
import '../../providers/transaction_provider.dart';
import '../../providers/borrow_lend_provider.dart';
import '../../providers/reminder_provider.dart';
import '../../providers/settings_provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 1: DATA MODELS
// ─────────────────────────────────────────────────────────────────────────────

/// The type of action parsed from a voice command.
enum VoiceCommandType { expense, income, lend, borrow, reminder, query, navigate, unknown }

/// The current phase of the voice assistant UI.
enum VoiceAssistantPhase { idle, listening, processing, confirmation, success, error, clarification }

/// Structured result of NLP parsing a single voice command.
class ParsedVoiceCommand {
  final VoiceCommandType type;
  final double? amount;
  final String? categoryName;
  final String? categoryIcon;
  final String? categoryColor;
  final String? personName;
  final String? note;
  final DateTime? date;
  final String? reminderTitle;
  final String? queryText;
  final String? navigationTarget;
  final String rawText;

  const ParsedVoiceCommand({
    required this.type,
    this.amount,
    this.categoryName,
    this.categoryIcon,
    this.categoryColor,
    this.personName,
    this.note,
    this.date,
    this.reminderTitle,
    this.queryText,
    this.navigationTarget,
    required this.rawText,
  });

  ParsedVoiceCommand copyWith({
    VoiceCommandType? type,
    double? amount,
    String? categoryName,
    String? categoryIcon,
    String? categoryColor,
    String? personName,
    String? note,
    DateTime? date,
    String? reminderTitle,
    String? queryText,
    String? navigationTarget,
  }) {
    return ParsedVoiceCommand(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      categoryName: categoryName ?? this.categoryName,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      categoryColor: categoryColor ?? this.categoryColor,
      personName: personName ?? this.personName,
      note: note ?? this.note,
      date: date ?? this.date,
      reminderTitle: reminderTitle ?? this.reminderTitle,
      queryText: queryText ?? this.queryText,
      navigationTarget: navigationTarget ?? this.navigationTarget,
      rawText: rawText,
    );
  }

  /// Human-readable summary for the confirmation card.
  String get summary {
    final currency = '₹';
    switch (type) {
      case VoiceCommandType.expense:
        return '${currency}${amount?.toStringAsFixed(0) ?? '?'} expense${categoryName != null ? ' on $categoryName' : ''}';
      case VoiceCommandType.income:
        return '${currency}${amount?.toStringAsFixed(0) ?? '?'} income${categoryName != null ? ' from $categoryName' : ''}';
      case VoiceCommandType.lend:
        return 'Lent ${currency}${amount?.toStringAsFixed(0) ?? '?'}${personName != null ? ' to $personName' : ''}';
      case VoiceCommandType.borrow:
        return 'Borrowed ${currency}${amount?.toStringAsFixed(0) ?? '?'}${personName != null ? ' from $personName' : ''}';
      case VoiceCommandType.reminder:
        return 'Reminder: ${reminderTitle ?? rawText}';
      case VoiceCommandType.query:
        return queryText ?? rawText;
      case VoiceCommandType.navigate:
        return 'Navigate to ${navigationTarget ?? 'unknown'}';
      case VoiceCommandType.unknown:
        return rawText;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 2: CATEGORY MATCHING
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryMatch {
  final String name;
  final String icon;
  final String colorHex;
  final String type; // 'expense' or 'income'

  const _CategoryMatch(this.name, this.icon, this.colorHex, this.type);
}

/// Maps spoken words to database category names.
class _CategoryMatcher {
  static const _expenseKeywords = <String, _CategoryMatch>{
    // Food & Dining
    'food': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'lunch': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'dinner': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'breakfast': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'restaurant': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'khana': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'meal': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'snack': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'snacks': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'chai': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'coffee': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'pizza': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'burger': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'biryani': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),
    'nashta': _CategoryMatch('Food & Dining', 'restaurant', '#E53935', 'expense'),

    // Shopping
    'shopping': _CategoryMatch('Shopping', 'shopping_bag', '#8E24AA', 'expense'),
    'shop': _CategoryMatch('Shopping', 'shopping_bag', '#8E24AA', 'expense'),
    'clothes': _CategoryMatch('Shopping', 'shopping_bag', '#8E24AA', 'expense'),
    'kapde': _CategoryMatch('Shopping', 'shopping_bag', '#8E24AA', 'expense'),
    'buy': _CategoryMatch('Shopping', 'shopping_bag', '#8E24AA', 'expense'),
    'kharida': _CategoryMatch('Shopping', 'shopping_bag', '#8E24AA', 'expense'),
    'amazon': _CategoryMatch('Shopping', 'shopping_bag', '#8E24AA', 'expense'),
    'flipkart': _CategoryMatch('Shopping', 'shopping_bag', '#8E24AA', 'expense'),
    'online': _CategoryMatch('Shopping', 'shopping_bag', '#8E24AA', 'expense'),

    // Transport
    'transport': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'petrol': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'fuel': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'cab': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'uber': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'ola': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'auto': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'bus': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'train': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'metro': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'travel': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'rickshaw': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),
    'taxi': _CategoryMatch('Transport', 'directions_car', '#1E88E5', 'expense'),

    // Entertainment
    'entertainment': _CategoryMatch('Entertainment', 'movie', '#F4511E', 'expense'),
    'movie': _CategoryMatch('Entertainment', 'movie', '#F4511E', 'expense'),
    'cinema': _CategoryMatch('Entertainment', 'movie', '#F4511E', 'expense'),
    'game': _CategoryMatch('Entertainment', 'movie', '#F4511E', 'expense'),
    'netflix': _CategoryMatch('Entertainment', 'movie', '#F4511E', 'expense'),
    'subscription': _CategoryMatch('Entertainment', 'movie', '#F4511E', 'expense'),

    // Health
    'health': _CategoryMatch('Health', 'medical_services', '#00897B', 'expense'),
    'doctor': _CategoryMatch('Health', 'medical_services', '#00897B', 'expense'),
    'medical': _CategoryMatch('Health', 'medical_services', '#00897B', 'expense'),
    'medicine': _CategoryMatch('Health', 'medical_services', '#00897B', 'expense'),
    'hospital': _CategoryMatch('Health', 'medical_services', '#00897B', 'expense'),
    'dawai': _CategoryMatch('Health', 'medical_services', '#00897B', 'expense'),
    'dawa': _CategoryMatch('Health', 'medical_services', '#00897B', 'expense'),
    'pharmacy': _CategoryMatch('Health', 'medical_services', '#00897B', 'expense'),

    // Bills
    'bill': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'bills': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'electricity': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'bijli': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'rent': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'kiraya': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'recharge': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'wifi': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'internet': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'phone': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'mobile': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'water': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),
    'gas': _CategoryMatch('Bills', 'receipt_long', '#6D4C41', 'expense'),

    // Education
    'education': _CategoryMatch('Education', 'school', '#3949AB', 'expense'),
    'school': _CategoryMatch('Education', 'school', '#3949AB', 'expense'),
    'college': _CategoryMatch('Education', 'school', '#3949AB', 'expense'),
    'tuition': _CategoryMatch('Education', 'school', '#3949AB', 'expense'),
    'fees': _CategoryMatch('Education', 'school', '#3949AB', 'expense'),
    'padhai': _CategoryMatch('Education', 'school', '#3949AB', 'expense'),
    'course': _CategoryMatch('Education', 'school', '#3949AB', 'expense'),
    'books': _CategoryMatch('Education', 'school', '#3949AB', 'expense'),
    'kitab': _CategoryMatch('Education', 'school', '#3949AB', 'expense'),

    // Travel
    'flight': _CategoryMatch('Travel', 'flight', '#039BE5', 'expense'),
    'hotel': _CategoryMatch('Travel', 'flight', '#039BE5', 'expense'),
    'trip': _CategoryMatch('Travel', 'flight', '#039BE5', 'expense'),
    'vacation': _CategoryMatch('Travel', 'flight', '#039BE5', 'expense'),
    'yatra': _CategoryMatch('Travel', 'flight', '#039BE5', 'expense'),
    'tour': _CategoryMatch('Travel', 'flight', '#039BE5', 'expense'),

    // Groceries
    'grocery': _CategoryMatch('Groceries', 'local_grocery_store', '#43A047', 'expense'),
    'groceries': _CategoryMatch('Groceries', 'local_grocery_store', '#43A047', 'expense'),
    'sabzi': _CategoryMatch('Groceries', 'local_grocery_store', '#43A047', 'expense'),
    'ration': _CategoryMatch('Groceries', 'local_grocery_store', '#43A047', 'expense'),
    'vegetables': _CategoryMatch('Groceries', 'local_grocery_store', '#43A047', 'expense'),
    'fruits': _CategoryMatch('Groceries', 'local_grocery_store', '#43A047', 'expense'),
    'milk': _CategoryMatch('Groceries', 'local_grocery_store', '#43A047', 'expense'),
    'doodh': _CategoryMatch('Groceries', 'local_grocery_store', '#43A047', 'expense'),
  };

  static const _incomeKeywords = <String, _CategoryMatch>{
    'salary': _CategoryMatch('Salary', 'payments', '#0A6640', 'income'),
    'tankhwah': _CategoryMatch('Salary', 'payments', '#0A6640', 'income'),
    'naukri': _CategoryMatch('Salary', 'payments', '#0A6640', 'income'),
    'wages': _CategoryMatch('Salary', 'payments', '#0A6640', 'income'),
    'pay': _CategoryMatch('Salary', 'payments', '#0A6640', 'income'),

    'freelance': _CategoryMatch('Freelance', 'laptop', '#1E88E5', 'income'),
    'project': _CategoryMatch('Freelance', 'laptop', '#1E88E5', 'income'),
    'gig': _CategoryMatch('Freelance', 'laptop', '#1E88E5', 'income'),
    'kaam': _CategoryMatch('Freelance', 'laptop', '#1E88E5', 'income'),
    'client': _CategoryMatch('Freelance', 'laptop', '#1E88E5', 'income'),

    'investment': _CategoryMatch('Investment', 'trending_up', '#8E24AA', 'income'),
    'dividend': _CategoryMatch('Investment', 'trending_up', '#8E24AA', 'income'),
    'interest': _CategoryMatch('Investment', 'trending_up', '#8E24AA', 'income'),
    'returns': _CategoryMatch('Investment', 'trending_up', '#8E24AA', 'income'),
    'nivesh': _CategoryMatch('Investment', 'trending_up', '#8E24AA', 'income'),
    'stocks': _CategoryMatch('Investment', 'trending_up', '#8E24AA', 'income'),
    'mutual': _CategoryMatch('Investment', 'trending_up', '#8E24AA', 'income'),

    'gift': _CategoryMatch('Gift', 'card_giftcard', '#F4511E', 'income'),
    'tohfa': _CategoryMatch('Gift', 'card_giftcard', '#F4511E', 'income'),
    'shagun': _CategoryMatch('Gift', 'card_giftcard', '#F4511E', 'income'),
    'bonus': _CategoryMatch('Gift', 'card_giftcard', '#F4511E', 'income'),
  };

  /// Find the best matching category from spoken text.
  static _CategoryMatch? match(String text, {bool isIncome = false}) {
    final words = text.toLowerCase().split(RegExp(r'\s+'));
    final keywords = isIncome ? _incomeKeywords : _expenseKeywords;

    for (final word in words) {
      if (keywords.containsKey(word)) {
        return keywords[word];
      }
    }

    // Try income keywords even for expense context (fallback)
    if (!isIncome) {
      for (final word in words) {
        if (_incomeKeywords.containsKey(word)) {
          return _incomeKeywords[word];
        }
      }
    }
    return null;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 3: NLP COMMAND PARSER
// ─────────────────────────────────────────────────────────────────────────────

class _VoiceCommandParser {

  /// Main entry: parse raw speech text into structured commands.
  /// Supports multi-command splitting on "and" / "aur".
  static List<ParsedVoiceCommand> parse(String rawText) {
    final cleaned = rawText.trim().toLowerCase();
    if (cleaned.isEmpty) return [];

    // Split on " and " or " aur " for multi-commands
    final parts = cleaned.split(RegExp(r'\s+(?:and|aur)\s+'));

    // If first part has context but later parts are bare amounts, inherit context
    final results = <ParsedVoiceCommand>[];
    ParsedVoiceCommand? firstParsed;

    for (int i = 0; i < parts.length; i++) {
      final part = parts[i].trim();
      if (part.isEmpty) continue;

      var parsed = _parseSingle(part);

      // If this is a follow-up fragment with no detected type but has an amount,
      // inherit the type from the first command.
      if (i > 0 && parsed.type == VoiceCommandType.unknown && parsed.amount != null && firstParsed != null) {
        parsed = parsed.copyWith(type: firstParsed.type);
      }

      if (i == 0) firstParsed = parsed;
      results.add(parsed);
    }

    return results;
  }

  /// Parse a single command string.
  static ParsedVoiceCommand _parseSingle(String text) {
    // 1. Check for NAVIGATION
    final nav = _parseNavigation(text);
    if (nav != null) return nav;

    // 2. Check for QUERY
    final query = _parseQuery(text);
    if (query != null) return query;

    // 3. Check for REMINDER
    final reminder = _parseReminder(text);
    if (reminder != null) return reminder;

    // 4. Check for BORROW
    final borrowCmd = _parseBorrow(text);
    if (borrowCmd != null) return borrowCmd;

    // 5. Check for LEND
    final lendCmd = _parseLend(text);
    if (lendCmd != null) return lendCmd;

    // 6. Check for INCOME
    final incomeCmd = _parseIncome(text);
    if (incomeCmd != null) return incomeCmd;

    // 7. Check for EXPENSE (most common, default fallback if amount detected)
    final expenseCmd = _parseExpense(text);
    if (expenseCmd != null) return expenseCmd;

    // 8. Unknown
    return ParsedVoiceCommand(type: VoiceCommandType.unknown, rawText: text);
  }

  // ── AMOUNT EXTRACTION ─────────────────────────────────────────────────────

  static double? _extractAmount(String text) {
    // Pattern: "5k" → 5000, "10k" → 10000
    final kMatch = RegExp(r'(\d+(?:\.\d+)?)\s*k\b', caseSensitive: false).firstMatch(text);
    if (kMatch != null) return (double.tryParse(kMatch.group(1)!) ?? 0) * 1000;

    // Pattern: "5 hundred" / "5 sau"
    final hundredMatch = RegExp(r'(\d+)\s*(?:hundred|sau)\b').firstMatch(text);
    if (hundredMatch != null) return (double.tryParse(hundredMatch.group(1)!) ?? 0) * 100;

    // Pattern: "5 thousand" / "5 hazar" / "5 hazaar"
    final thousandMatch = RegExp(r'(\d+)\s*(?:thousand|hazar|hazaar|hajar)\b').firstMatch(text);
    if (thousandMatch != null) return (double.tryParse(thousandMatch.group(1)!) ?? 0) * 1000;

    // Pattern: "5 lakh" / "5 lac"
    final lakhMatch = RegExp(r'(\d+(?:\.\d+)?)\s*(?:lakh|lac|lakhs)\b').firstMatch(text);
    if (lakhMatch != null) return (double.tryParse(lakhMatch.group(1)!) ?? 0) * 100000;

    // Pattern: plain number "500", "₹450", "rs 300", "rupees 200"
    final plainMatch = RegExp(r'(?:₹|rs\.?\s*|rupees?\s*|rupaye?\s*)?(\d+(?:\.\d+)?)').firstMatch(text);
    if (plainMatch != null) return double.tryParse(plainMatch.group(1)!);

    return null;
  }

  // ── DATE EXTRACTION ───────────────────────────────────────────────────────

  static DateTime? _extractDate(String text) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (RegExp(r'\b(?:today|aaj)\b').hasMatch(text)) return today;
    if (RegExp(r'\b(?:yesterday|kal|beeta\s*kal)\b').hasMatch(text)) {
      return today.subtract(const Duration(days: 1));
    }
    if (RegExp(r'\b(?:day before yesterday|parso|parson)\b').hasMatch(text)) {
      return today.subtract(const Duration(days: 2));
    }
    if (RegExp(r'\b(?:tomorrow|kal)\b').hasMatch(text)) {
      // "kal" can mean yesterday or tomorrow — in expense context it's yesterday,
      // in reminder context it's tomorrow. We handle this in the caller.
      return today.add(const Duration(days: 1));
    }

    // Pattern: "5th July", "10 June", "15 jan", "june 10"
    final months = {
      'jan': 1, 'january': 1, 'feb': 2, 'february': 2, 'mar': 3, 'march': 3,
      'apr': 4, 'april': 4, 'may': 5, 'jun': 6, 'june': 6,
      'jul': 7, 'july': 7, 'aug': 8, 'august': 8, 'sep': 9, 'september': 9,
      'oct': 10, 'october': 10, 'nov': 11, 'november': 11, 'dec': 12, 'december': 12,
    };

    // "5th July" / "5 july" / "july 5"
    final dateMonthMatch = RegExp(r'(\d{1,2})(?:st|nd|rd|th)?\s+(' + months.keys.join('|') + r')\b').firstMatch(text);
    if (dateMonthMatch != null) {
      final day = int.parse(dateMonthMatch.group(1)!);
      final month = months[dateMonthMatch.group(2)!]!;
      var year = now.year;
      var d = DateTime(year, month, day);
      if (d.isBefore(today.subtract(const Duration(days: 180)))) {
        d = DateTime(year + 1, month, day);
      }
      return d;
    }

    final monthDateMatch = RegExp(r'(' + months.keys.join('|') + r')\s+(\d{1,2})(?:st|nd|rd|th)?\b').firstMatch(text);
    if (monthDateMatch != null) {
      final month = months[monthDateMatch.group(1)!]!;
      final day = int.parse(monthDateMatch.group(2)!);
      var year = now.year;
      var d = DateTime(year, month, day);
      if (d.isBefore(today.subtract(const Duration(days: 180)))) {
        d = DateTime(year + 1, month, day);
      }
      return d;
    }

    // "next Monday", "next week"
    final nextDayMatch = RegExp(r'next\s+(monday|tuesday|wednesday|thursday|friday|saturday|sunday)').firstMatch(text);
    if (nextDayMatch != null) {
      final targetDay = {
        'monday': DateTime.monday, 'tuesday': DateTime.tuesday, 'wednesday': DateTime.wednesday,
        'thursday': DateTime.thursday, 'friday': DateTime.friday, 'saturday': DateTime.saturday,
        'sunday': DateTime.sunday,
      }[nextDayMatch.group(1)!]!;
      var d = today.add(const Duration(days: 1));
      while (d.weekday != targetDay) {
        d = d.add(const Duration(days: 1));
      }
      return d;
    }

    // "5th" / "10th" (of current or next month)
    final dayOnlyMatch = RegExp(r'\b(\d{1,2})(?:st|nd|rd|th)\b').firstMatch(text);
    if (dayOnlyMatch != null) {
      final day = int.parse(dayOnlyMatch.group(1)!);
      if (day >= 1 && day <= 31) {
        var d = DateTime(now.year, now.month, day);
        if (d.isBefore(today)) {
          d = DateTime(now.year, now.month + 1, day);
        }
        return d;
      }
    }

    return null;
  }

  // ── PERSON NAME EXTRACTION ────────────────────────────────────────────────

  static String? _extractPersonName(String text) {
    // Patterns: "to Rahul", "from Amit", "Rahul ko", "Amit se"
    final patterns = [
      RegExp(r'\b(?:to|from)\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)', caseSensitive: false),
      RegExp(r'([A-Z][a-z]+)\s+(?:ko|se|ka|ki|ke)\b', caseSensitive: false),
      // "lent Rahul", "borrowed Amit" — name right after verb
      RegExp(r'\b(?:lent|gave|given|borrowed|took)\s+([A-Z][a-z]+)', caseSensitive: false),
      // Hindi: "Rahul ko diya", "Amit se liya"
      RegExp(r'([A-Z][a-z]+)\s+(?:ko\s+(?:diya|de\s+diya|diye)|se\s+(?:liya|le\s+liya|liye))', caseSensitive: false),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        final name = match.group(1)!.trim();
        // Filter out common non-name words
        final nonNames = {'the', 'my', 'his', 'her', 'this', 'that', 'some', 'pay', 'money', 'rupees', 'amount'};
        if (!nonNames.contains(name.toLowerCase()) && name.length > 1) {
          // Capitalize first letter
          return name[0].toUpperCase() + name.substring(1).toLowerCase();
        }
      }
    }
    return null;
  }

  // ── COMMAND-TYPE PARSERS ───────────────────────────────────────────────────

  static ParsedVoiceCommand? _parseNavigation(String text) {
    final navPatterns = <String, String>{
      'dashboard': AppRoutes.dashboard,
      'home': AppRoutes.dashboard,
      'ghar': AppRoutes.dashboard,
      'expense': AppRoutes.addExpense,
      'expenses': AppRoutes.transactions,
      'income': AppRoutes.addIncome,
      'transaction': AppRoutes.transactions,
      'transactions': AppRoutes.transactions,
      'history': AppRoutes.transactions,
      'borrow': AppRoutes.borrowLend,
      'lend': AppRoutes.borrowLend,
      'borrow lend': AppRoutes.borrowLend,
      'reminder': AppRoutes.reminders,
      'reminders': AppRoutes.reminders,
      'setting': AppRoutes.settings,
      'settings': AppRoutes.settings,
    };

    // "open expenses", "go to dashboard", "show reminders", "dikhao history"
    if (RegExp(r'\b(?:open|go\s+to|show|navigate|dikhao|kholo|jaao|chalo)\b').hasMatch(text)) {
      for (final entry in navPatterns.entries) {
        if (text.contains(entry.key)) {
          return ParsedVoiceCommand(
            type: VoiceCommandType.navigate,
            navigationTarget: entry.value,
            rawText: text,
          );
        }
      }
    }
    return null;
  }

  static ParsedVoiceCommand? _parseQuery(String text) {
    final queryPatterns = [
      RegExp(r'\b(?:how much|total|balance|kitna|kitne|dikhao|show me|what is|kya hai)\b'),
      RegExp(r'\b(?:spent|spend|kharch|kharcha|income|kamai|earned)\b.*\b(?:this month|is mahine|today|aaj|this week)\b'),
      RegExp(r'\b(?:highest|lowest|sabse zyada|sabse kam|maximum|minimum)\b'),
      RegExp(r'\b(?:pending|baaki|remaining)\b.*\b(?:borrow|lend|udhar)\b'),
    ];

    for (final pattern in queryPatterns) {
      if (pattern.hasMatch(text)) {
        return ParsedVoiceCommand(
          type: VoiceCommandType.query,
          queryText: text,
          rawText: text,
        );
      }
    }
    return null;
  }

  static ParsedVoiceCommand? _parseReminder(String text) {
    if (!RegExp(r'\b(?:remind|reminder|yaad|yaad dilana|remind karo|notification)\b').hasMatch(text)) {
      return null;
    }

    final amount = _extractAmount(text);
    final date = _extractDate(text) ?? DateTime.now().add(const Duration(days: 1));

    // Extract what to remind about
    String title = text
        .replaceAll(RegExp(r'\b(?:remind me to|remind me|remind|reminder|yaad dilana|yaad dila|remind karo)\b'), '')
        .replaceAll(RegExp(r'\b(?:on|at|by|ko|pe|par)\b\s*\b(?:\d{1,2}(?:st|nd|rd|th)?)\b'), '')
        .replaceAll(RegExp(r'\b(?:tomorrow|kal|parso|today|aaj)\b'), '')
        .replaceAll(RegExp(r'\b(?:jan(?:uary)?|feb(?:ruary)?|mar(?:ch)?|apr(?:il)?|may|jun(?:e)?|jul(?:y)?|aug(?:ust)?|sep(?:tember)?|oct(?:ober)?|nov(?:ember)?|dec(?:ember)?)\b'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (title.isEmpty) title = text;

    // Capitalize first letter
    title = title[0].toUpperCase() + title.substring(1);

    return ParsedVoiceCommand(
      type: VoiceCommandType.reminder,
      amount: amount,
      date: date,
      reminderTitle: title,
      rawText: text,
    );
  }

  static ParsedVoiceCommand? _parseBorrow(String text) {
    if (!RegExp(r'\b(?:borrowed|borrow|took from|owe|liya|udhar liya|le liya|udhaar liya)\b').hasMatch(text)) {
      return null;
    }

    final amount = _extractAmount(text);
    final person = _extractPersonName(text);
    final date = _extractDate(text);

    return ParsedVoiceCommand(
      type: VoiceCommandType.borrow,
      amount: amount,
      personName: person,
      date: date,
      rawText: text,
    );
  }

  static ParsedVoiceCommand? _parseLend(String text) {
    if (!RegExp(r'\b(?:lent|gave|given to|loan|diya|de diya|udhar diya|udhaar diya|diye)\b').hasMatch(text)) {
      return null;
    }
    // Avoid false positive with "remind" containing "diya"
    if (RegExp(r'\b(?:remind|yaad)\b').hasMatch(text)) return null;

    final amount = _extractAmount(text);
    final person = _extractPersonName(text);
    final date = _extractDate(text);

    return ParsedVoiceCommand(
      type: VoiceCommandType.lend,
      amount: amount,
      personName: person,
      date: date,
      rawText: text,
    );
  }

  static ParsedVoiceCommand? _parseIncome(String text) {
    if (!RegExp(r'\b(?:received|earned|got|salary|income|credited|mila|aaya|aayi|tankhwah|kamai|freelance payment)\b').hasMatch(text)) {
      return null;
    }

    final amount = _extractAmount(text);
    final cat = _CategoryMatcher.match(text, isIncome: true);
    final date = _extractDate(text) ?? DateTime.now();

    return ParsedVoiceCommand(
      type: VoiceCommandType.income,
      amount: amount,
      categoryName: cat?.name ?? 'Salary',
      categoryIcon: cat?.icon ?? 'payments',
      categoryColor: cat?.colorHex ?? '#0A6640',
      date: date,
      note: text,
      rawText: text,
    );
  }

  static ParsedVoiceCommand? _parseExpense(String text) {
    final amount = _extractAmount(text);
    if (amount == null) return null; // Must have an amount to be an expense

    // Check if text has expense signals
    final hasExpenseSignal = RegExp(
      r'\b(?:spent|spend|paid|bought|expense|kharch|kharcha|lagaya|diya|kharche|kiya)\b'
    ).hasMatch(text);

    // If no explicit signal but has amount + category keyword, treat as expense
    final cat = _CategoryMatcher.match(text);

    if (!hasExpenseSignal && cat == null) return null;

    final date = _extractDate(text) ?? DateTime.now();

    return ParsedVoiceCommand(
      type: VoiceCommandType.expense,
      amount: amount,
      categoryName: cat?.name ?? 'Other',
      categoryIcon: cat?.icon ?? 'more_horiz',
      categoryColor: cat?.colorHex ?? '#757575',
      date: date,
      note: text,
      rawText: text,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 4: COMMAND EXECUTOR
// ─────────────────────────────────────────────────────────────────────────────

class _VoiceCommandExecutor {
  final WidgetRef ref;
  final BuildContext context;

  _VoiceCommandExecutor(this.ref, this.context);

  /// Execute a parsed command and return a success message.
  Future<String> execute(ParsedVoiceCommand cmd) async {
    final currency = ref.read(settingsProvider).currencySymbol;

    switch (cmd.type) {
      case VoiceCommandType.expense:
        return _executeExpense(cmd, currency);
      case VoiceCommandType.income:
        return _executeIncome(cmd, currency);
      case VoiceCommandType.lend:
        return _executeLend(cmd, currency);
      case VoiceCommandType.borrow:
        return _executeBorrow(cmd, currency);
      case VoiceCommandType.reminder:
        return _executeReminder(cmd, currency);
      case VoiceCommandType.query:
        return _executeQuery(cmd, currency);
      case VoiceCommandType.navigate:
        return _executeNavigation(cmd);
      case VoiceCommandType.unknown:
        return "I didn't quite understand that. Could you try again?";
    }
  }

  Future<String> _executeExpense(ParsedVoiceCommand cmd, String currency) async {
    if (cmd.amount == null) return 'Please specify an amount.';

    final txn = TransactionModel(
      type: 'expense',
      amount: cmd.amount!,
      categoryName: cmd.categoryName ?? 'Other',
      categoryIcon: cmd.categoryIcon ?? 'more_horiz',
      categoryColor: cmd.categoryColor ?? '#757575',
      note: cmd.note,
      date: cmd.date ?? DateTime.now(),
      createdAt: DateTime.now(),
    );
    await ref.read(transactionProvider.notifier).add(txn);
    return '✅ Expense of $currency${cmd.amount!.toStringAsFixed(0)} saved under ${cmd.categoryName ?? "Other"}.';
  }

  Future<String> _executeIncome(ParsedVoiceCommand cmd, String currency) async {
    if (cmd.amount == null) return 'Please specify an amount.';

    final txn = TransactionModel(
      type: 'income',
      amount: cmd.amount!,
      categoryName: cmd.categoryName ?? 'Salary',
      categoryIcon: cmd.categoryIcon ?? 'payments',
      categoryColor: cmd.categoryColor ?? '#0A6640',
      note: cmd.note,
      date: cmd.date ?? DateTime.now(),
      createdAt: DateTime.now(),
    );
    await ref.read(transactionProvider.notifier).add(txn);
    return '✅ Income of $currency${cmd.amount!.toStringAsFixed(0)} saved under ${cmd.categoryName ?? "Salary"}.';
  }

  Future<String> _executeLend(ParsedVoiceCommand cmd, String currency) async {
    if (cmd.amount == null) return 'Please specify an amount.';
    if (cmd.personName == null) return 'Who did you lend to?';

    final item = BorrowLendModel(
      type: 'lend',
      personName: cmd.personName!,
      amount: cmd.amount!,
      note: cmd.note,
      dueDate: cmd.date,
      createdAt: DateTime.now(),
    );
    await ref.read(borrowLendProvider.notifier).add(item);
    return '✅ Recorded: Lent $currency${cmd.amount!.toStringAsFixed(0)} to ${cmd.personName}.';
  }

  Future<String> _executeBorrow(ParsedVoiceCommand cmd, String currency) async {
    if (cmd.amount == null) return 'Please specify an amount.';
    if (cmd.personName == null) return 'Who did you borrow from?';

    final item = BorrowLendModel(
      type: 'borrow',
      personName: cmd.personName!,
      amount: cmd.amount!,
      note: cmd.note,
      dueDate: cmd.date,
      createdAt: DateTime.now(),
    );
    await ref.read(borrowLendProvider.notifier).add(item);
    return '✅ Recorded: Borrowed $currency${cmd.amount!.toStringAsFixed(0)} from ${cmd.personName}.';
  }

  Future<String> _executeReminder(ParsedVoiceCommand cmd, String currency) async {
    final title = cmd.reminderTitle ?? 'Reminder';
    final dueDate = cmd.date ?? DateTime.now().add(const Duration(days: 1));

    final reminder = ReminderModel(
      title: title,
      amount: cmd.amount,
      dueDate: dueDate,
      createdAt: DateTime.now(),
    );
    await ref.read(reminderProvider.notifier).add(reminder, currency);
    final dateStr = DateFormat('MMM d, y').format(dueDate);
    return '✅ Reminder set: "$title" on $dateStr.';
  }

  Future<String> _executeQuery(ParsedVoiceCommand cmd, String currency) async {
    final text = cmd.queryText?.toLowerCase() ?? '';
    final db = DatabaseHelper();

    // "How much did I spend this month?" / "Kitna kharch hua?"
    if (RegExp(r'\b(?:spend|spent|kharch|kharcha|expense)\b').hasMatch(text) &&
        RegExp(r'\b(?:this month|is mahine|month)\b').hasMatch(text)) {
      final totals = await db.getMonthlyTotals(DateTime.now());
      return '📊 You spent $currency${(totals['expense'] ?? 0).toStringAsFixed(0)} this month.';
    }

    // "How much income / earned this month?"
    if (RegExp(r'\b(?:income|earned|kamai|received|mila)\b').hasMatch(text) &&
        RegExp(r'\b(?:this month|is mahine|month)\b').hasMatch(text)) {
      final totals = await db.getMonthlyTotals(DateTime.now());
      return '📊 Your income this month is $currency${(totals['income'] ?? 0).toStringAsFixed(0)}.';
    }

    // "What is my balance?" / "Current balance"
    if (RegExp(r'\b(?:balance|net|baaki|bachaa|kitna hai)\b').hasMatch(text)) {
      final totals = await db.getMonthlyTotals(DateTime.now());
      final income = totals['income'] ?? 0.0;
      final expense = totals['expense'] ?? 0.0;
      final net = income - expense;
      return '📊 This month: Income $currency${income.toStringAsFixed(0)}, Expenses $currency${expense.toStringAsFixed(0)}, Net Balance $currency${net.toStringAsFixed(0)}.';
    }

    // "Show pending borrowings"
    if (RegExp(r'\b(?:pending|baaki|remaining)\b').hasMatch(text) &&
        RegExp(r'\b(?:borrow|lend|udhar|loan)\b').hasMatch(text)) {
      final records = await db.getBorrowLend();
      final pending = records.where((r) => (r['is_paid'] as int) == 0).toList();
      if (pending.isEmpty) return '✅ No pending borrowings or lendings.';
      double totalLent = 0, totalBorrowed = 0;
      for (final r in pending) {
        if (r['type'] == 'lend') {
          totalLent += (r['amount'] as num).toDouble();
        } else {
          totalBorrowed += (r['amount'] as num).toDouble();
        }
      }
      return '📊 Pending: You lent $currency${totalLent.toStringAsFixed(0)} and borrowed $currency${totalBorrowed.toStringAsFixed(0)} across ${pending.length} records.';
    }

    // "How much did I spend today?"
    if (RegExp(r'\b(?:spend|spent|kharch)\b').hasMatch(text) &&
        RegExp(r'\b(?:today|aaj)\b').hasMatch(text)) {
      final dbInstance = await db.database;
      final today = DateTime.now();
      final start = DateTime(today.year, today.month, today.day).toIso8601String();
      final end = DateTime(today.year, today.month, today.day, 23, 59, 59).toIso8601String();
      final result = await dbInstance.rawQuery(
        "SELECT SUM(amount) as total FROM transactions WHERE type = 'expense' AND date >= ? AND date <= ?",
        [start, end],
      );
      final total = (result.first['total'] as num?)?.toDouble() ?? 0.0;
      return '📊 You spent $currency${total.toStringAsFixed(0)} today.';
    }

    // Generic: total expenses
    if (RegExp(r'\b(?:total|kitna|how much)\b').hasMatch(text)) {
      final totals = await db.getMonthlyTotals(DateTime.now());
      final income = totals['income'] ?? 0.0;
      final expense = totals['expense'] ?? 0.0;
      return '📊 This month — Income: $currency${income.toStringAsFixed(0)}, Expenses: $currency${expense.toStringAsFixed(0)}.';
    }

    return '📊 I can tell you about your spending, income, balance, or pending borrowings. Try asking "How much did I spend this month?"';
  }

  Future<String> _executeNavigation(ParsedVoiceCommand cmd) async {
    if (cmd.navigationTarget != null && context.mounted) {
      // Close the voice sheet first
      Navigator.of(context).pop();
      // Small delay for animation, then navigate
      await Future.delayed(const Duration(milliseconds: 200));
      if (context.mounted) {
        GoRouter.of(context).go(cmd.navigationTarget!);
      }
      return '🧭 Navigating...';
    }
    return 'Could not navigate. Please try again.';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 5: WAVEFORM PAINTER
// ─────────────────────────────────────────────────────────────────────────────

class _WaveformPainter extends CustomPainter {
  final double soundLevel; // 0.0 to 1.0
  final double phase;
  final Color primaryColor;
  final Color secondaryColor;

  _WaveformPainter({
    required this.soundLevel,
    required this.phase,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barCount = 40;
    final barWidth = size.width / (barCount * 2);
    final maxBarHeight = size.height * 0.8;
    final centerY = size.height / 2;

    for (int i = 0; i < barCount; i++) {
      final x = (i * 2 + 0.5) * barWidth;
      final normalizedPos = i / barCount;

      // Create natural-looking waveform with multiple sine waves
      final wave1 = sin(normalizedPos * pi * 4 + phase) * 0.5;
      final wave2 = sin(normalizedPos * pi * 2.5 + phase * 1.3) * 0.3;
      final wave3 = sin(normalizedPos * pi * 6 + phase * 0.7) * 0.2;
      final combined = (wave1 + wave2 + wave3).abs();

      // Scale by sound level with minimum height
      final minHeight = 3.0;
      final barHeight = max(minHeight, combined * maxBarHeight * soundLevel);

      // Gradient color per bar
      final t = normalizedPos;
      final color = Color.lerp(primaryColor, secondaryColor, t)!.withOpacity(0.6 + soundLevel * 0.4);

      final paint = Paint()
        ..color = color
        ..strokeCap = StrokeCap.round
        ..strokeWidth = barWidth * 0.8;

      canvas.drawLine(
        Offset(x, centerY - barHeight / 2),
        Offset(x, centerY + barHeight / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_WaveformPainter oldDelegate) =>
      oldDelegate.soundLevel != soundLevel || oldDelegate.phase != phase;
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 6: VOICE ASSISTANT SCREEN (MAIN UI)
// ─────────────────────────────────────────────────────────────────────────────

class VoiceAssistantScreen extends ConsumerStatefulWidget {
  final bool autoStart;
  const VoiceAssistantScreen({super.key, this.autoStart = false});

  @override
  ConsumerState<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends ConsumerState<VoiceAssistantScreen>
    with TickerProviderStateMixin {

  final SpeechToText _speech = SpeechToText();
  bool _speechAvailable = false;

  VoiceAssistantPhase _phase = VoiceAssistantPhase.idle;
  String _transcription = '';
  String _responseText = '';
  List<ParsedVoiceCommand> _parsedCommands = [];
  int _currentCommandIndex = 0;
  double _soundLevel = 0.0;

  // Animations
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late AnimationController _successController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _successAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _successAnimation = CurvedAnimation(parent: _successController, curve: Curves.elasticOut);

    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechAvailable = await _speech.initialize(
      onError: (error) {
        if (mounted) {
          setState(() {
            _phase = VoiceAssistantPhase.idle;
            if (error.errorMsg == 'error_no_match') {
              _responseText = "I didn't catch that. Tap the mic and try again.";
              _phase = VoiceAssistantPhase.error;
            }
          });
        }
      },
      onStatus: (status) {
        if (status == 'done' && mounted && _phase == VoiceAssistantPhase.listening) {
          _onSpeechDone();
        }
      },
    );
    if (widget.autoStart && _speechAvailable && mounted) {
      await Future.delayed(const Duration(milliseconds: 300));
      _startListening();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    _successController.dispose();
    _speech.stop();
    super.dispose();
  }

  void _startListening() async {
    if (!_speechAvailable) {
      setState(() {
        _phase = VoiceAssistantPhase.error;
        _responseText = 'Speech recognition is not available on this device. Please check microphone permissions.';
      });
      return;
    }

    HapticFeedback.mediumImpact();
    setState(() {
      _phase = VoiceAssistantPhase.listening;
      _transcription = '';
      _soundLevel = 0.0;
      _parsedCommands = [];
    });

    await _speech.listen(
      onResult: _onSpeechResult,
      onSoundLevelChange: (level) {
        if (mounted) {
          setState(() {
            // Normalize: speech_to_text gives -2 to 10 dB typically
            _soundLevel = ((level + 2) / 12).clamp(0.0, 1.0);
          });
        }
      },
      listenFor: const Duration(seconds: 15),
      pauseFor: const Duration(seconds: 3),
      localeId: 'en_IN', // English (India) — works well with Hinglish
      cancelOnError: false,
      partialResults: true,
    );
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (!mounted) return;
    setState(() {
      _transcription = result.recognizedWords;
    });
  }

  void _onSpeechDone() {
    if (_transcription.isEmpty) {
      setState(() {
        _phase = VoiceAssistantPhase.error;
        _responseText = "I didn't hear anything. Tap the mic and speak clearly.";
      });
      return;
    }

    setState(() => _phase = VoiceAssistantPhase.processing);

    // Simulate slight processing delay for UX
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      final commands = _VoiceCommandParser.parse(_transcription);

      if (commands.isEmpty || (commands.length == 1 && commands.first.type == VoiceCommandType.unknown)) {
        setState(() {
          _phase = VoiceAssistantPhase.error;
          _responseText = "I didn't understand \"$_transcription\". Try saying something like \"Spent 500 on lunch\" or \"Open dashboard\".";
        });
        return;
      }

      setState(() {
        _parsedCommands = commands;
        _currentCommandIndex = 0;
        // For navigation and query, execute immediately
        if (commands.length == 1 &&
            (commands.first.type == VoiceCommandType.navigate ||
             commands.first.type == VoiceCommandType.query)) {
          _executeCurrentCommand();
        } else {
          _phase = VoiceAssistantPhase.confirmation;
        }
      });
    });
  }

  void _stopListening() {
    _speech.stop();
  }

  void _executeCurrentCommand() async {
    if (_currentCommandIndex >= _parsedCommands.length) return;

    final cmd = _parsedCommands[_currentCommandIndex];
    final executor = _VoiceCommandExecutor(ref, context);

    // For queries and navigation, skip confirmation
    setState(() => _phase = VoiceAssistantPhase.processing);

    final result = await executor.execute(cmd);

    if (!mounted) return;

    HapticFeedback.lightImpact();
    _successController.forward(from: 0);

    setState(() {
      _responseText = result;
      _phase = VoiceAssistantPhase.success;
    });

    // If there are more commands, auto-advance after delay
    if (_currentCommandIndex < _parsedCommands.length - 1) {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() {
          _currentCommandIndex++;
          _phase = VoiceAssistantPhase.confirmation;
        });
      }
    }
  }

  void _confirmAndExecute() {
    _executeCurrentCommand();
  }

  void _skipCommand() {
    if (_currentCommandIndex < _parsedCommands.length - 1) {
      setState(() {
        _currentCommandIndex++;
      });
    } else {
      setState(() => _phase = VoiceAssistantPhase.idle);
    }
  }

  void _resetToIdle() {
    setState(() {
      _phase = VoiceAssistantPhase.idle;
      _transcription = '';
      _responseText = '';
      _parsedCommands = [];
      _currentCommandIndex = 0;
      _soundLevel = 0.0;
    });
  }

  // ── BUILD ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0D1B3E), Color(0xFF091428)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            // Handle bar
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            // Header
            _buildHeader(),
            const SizedBox(height: 8),
            // Main content area (animates between phases)
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _buildContent(),
            ),
            const SizedBox(height: 16),
            // Mic button
            _buildMicButton(),
            const SizedBox(height: 16),
            // Quick actions (only in idle state)
            if (_phase == VoiceAssistantPhase.idle || _phase == VoiceAssistantPhase.success)
              _buildQuickActions(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    String title;
    String subtitle;
    IconData icon;

    switch (_phase) {
      case VoiceAssistantPhase.idle:
        title = 'Hey, I\'m Buddy!';
        subtitle = 'Your personal finance assistant';
        icon = Icons.auto_awesome;
      case VoiceAssistantPhase.listening:
        title = 'Listening...';
        subtitle = 'Speak naturally';
        icon = Icons.hearing;
      case VoiceAssistantPhase.processing:
        title = 'Processing...';
        subtitle = 'Understanding your command';
        icon = Icons.psychology;
      case VoiceAssistantPhase.confirmation:
        title = 'Confirm Action';
        subtitle = 'Review and save';
        icon = Icons.fact_check_rounded;
      case VoiceAssistantPhase.success:
        title = 'Done!';
        subtitle = '';
        icon = Icons.check_circle;
      case VoiceAssistantPhase.error:
      case VoiceAssistantPhase.clarification:
        title = 'Oops!';
        subtitle = '';
        icon = Icons.help_outline;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2BC6FF), Color(0xFF0A3F97)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
              ],
            ),
          ),
          if (_phase != VoiceAssistantPhase.idle)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white38, size: 20),
              onPressed: _resetToIdle,
            ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_phase) {
      case VoiceAssistantPhase.idle:
        return _buildIdleContent();
      case VoiceAssistantPhase.listening:
        return _buildListeningContent();
      case VoiceAssistantPhase.processing:
        return _buildProcessingContent();
      case VoiceAssistantPhase.confirmation:
        return _buildConfirmationContent();
      case VoiceAssistantPhase.success:
        return _buildSuccessContent();
      case VoiceAssistantPhase.error:
      case VoiceAssistantPhase.clarification:
        return _buildErrorContent();
    }
  }

  Widget _buildIdleContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          const SizedBox(height: 8),
          // Suggestion chips
          Text(
            'Try saying:',
            style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.4), fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _suggestionChip('"Spent 500 on lunch"'),
              _suggestionChip('"Salary credited 45000"'),
              _suggestionChip('"I lent Rahul 5000"'),
              _suggestionChip('"How much did I spend?"'),
              _suggestionChip('"Remind me to pay rent"'),
              _suggestionChip('"Open dashboard"'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _suggestionChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.5), fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget _buildListeningContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          // Waveform
          SizedBox(
            height: 80,
            child: AnimatedBuilder(
              animation: _waveController,
              builder: (context, _) {
                return CustomPaint(
                  size: const Size(double.infinity, 80),
                  painter: _WaveformPainter(
                    soundLevel: _soundLevel,
                    phase: _waveController.value * pi * 2,
                    primaryColor: const Color(0xFF2BC6FF),
                    secondaryColor: const Color(0xFF0A3F97),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Live transcription
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: _transcription.isNotEmpty ? 16 : 14,
              color: _transcription.isNotEmpty ? Colors.white : Colors.white38,
              fontWeight: _transcription.isNotEmpty ? FontWeight.w500 : FontWeight.w400,
            ),
            child: Text(
              _transcription.isNotEmpty ? _transcription : 'Listening...',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildProcessingContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          SizedBox(
            width: 32, height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation(Colors.white.withOpacity(0.6)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '"$_transcription"',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.5), fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationContent() {
    if (_parsedCommands.isEmpty || _currentCommandIndex >= _parsedCommands.length) {
      return const SizedBox.shrink();
    }

    final cmd = _parsedCommands[_currentCommandIndex];
    final currency = ref.watch(settingsProvider).currencySymbol;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          // Multi-command indicator
          if (_parsedCommands.length > 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Command ${_currentCommandIndex + 1} of ${_parsedCommands.length}',
                style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.4)),
              ),
            ),

          // Confirmation card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type badge
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _colorForType(cmd.type).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _labelForType(cmd.type),
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _colorForType(cmd.type)),
                      ),
                    ),
                    const Spacer(),
                    Icon(_iconForType(cmd.type), color: _colorForType(cmd.type), size: 24),
                  ],
                ),
                const SizedBox(height: 16),

                // Amount
                if (cmd.amount != null) ...[
                  Text('Amount', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.4))),
                  const SizedBox(height: 2),
                  Text(
                    '$currency${cmd.amount!.toStringAsFixed(cmd.amount! % 1 == 0 ? 0 : 2)}',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                ],

                // Category / Person / Reminder title
                if (cmd.categoryName != null && (cmd.type == VoiceCommandType.expense || cmd.type == VoiceCommandType.income)) ...[
                  _detailRow('Category', cmd.categoryName!),
                ],
                if (cmd.personName != null) ...[
                  _detailRow('Person', cmd.personName!),
                ],
                if (cmd.reminderTitle != null) ...[
                  _detailRow('Title', cmd.reminderTitle!),
                ],

                // Date
                if (cmd.date != null) ...[
                  _detailRow('Date', DateFormat('EEE, MMM d, y').format(cmd.date!)),
                ],
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _skipCommand,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white54,
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: FilledButton(
                  onPressed: _confirmAndExecute,
                  style: FilledButton.styleFrom(
                    backgroundColor: _colorForType(cmd.type),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_rounded, size: 18),
                      const SizedBox(width: 6),
                      Text('Confirm & Save', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(label, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.4))),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          ScaleTransition(
            scale: _successAnimation,
            child: Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF0A6640).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, color: Color(0xFF4CAF50), size: 32),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _responseText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.help_outline_rounded, color: Colors.orangeAccent, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            _responseText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.7), height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildMicButton() {
    final isListening = _phase == VoiceAssistantPhase.listening;
    final showMic = _phase == VoiceAssistantPhase.idle ||
                    _phase == VoiceAssistantPhase.listening ||
                    _phase == VoiceAssistantPhase.error ||
                    _phase == VoiceAssistantPhase.success;

    if (!showMic) return const SizedBox.shrink();

    return GestureDetector(
      onTap: isListening ? _stopListening : _startListening,
      onLongPress: () {
        if (!isListening) _startListening();
      },
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          final scale = isListening ? _pulseAnimation.value : 1.0;
          return Transform.scale(
            scale: scale,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isListening
                      ? [const Color(0xFFE53935), const Color(0xFFC62828)]
                      : [const Color(0xFF2BC6FF), const Color(0xFF0A3F97)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isListening ? const Color(0xFFE53935) : const Color(0xFF2BC6FF)).withOpacity(0.3),
                    blurRadius: isListening ? 24 : 16,
                    spreadRadius: isListening ? 4 : 2,
                  ),
                ],
              ),
              child: Icon(
                isListening ? Icons.stop_rounded : Icons.mic_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Divider(color: Colors.white.withOpacity(0.08)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _quickAction(Icons.arrow_upward_rounded, 'Expense', AppColors.expense, () {
                Navigator.pop(context);
                context.push(AppRoutes.addExpense);
              }),
              _quickAction(Icons.arrow_downward_rounded, 'Income', AppColors.income, () {
                Navigator.pop(context);
                context.push(AppRoutes.addIncome);
              }),
              _quickAction(Icons.handshake_rounded, 'Borrow', AppColors.lend, () {
                Navigator.pop(context);
                context.push(AppRoutes.addBorrowLend);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 6),
          Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // ── HELPERS ────────────────────────────────────────────────────────────────

  Color _colorForType(VoiceCommandType type) {
    switch (type) {
      case VoiceCommandType.expense: return const Color(0xFFE53935);
      case VoiceCommandType.income: return const Color(0xFF4CAF50);
      case VoiceCommandType.lend: return const Color(0xFF1E88E5);
      case VoiceCommandType.borrow: return const Color(0xFFFF9800);
      case VoiceCommandType.reminder: return const Color(0xFF9C27B0);
      case VoiceCommandType.query: return const Color(0xFF2BC6FF);
      case VoiceCommandType.navigate: return const Color(0xFF78909C);
      case VoiceCommandType.unknown: return Colors.grey;
    }
  }

  String _labelForType(VoiceCommandType type) {
    switch (type) {
      case VoiceCommandType.expense: return 'EXPENSE';
      case VoiceCommandType.income: return 'INCOME';
      case VoiceCommandType.lend: return 'LENT';
      case VoiceCommandType.borrow: return 'BORROWED';
      case VoiceCommandType.reminder: return 'REMINDER';
      case VoiceCommandType.query: return 'QUERY';
      case VoiceCommandType.navigate: return 'NAVIGATE';
      case VoiceCommandType.unknown: return 'UNKNOWN';
    }
  }

  IconData _iconForType(VoiceCommandType type) {
    switch (type) {
      case VoiceCommandType.expense: return Icons.arrow_upward_rounded;
      case VoiceCommandType.income: return Icons.arrow_downward_rounded;
      case VoiceCommandType.lend: return Icons.send_rounded;
      case VoiceCommandType.borrow: return Icons.call_received_rounded;
      case VoiceCommandType.reminder: return Icons.notifications_active_rounded;
      case VoiceCommandType.query: return Icons.analytics_rounded;
      case VoiceCommandType.navigate: return Icons.open_in_new_rounded;
      case VoiceCommandType.unknown: return Icons.help_outline;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION 7: STATIC HELPER — Open Voice Assistant from anywhere
// ─────────────────────────────────────────────────────────────────────────────

/// Call this from any screen to open the voice assistant as a bottom sheet.
void showVoiceAssistant(BuildContext context, {bool autoStart = false}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return VoiceAssistantScreen(autoStart: autoStart);
      },
    ),
  );
}
