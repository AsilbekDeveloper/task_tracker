import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  // ========================
  // Brand Colors
  // ========================

  static const Color brandPrimary = Color(0xFF8875FF);
  static const Color brandDanger = Color(0xFFFF4949);

  // ========================
  // Neutral - Light Theme
  // ========================

  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF5F5F5);
  static const Color lightBorder = Color(0xFF979797);
  static const Color lightOnSurface = Color(0xFF000000);
  static const Color lightOnSurfaceVariant = Color(0xFF535353);
  static const Color lightDisabled = Color(0x61000000);

  // ========================
  // Neutral - Dark Theme
  // ========================

  static const Color darkSurface = Color(0xFF121212);
  static const Color darkSurfaceVariant = Color(0xFF1D1D1D);
  static const Color darkContainer = Color(0xFF272727);
  static const Color darkBorder = Color(0xFF363636);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkOnSurfaceVariant = Color(0xFFAFAFAF);
  static const Color darkDisabled = Color(0x80FFFFFF);

  // ========================
  // Overlay / Effects
  // ========================

  static const Color whiteOverlayLow = Color(0x36FFFFFF);
  static const Color whiteOverlayMedium = Color(0x70FFFFFF);
}