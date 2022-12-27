import 'package:flutter/material.dart';
import 'package:gift_manager/resources/app_colors.dart';

final _base = ThemeData.light();

final lightTheme = _base.copyWith(
  backgroundColor: AppColors.lightWhite100,
  textTheme: _base.textTheme.copyWith(
    headline1: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.lightBlack100,
    ),
    headline2: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.lightBlack100,
    ),
    headline3: const TextStyle(
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.w500,
      color: AppColors.lightBlack100,
    ),
    headline4: const TextStyle(
      fontSize: 14,
      height: 1.15,
      fontWeight: FontWeight.w500,
      color: AppColors.lightBlack100,
    ),
    headline5: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.lightBlack100,
    ),
    headline6: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.lightBlack100,
    ),
    button: const TextStyle(
      fontSize: 14,
      height: 1.15,
      fontWeight: FontWeight.w700,
      color: AppColors.lightBlack100,
    ),
  ),
);
