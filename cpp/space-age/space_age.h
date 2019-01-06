#ifndef SPACE_AGE_H
#define SPACE_AGE_H

namespace space_age {
  class space_age {
    double earth_seconds;
    double earth_years;
    public:
      space_age(double);
      double seconds() const;
      double on_earth() const;
      double on_mercury() const;
      double on_venus() const;
      double on_mars() const;
      double on_jupiter() const;
      double on_saturn() const;
      double on_uranus() const;
      double on_neptune() const;
  };
}

#endif