unit class Geo::Ellipsoids;

has Str  $.name                  is required;
has Real $.semi-major-axis       is required;
has Real $.semi-minor-axis;
has Real $.eccentricity-squared;
has Real $.inverse-flattening;

sub prefix:<√> { sqrt($^a) }

submethod TWEAK {
    fail "Specify semi-major-axis and exactly one of semi-minor-access, eccentricity-squared or inverse-flattening"
      unless $!semi-minor-axis.defined
         xor $!inverse-flattening.defined
         xor $!eccentricity-squared.defined;
    
    if $!inverse-flattening.defined {
        $!eccentricity-squared = 2 ÷ $!inverse-flattening - 1÷$!inverse-flattening²;
        $!semi-minor-axis = $!semi-major-axis × (1 - 1 ÷ $!inverse-flattening);
    } elsif $!eccentricity-squared.defined { # e² is defined
        $!inverse-flattening = 1 ÷ (1 - √(1 - $!eccentricity-squared));
        $!semi-minor-axis = $!semi-major-axis × (1 - 1 ÷ $!inverse-flattening);
    } else { # semi-minor-axis defined
        $!inverse-flattening = $!semi-major-axis ÷ ($!semi-major-axis - $!semi-minor-axis);
        $!eccentricity-squared = 2 ÷ $!inverse-flattening - 1 ÷ $!inverse-flattening²;
    }
}

our @Ellipsoid is export =
    ( Geo::Ellipsoids.new(name => "Airy",                                semi-major-axis => 6377563.396, semi-minor-axis      => 6356256.909),   # eccentricity-squared => 0.006670540
      Geo::Ellipsoids.new(name => "Arc 1950",                            semi-major-axis => 6378249.145, eccentricity-squared => 0.006803481),
      Geo::Ellipsoids.new(name => "Australian National",                 semi-major-axis => 6378160,     inverse-flattening   => 298.25),        # eccentricity-squared => 0.006694542
      Geo::Ellipsoids.new(name => "Bessel 1841",                         semi-major-axis => 6377397.155, semi-minor-axis      => 6356078.963),   # eccentricity-squared => 0.006674372
      Geo::Ellipsoids.new(name => "Bessel 1841 Nambia",                  semi-major-axis => 6377484,     eccentricity-squared => 0.006674372),   # same as non-Nambia, but slightly different sized metre
      Geo::Ellipsoids.new(name => "Clarke 1866",                         semi-major-axis => 6378206.4,   semi-minor-axis      => 6356583.8),     # eccentricity-squared => 0.006768658
      Geo::Ellipsoids.new(name => "Clarke 1880",                         semi-major-axis => 6378249.145, inverse-flattening   => 293.465),       # eccentricity-squared => 0.006803511
      Geo::Ellipsoids.new(name => "Everest 1830 India",                  semi-major-axis => 6377276,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoids.new(name => "Everest 1830 Malaysia",               semi-major-axis => 6377299,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoids.new(name => "Everest 1956 India",                  semi-major-axis => 6377301,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoids.new(name => "Everest 1964 Malaysia and Singapore", semi-major-axis => 6377304,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoids.new(name => "Everest 1969 Malaysia",               semi-major-axis => 6377296,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoids.new(name => "Everest Pakistan",                    semi-major-axis => 6377296,     eccentricity-squared => 0.006637534),
      Geo::Ellipsoids.new(name => "Fischer 1960 Mercury",                semi-major-axis => 6378166,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoids.new(name => "Fischer 1968",                        semi-major-axis => 6378150,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoids.new(name => "GRS 1967",                            semi-major-axis => 6378160,     eccentricity-squared => 0.006694605),
      Geo::Ellipsoids.new(name => "GRS 1980",                            semi-major-axis => 6378137,     eccentricity-squared => 0.006694380),
      Geo::Ellipsoids.new(name => "Helmert 1906",                        semi-major-axis => 6378200,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoids.new(name => "Hough",                               semi-major-axis => 6378270,     eccentricity-squared => 0.006722670),
      Geo::Ellipsoids.new(name => "Indonesian 1974",                     semi-major-axis => 6378160,     eccentricity-squared => 0.006694609),
      Geo::Ellipsoids.new(name => "International",                       semi-major-axis => 6378388,     inverse-flattening   => 297),           # eccentricity-squared => 0.006722670
      Geo::Ellipsoids.new(name => "Krassovsky",                          semi-major-axis => 6378245,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoids.new(name => "Modified Airy",                       semi-major-axis => 6377340,     eccentricity-squared => 0.006670540),
      Geo::Ellipsoids.new(name => "Modified Everest",                    semi-major-axis => 6377304,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoids.new(name => "Modified Fischer 1960",               semi-major-axis => 6378155,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoids.new(name => "NAD 27",                              semi-major-axis => 6378206.4,   eccentricity-squared => 0.006768658),
      Geo::Ellipsoids.new(name => "NAD 83",                              semi-major-axis => 6378137,     eccentricity-squared => 0.006694384),
      Geo::Ellipsoids.new(name => "South American 1969",                 semi-major-axis => 6378160,     eccentricity-squared => 0.006694542),
      Geo::Ellipsoids.new(name => "WGS 60",                              semi-major-axis => 6378165,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoids.new(name => "WGS 66",                              semi-major-axis => 6378145,     inverse-flattening   => 298.25),        # eccentricity-squared => 0.006694542
      Geo::Ellipsoids.new(name => "WGS-72",                              semi-major-axis => 6378135,     inverse-flattening   => 298.26),        # eccentricity-squared => 0.006694318
      Geo::Ellipsoids.new(name => "WGS-84",                              semi-major-axis => 6378137,     inverse-flattening   => 298.257223562), # eccentricity-squared => 0.00669438
    );

our %Ellipsoid is export = @Ellipsoid.map({.name => $_});

# remove all markup from an ellipsoid name, to increase the chance
# that a match is found.
our sub cleanup-ellipsoid-name(Str $copy is copy) {
    $copy .= lc;
    $copy ~~ s:g/ \( <-[)]>* \) //;   # remove text between parentheses
    $copy ~~ s:g/ <[\s-]> //;         # no blanks or dashes
    $copy;
}

for @Ellipsoid {
    %Ellipsoid{cleanup-ellipsoid-name($_.name)} = $_;
}

# Returns all pre-defined ellipsoid names, sorted alphabetically
our sub ellipsoid-names() {
    @Ellipsoid.map({ .name }).sort;
}

# documentation moved to ../../doc/Ellipsoids.rakudoc
