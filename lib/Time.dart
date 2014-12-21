library naig.time;

class Date {
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

}