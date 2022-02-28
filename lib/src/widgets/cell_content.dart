// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../customization/calendar_builders.dart';
import '../customization/calendar_style.dart';

class CellContent extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final dynamic locale;
  final bool isTodayHighlighted;
  final bool isToday;
  final bool isSelected;
  final bool isClosed;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isWithinRange;
  final bool isOutside;
  final bool isDisabled;
  final bool isHoliday;
  final bool isWeekend;
  final bool isScheduled;
  final CalendarStyle calendarStyle;
  final CalendarBuilders calendarBuilders;

  const CellContent({
    Key? key,
    required this.day,
    required this.focusedDay,
    required this.calendarStyle,
    required this.calendarBuilders,
    required this.isTodayHighlighted,
    required this.isToday,
    required this.isSelected,
    required this.isRangeStart,
    required this.isRangeEnd,
    required this.isWithinRange,
    required this.isOutside,
    required this.isDisabled,
    required this.isHoliday,
    required this.isWeekend,
    required this.isScheduled,
    required this.isClosed,
    this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dowLabel = DateFormat.EEEE(locale).format(day);
    final dayLabel = DateFormat.yMMMMd(locale).format(day);
    final semanticsLabel = '$dowLabel, $dayLabel';

    Widget? cell =
    calendarBuilders.prioritizedBuilder?.call(context, day, focusedDay);

    if (cell != null) {
      return Semantics(
        label: semanticsLabel,
        excludeSemantics: true,
        child: cell,
      );
    }

    final text = '${day.day}';
    final margin = calendarStyle.cellMargin;
    final padding = calendarStyle.cellPadding;
    final alignment = calendarStyle.cellAlignment;
    final duration = const Duration(milliseconds: 250);

    if (isDisabled) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.disabledDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.disabledTextStyle),
          );
    } else if (isSelected) {
      Decoration _calendarStyle;
      TextStyle _textStyle;
      if(isClosed) {
        _calendarStyle = calendarStyle.selectedAndClosedDecoration;
        _textStyle = calendarStyle.todayTextStyle;
      }
      else if(isScheduled) {
        _calendarStyle = calendarStyle.selectedAndScheduledDecoration;
        _textStyle = calendarStyle.todayTextStyle;
      }
      else {
        _calendarStyle = calendarStyle.selectedDecoration;
        _textStyle = calendarStyle.selectedTextStyle;
      }

      cell = calendarBuilders.selectedBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: _calendarStyle,
            alignment: Alignment.center,
            child: Text(text, style: _textStyle),
          );
    } else if (isRangeStart) {
      cell =
          calendarBuilders.rangeStartBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                decoration: calendarStyle.rangeStartDecoration,
                alignment: Alignment.center,
                child: Text(text, style: calendarStyle.rangeStartTextStyle),
              );
    } else if (isRangeEnd) {
      cell = calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.rangeEndDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.rangeEndTextStyle),
          );
    } else if (isToday && isTodayHighlighted) {
      Decoration _calendarStyle;
      TextStyle _textStyle;
      if(isClosed) {
        _calendarStyle = calendarStyle.todayAndClosedDecoration;
        _textStyle = calendarStyle.todayTextStyle;
      }
      else if(isScheduled) {
        _calendarStyle = calendarStyle.todayAndScheduledDecoration;
        _textStyle = calendarStyle.todayTextStyle;
      }
      else {
        _calendarStyle = calendarStyle.todayDecoration;
        _textStyle = calendarStyle.todayTextStyle;
      }

      cell = calendarBuilders.todayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: _calendarStyle,
            alignment: Alignment.center,
            child: Text(text, style: _textStyle),
          );
    }else if(isClosed) {
      cell = calendarBuilders.todayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.closedDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.todayTextStyle),
          );
    }
    else if(isScheduled) {
      cell = calendarBuilders.todayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.scheduledDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.todayTextStyle),
          );
    } else if (isHoliday) {
      cell = calendarBuilders.holidayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.holidayDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.holidayTextStyle),
          );
    } else if (isWithinRange) {
      cell =
          calendarBuilders.withinRangeBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                decoration: calendarStyle.withinRangeDecoration,
                alignment: Alignment.center,
                child: Text(text, style: calendarStyle.withinRangeTextStyle),
              );
    } else if (isOutside) {
      cell = calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.outsideDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.outsideTextStyle),
          );
    } else {
      cell = calendarBuilders.defaultBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: isWeekend
                ? calendarStyle.weekendDecoration
                : calendarStyle.defaultDecoration,
            alignment: Alignment.center,
            child: Text(
              text,
              style: isWeekend
                  ? calendarStyle.weekendTextStyle
                  : calendarStyle.defaultTextStyle,
            ),
          );
    }

    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: cell,
    );
  }
}
