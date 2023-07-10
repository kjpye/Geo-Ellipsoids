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
    ( Geo::Ellipsoid.new(name => "Airy",                                semi-major-axis => 6377563.396, semi-minor-axis      => 6356256.909),   # eccentricity-squared => 0.006670540
      Geo::Ellipsoid.new(name => "Arc 1950",                            semi-major-axis => 6378249.145, eccentricity-squared => 0.006803481),
      Geo::Ellipsoid.new(name => "Australian National",                 semi-major-axis => 6378160,     inverse-flattening   => 298.25),        # eccentricity-squared => 0.006694542
      Geo::Ellipsoid.new(name => "Bessel 1841",                         semi-major-axis => 6377397.155, semi-minor-axis      => 6356078.963),   # eccentricity-squared => 0.006674372
      Geo::Ellipsoid.new(name => "Bessel 1841 Nambia",                  semi-major-axis => 6377484,     eccentricity-squared => 0.006674372),   # same as non-Nambia, but slightly different sized metre
      Geo::Ellipsoid.new(name => "Clarke 1866",                         semi-major-axis => 6378206.4,   semi-minor-axis      => 6356583.8),     # eccentricity-squared => 0.006768658
      Geo::Ellipsoid.new(name => "Clarke 1880",                         semi-major-axis => 6378249.145, inverse-flattening   => 293.465),       # eccentricity-squared => 0.006803511
      Geo::Ellipsoid.new(name => "Everest 1830 India",                  semi-major-axis => 6377276,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoid.new(name => "Everest 1830 Malaysia",               semi-major-axis => 6377299,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoid.new(name => "Everest 1956 India",                  semi-major-axis => 6377301,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoid.new(name => "Everest 1964 Malaysia and Singapore", semi-major-axis => 6377304,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoid.new(name => "Everest 1969 Malaysia",               semi-major-axis => 6377296,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoid.new(name => "Everest Pakistan",                    semi-major-axis => 6377296,     eccentricity-squared => 0.006637534),
      Geo::Ellipsoid.new(name => "Fischer 1960 Mercury",                semi-major-axis => 6378166,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoid.new(name => "Fischer 1968",                        semi-major-axis => 6378150,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoid.new(name => "GRS 1967",                            semi-major-axis => 6378160,     eccentricity-squared => 0.006694605),
      Geo::Ellipsoid.new(name => "GRS 1980",                            semi-major-axis => 6378137,     eccentricity-squared => 0.006694380),
      Geo::Ellipsoid.new(name => "Helmert 1906",                        semi-major-axis => 6378200,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoid.new(name => "Hough",                               semi-major-axis => 6378270,     eccentricity-squared => 0.006722670),
      Geo::Ellipsoid.new(name => "Indonesian 1974",                     semi-major-axis => 6378160,     eccentricity-squared => 0.006694609),
      Geo::Ellipsoid.new(name => "International",                       semi-major-axis => 6378388,     inverse-flattening   => 297),           # eccentricity-squared => 0.006722670
      Geo::Ellipsoid.new(name => "Krassovsky",                          semi-major-axis => 6378245,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoid.new(name => "Modified Airy",                       semi-major-axis => 6377340,     eccentricity-squared => 0.006670540),
      Geo::Ellipsoid.new(name => "Modified Everest",                    semi-major-axis => 6377304,     eccentricity-squared => 0.006637847),
      Geo::Ellipsoid.new(name => "Modified Fischer 1960",               semi-major-axis => 6378155,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoid.new(name => "NAD 27",                              semi-major-axis => 6378206.4,   eccentricity-squared => 0.006768658),
      Geo::Ellipsoid.new(name => "NAD 83",                              semi-major-axis => 6378137,     eccentricity-squared => 0.006694384),
      Geo::Ellipsoid.new(name => "South American 1969",                 semi-major-axis => 6378160,     eccentricity-squared => 0.006694542),
      Geo::Ellipsoid.new(name => "WGS 60",                              semi-major-axis => 6378165,     eccentricity-squared => 0.006693422),
      Geo::Ellipsoid.new(name => "WGS 66",                              semi-major-axis => 6378145,     inverse-flattening   => 298.25),        # eccentricity-squared => 0.006694542
      Geo::Ellipsoid.new(name => "WGS-72",                              semi-major-axis => 6378135,     inverse-flattening   => 298.26),        # eccentricity-squared => 0.006694318
      Geo::Ellipsoid.new(name => "WGS-84",                              semi-major-axis => 6378137,     inverse-flattening   => 298.257223562), # eccentricity-squared => 0.00669438
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

=begin pod

=head1 NAME

Geo::Ellipsoids - Geodetic ellipsoid definitions

=head1 SYNOPSIS
=begin code :lang<raku>
    use Geo::Ellipsoids;
    my $ellipsoid = %Ellipsoids{"Australian National"};
    my $semimajor-axis = $ellipsoid.semi-major-axis;
=end code

=head1 DESCRIPTION

Geo::Ellipsoids is a collection of definitions of ellipsoids
useful for mapping purposes.

A class Geo::Ellipsoids is defined which contains five accessors:

=item C<name> — the name of the ellipsoid.

=item C<semi-major-axis> — the semi-major axis of the ellipsoid in metres.

=item C<semi-minor-access> — the semi-minor axis of the ellipsoid in metres. 

=item C<inverse-flattening> — the reciprocal of the ellipsoid flattening.

=item C<eccentricity-squared> — the square of the ellipsoid's eccentricity.

Objects of this class are created by specifying the name,
the semi-major axis, and exactly one of the semi-minor axis,
the inverse flattening or the square of the eccentricity.
The other values are calculated at object creation time and may
be accessed using the accessors.

In addition an array of predefined ellipsoids is available as
C<@Geo::Ellipsoids::Ellipsoids>,
and as a hash indexed on the name as C<%Geo::Ellipsoids::Ellipsoids>.

The following subroutines are available:

=item C<cleanup-ellisoid-name> — takes a string, and canonicalises
it to make it more likely to find a match in the
C<%Ellipsoids> hash. Spaces, dashes and text between parentheses
are removed, and the result forced to lower case.
The standard ellisoids below appear in the C<%Ellipsoids> hash with both
their full name and their canonicalised name as keys.

=item C<ellipsoid-names> — returns an array containing a sorted list of the non-canonicalised names of the ellipsoids in C<@Ellipsoids>.

=head2 Datums and Ellipsoids

Unlike local surveys, which treat the Earth as a plane, the precise
determination of the latitude and longitude of points over a broad area
must take into account the actual shape of the Earth. To achieve the
precision necessary for accurate location, the Earth cannot be assumed
to be a sphere. Rather, the Earth's shape more closely approximates an
ellipsoid (oblate spheroid): flattened at the poles and bulging at the
Equator. Thus the Earth's shape, when cut through its polar axis,
approximates an ellipse. A "Datum" is a standard representation of shape
and offset for coordinates, which includes an ellipsoid and an origin.
You must consider the Datum when working with geospatial data, since
data with two different Datums will not line up. The difference can be as
much as a kilometer!

=head2 Predefined ellipsoids

The ellipsoids available are as follows:

=item Airy

=item Australian National

=item Bessel 1841

=item Bessel 1841 (Nambia)

=item Clarke 1866

=item Clarke 1880

=item Everest 1830 (India)

=item Fischer 1960 (Mercury)

=item Fischer 1968

=item GRS 1967

=item GRS 1980

=item Helmert 1906

=item Hough

=item International

=item Krassovsky

=item Modified Airy

=item Modified Everest

=item Modified Fischer 1960

=item South American 1969

=item WGS 60

=item WGS 66

=item WGS-72

=item WGS-84

=item Everest 1830 (Malaysia)

=item Everest 1956 (India)

=item Everest 1964 (Malaysia and Singapore)

=item Everest 1969 (Malaysia)

=item Everest (Pakistan)

=item Indonesian 1974

=item Arc 1950

=item NAD 27

=item NAD 83

=head1 AUTHOR

Kevin Pye <Kevin@pye.id.au>

While this is similar in intent to the Perl module Geo::Ellipsoids, its actual
history is part of the Perl Geo::Coordinates::UTM module, via the Raku
equivalent.

Much of the data in this module is taken from the Perl Geo::Coordinates::UTM module.

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Kevin Pye

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
