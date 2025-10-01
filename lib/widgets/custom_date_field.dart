import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viva_home_mobile/utils/constants.dart';

enum DateInputMode { ddmmyy, mmyy, ddmm, dd, mm, yy }

class CustomDateFormField extends FormField<DateTime?> {
  CustomDateFormField({
    super.key,
    required DateInputMode mode,
    String hint = '',
    super.initialValue,
    super.onSaved,
    super.validator,
    ValueChanged<DateTime?>? onChanged,
    bool enabled = true,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         builder: (FormFieldState<DateTime?> field) {
           return _CustomDateField(
             field: field,
             mode: mode,
             hint: hint,
             onChanged: onChanged,
             enabled: enabled,
           );
         },
       );
}

class _CustomDateField extends StatefulWidget {
  final FormFieldState<DateTime?> field;
  final DateInputMode mode;
  final String hint;
  final ValueChanged<DateTime?>? onChanged;
  final bool enabled;

  const _CustomDateField({
    required this.field,
    required this.mode,
    required this.hint,
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<_CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<_CustomDateField> {
  final dayCtrl = TextEditingController();
  final monthCtrl = TextEditingController();
  final yearCtrl = TextEditingController();

  final dayFocus = FocusNode();
  final monthFocus = FocusNode();
  final yearFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    dayFocus.addListener(_onFocusChange);
    monthFocus.addListener(_onFocusChange);
    yearFocus.addListener(_onFocusChange);

    if (widget.field.value != null) {
      final d = widget.field.value!;
      dayCtrl.text = d.day.toString().padLeft(2, '0');
      monthCtrl.text = d.month.toString().padLeft(2, '0');
      yearCtrl.text = d.year.toString();
    }
  }

  void _onFocusChange() {
    setState(() {
    });
  }

  @override
  void dispose() {
  
    dayFocus.removeListener(_onFocusChange);
    monthFocus.removeListener(_onFocusChange);
    yearFocus.removeListener(_onFocusChange);

    dayCtrl.dispose();
    monthCtrl.dispose();
    yearCtrl.dispose();
    dayFocus.dispose();
    monthFocus.dispose();
    yearFocus.dispose();
    super.dispose();
  }

  void _validateAndUpdate() {
    int? dd = int.tryParse(dayCtrl.text);
    int? mm = int.tryParse(monthCtrl.text);
    int? yy = int.tryParse(yearCtrl.text);

    // Handle 2-digit year conversion for mmyy mode
    if (widget.mode == DateInputMode.mmyy && yy != null) {
      if (yy < 100) {
        // For 2-digit years: 00-30 = 2000-2030, 31-99 = 1931-1999
        yy = yy <= 30 ? 2000 + yy : 1900 + yy;
      }
    }

    final currentYear = DateTime.now().year;
    if (yy != null && (yy < 1900 || yy > currentYear)) {
      widget.field.didChange(null);
      widget.onChanged?.call(null);
      return;
    }

    if (mm != null && (mm < 1 || mm > 12)) {
      widget.field.didChange(null);
      widget.onChanged?.call(null);
      return;
    }

    if (dd != null && mm != null) {
      int maxDay = _daysInMonth(mm, yy ?? 2000);
      if (dd > maxDay) {
        dd = maxDay;
        dayCtrl.text = dd.toString().padLeft(2, '0');
        dayCtrl.selection = TextSelection.fromPosition(
          TextPosition(offset: dayCtrl.text.length),
        );
      }
    }

    // Validate day range
    if (dd != null && (dd < 1 || dd > 31)) {
      widget.field.didChange(null);
      widget.onChanged?.call(null);
      return;
    }

    try {
      if ((widget.mode == DateInputMode.ddmmyy &&
              dd != null &&
              mm != null &&
              yy != null) ||
          (widget.mode == DateInputMode.mmyy && mm != null && yy != null) ||
          (widget.mode == DateInputMode.ddmm && dd != null && mm != null) ||
          (widget.mode == DateInputMode.dd && dd != null) ||
          (widget.mode == DateInputMode.mm && mm != null) ||
          (widget.mode == DateInputMode.yy && yy != null)) {
        final dateTime = DateTime(yy ?? 2000, mm ?? 1, dd ?? 1);
        widget.field.didChange(dateTime);
        widget.onChanged?.call(dateTime);
      } else {
        widget.field.didChange(null);
        widget.onChanged?.call(null);
      }
    } catch (_) {
      widget.field.didChange(null);
      widget.onChanged?.call(null);
    }
  }

  int _daysInMonth(int month, int year) {
    if (month == 2) return _isLeapYear(year) ? 29 : 28;
    if ([4, 6, 9, 11].contains(month)) return 30;
    return 31;
  }

  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  TextInputFormatter _dayFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) return newValue;
      
      final intValue = int.tryParse(newValue.text);
      if (intValue == null) return oldValue;
      
      // First digit must be 0, 1, 2, or 3
      if (newValue.text.length == 1) {
        if (intValue >= 0 && intValue <= 3) return newValue;
        return oldValue;
      }
      
      // Complete value must be 01-31
      if (newValue.text.length == 2) {
        if (intValue >= 1 && intValue <= 31) return newValue;
        return oldValue;
      }
      
      return oldValue;
    });
  }

  TextInputFormatter _monthFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) return newValue;
      
      final intValue = int.tryParse(newValue.text);
      if (intValue == null) return oldValue;
      
      // First digit must be 0 or 1
      if (newValue.text.length == 1) {
        if (intValue >= 0 && intValue <= 1) return newValue;
        return oldValue;
      }
      
      // Complete value must be 01-12
      if (newValue.text.length == 2) {
        if (intValue >= 1 && intValue <= 12) return newValue;
        return oldValue;
      }
      
      return oldValue;
    });
  }

  TextInputFormatter _yearFormatter() {
    final currentYear = DateTime.now().year;
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) return newValue;
      
      final intValue = int.tryParse(newValue.text);
      if (intValue == null) return oldValue;
      
      if (widget.mode == DateInputMode.mmyy && newValue.text.length <= 2) {
        if (intValue >= 0 && intValue <= 99) return newValue;
        return oldValue;
      }

      if (newValue.text.length < 4) {
        final partialYear = newValue.text.padRight(4, '0');
        final partialInt = int.parse(partialYear);
        if (partialInt >= 1900) return newValue;
        return oldValue;
      }
      
      // Complete value must be 1900-current year
      if (newValue.text.length == 4) {
        if (intValue >= 1900 && intValue <= currentYear) return newValue;
        return oldValue;
      }
      
      return oldValue;
    });
  }

  Widget _buildField({
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required int maxLength,
    FocusNode? nextFocus,
    required String fieldType, // 'day', 'month', 'year'
  }) {
    List<TextInputFormatter> formatters = [
      LengthLimitingTextInputFormatter(maxLength),
      FilteringTextInputFormatter.digitsOnly,
    ];
    
    switch (fieldType) {
      case 'day':
        formatters.add(_dayFormatter());
        break;
      case 'month':
        formatters.add(_monthFormatter());
        break;
      case 'year':
        formatters.add(_yearFormatter());
        break;
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: widget.field.hasError
                ? AppColors.error
                : (focusNode.hasFocus
                      ? AppColors.primaryTeal
                      : AppColors.lightGray),
            width: widget.field.hasError ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(
            AppSizes.radius(context, SizeCategory.medium),
          ),
        ),
        width: maxLength == 4
            ? AppSizes.container(context, SizeCategory.medium)
            : AppSizes.container(context, SizeCategory.medium) * 0.7,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: widget.enabled,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: AppSizes.font(context, SizeCategory.medium),
          ),
          inputFormatters: formatters,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: AppSizes.font(context, SizeCategory.medium),
              color: AppColors.darkGray,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding(context, SizeCategory.small),
              vertical: AppSizes.padding(context, SizeCategory.medium),
            ),
          ),
          onChanged: (val) {
            if (val.length == maxLength && nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            }
            _validateAndUpdate();
          },
          onSubmitted: (val) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              focusNode.unfocus();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fields = [];

    switch (widget.mode) {
      case DateInputMode.ddmmyy:
        fields = [
          _buildField(
            hint: "DD",
            controller: dayCtrl,
            focusNode: dayFocus,
            maxLength: 2,
            nextFocus: monthFocus,
            fieldType: 'day',
          ),
          SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
          _buildField(
            hint: "MM",
            controller: monthCtrl,
            focusNode: monthFocus,
            maxLength: 2,
            nextFocus: yearFocus,
            fieldType: 'month',
          ),
          SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
          _buildField(
            hint: "YYYY",
            controller: yearCtrl,
            focusNode: yearFocus,
            maxLength: 4,
            fieldType: 'year',
          ),
        ];
        break;
      case DateInputMode.mmyy:
        fields = [
          _buildField(
            hint: "MM",
            controller: monthCtrl,
            focusNode: monthFocus,
            maxLength: 2,
            nextFocus: yearFocus,
            fieldType: 'month',
          ),
          SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
          _buildField(
            hint: "YY/YYYY",
            controller: yearCtrl,
            focusNode: yearFocus,
            maxLength: 4,
            fieldType: 'year',
          ),
        ];
        break;
      case DateInputMode.ddmm:
        fields = [
          _buildField(
            hint: "DD",
            controller: dayCtrl,
            focusNode: dayFocus,
            maxLength: 2,
            nextFocus: monthFocus,
            fieldType: 'day',
          ),
          SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
          _buildField(
            hint: "MM",
            controller: monthCtrl,
            focusNode: monthFocus,
            maxLength: 2,
            fieldType: 'month',
          ),
        ];
        break;
      case DateInputMode.dd:
        fields = [
          _buildField(
            hint: "DD",
            controller: dayCtrl,
            focusNode: dayFocus,
            maxLength: 2,
            fieldType: 'day',
          ),
        ];
        break;
      case DateInputMode.mm:
        fields = [
          _buildField(
            hint: "MM",
            controller: monthCtrl,
            focusNode: monthFocus,
            maxLength: 2,
            fieldType: 'month',
          ),
        ];
        break;
      case DateInputMode.yy:
        fields = [
          _buildField(
            hint: "YYYY",
            controller: yearCtrl,
            focusNode: yearFocus,
            maxLength: 4,
            fieldType: 'year',
          ),
        ];
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [...fields]),
        if (widget.field.hasError)
          Padding(
            padding: EdgeInsets.only(
              top: AppSizes.container(context, SizeCategory.small) * 0.25,
            ),
            child: Text(
              widget.field.errorText ?? "",
              style: TextStyle(
                color: AppColors.error,
                fontSize: AppSizes.font(context, SizeCategory.medium),
              ),
            ),
          ),
      ],
    );
  }
}
