library naig.time;

import 'package:naig/util.dart';

class Date implements Savable {
    static final int kWeeksPerYear = 52;

    int year;
    int week;

    Date (this.year, this.week);

    void advance () {
        week += 1;
        if (week > kWeeksPerYear) {
            week = 1;
            year += 1;
        }
    }

    String notification () => 'Week $week of $year';

    Object toEncodable () {
        return {'year': year, 'week': week};
    }

    static Date fromEncodable (Object object) {
        Map map = object;
        return new Date (map['year'], map['week']);
    }

}