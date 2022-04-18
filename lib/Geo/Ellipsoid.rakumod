unit class Geo::Ellipsoid;

has Str $.name                   is required;
has Real $.semi-major-axis       is required;
has Real $.semi-minor-axis;
has Real $.eccentricity-squared;
has Real $.inverse-flattening;

sub prefix:<√> {
    sqrt($^a)
}

submethod TWEAK {
    fail "Specify semi-major-axis and exactly one of semi-minor-access, eccentricity-squared or inverse-flattening"
      unless $!semi-minor-axis.defined
      xor    $!inverse-flattening.defined
      xor    $!eccentricity-squared.defined;
    
    if $!inverse-flattening.defined {
        $!eccentricity-squared = 2 × 1÷$!inverse-flattening - 1÷$!inverse-flattening²;
        $!semi-minor-axis = $!semi-major-axis × (1 - 1 ÷ $!inverse-flattening);
    } elsif $!eccentricity-squared.defined { # e² is defined
        $!inverse-flattening = 1 ÷ (1 - √(1 - $!eccentricity-squared));
        $!semi-minor-axis = $!semi-major-axis × (1 - 1 ÷ $!inverse-flattening);
    } else { # semi-minor-axis defined
        $!inverse-flattening = $!semi-major-axis ÷ ($!semi-major-axis - $!semi-minor-axis);
        $!eccentricity-squared = 2 × 1/$!inverse-flattening - 1/$!inverse-flattening²;
    }
}

our @Ellipsoid =
    ( [ "Airy",                                6377563,     0.006670540],
      [ "Australian National",                 6378160,     0.006694542],
      [ "Bessel 1841",                         6377397,     0.006674372],
      [ "Bessel 1841 Nambia",                  6377484,     0.006674372],
      [ "Clarke 1866",                         6378206,     0.006768658],
      [ "Clarke 1880",                         6378249,     0.006803511],
      [ "Everest 1830 India",                  6377276,     0.006637847],
      [ "Fischer 1960 Mercury",                6378166,     0.006693422],
      [ "Fischer 1968",                        6378150,     0.006693422],
      [ "GRS 1967",                            6378160,     0.006694605],
      [ "GRS 1980",                            6378137,     0.006694380],
      [ "Helmert 1906",                        6378200,     0.006693422],
      [ "Hough",                               6378270,     0.006722670],
      [ "International",                       6378388,     0.006722670],
      [ "Krassovsky",                          6378245,     0.006693422],
      [ "Modified Airy",                       6377340,     0.006670540],
      [ "Modified Everest",                    6377304,     0.006637847],
      [ "Modified Fischer 1960",               6378155,     0.006693422],
      [ "South American 1969",                 6378160,     0.006694542],
      [ "WGS 60",                              6378165,     0.006693422],
      [ "WGS 66",                              6378145,     0.006694542],
      [ "WGS-72",                              6378135,     0.006694318],
      [ "WGS-84",                              6378137,     0.00669438 ],
      [ "Everest 1830 Malaysia",               6377299,     0.006637847],
      [ "Everest 1956 India",                  6377301,     0.006637847],
      [ "Everest 1964 Malaysia and Singapore", 6377304,     0.006637847],
      [ "Everest 1969 Malaysia",               6377296,     0.006637847],
      [ "Everest Pakistan",                    6377296,     0.006637534],
      [ "Indonesian 1974",                     6378160,     0.006694609],
      [ "Arc 1950",                            6378249.145, 0.006803481],
      [ "NAD 27",                              6378206.4,   0.006768658],
      [ "NAD 83",                              6378137,     0.006694384],
    ).map(
    {
        Geo::Ellipsoid.new(name => $_[0], semi-major-axis => $_[1], eccentricity-squared => $_[2])
    }
);

=begin pod

=head1 NAME

Geo::Ellipsoid - blah blah blah

=head1 SYNOPSIS

=begin code :lang<raku>

use Geo::Ellipsoid;

=end code

=head1 DESCRIPTION

Geo::Ellipsoid is ...

=head1 AUTHOR

Kevin Pye <Kevin@pye.id.au>

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Kevin Pye

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
