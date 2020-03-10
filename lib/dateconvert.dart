String convertDate(date) {
    String weekday = dayOfWeek(date);
    String month = monthName(date);
    return "$weekday, $month ${DateTime.fromMillisecondsSinceEpoch(date).day}";
  }
String convertDateYear(date) {
    String weekday = dayOfWeek(date);
    String month = monthName(date);
    return "$weekday, $month ${DateTime.fromMillisecondsSinceEpoch(date).day}, ${DateTime.fromMillisecondsSinceEpoch(date).year}";
  }

  String dayOfWeek(date) {
    switch(DateTime.fromMillisecondsSinceEpoch(date).weekday) {
      case 1: {return "Monday";}
      case 2: {return "Tuesday";}
      case 3: {return "Wednesday";}
      case 4: {return "Thursday";}
      case 5: {return "Friday";}
      case 6: {return "Saturday";}
      case 7: {return "Sunday";}
    }
  }
    String monthName(date) {
    switch(DateTime.fromMillisecondsSinceEpoch(date).month) {
      case 1: {return "January";}
      case 2: {return "February";}
      case 3: {return "March";}
      case 4: {return "April";}
      case 5: {return "May";}
      case 7: {return "July";}
      case 8: {return "August";}
      case 9: {return "September";}
      case 10: {return "October";}
      case 11: {return "November";}
      case 12: {return "December";}
    }
  }