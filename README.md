[![Actions Status](https://github.com/kjpye/geo-ellipsoid/actions/workflows/test.yml/badge.svg)](https://github.com/kjpye/geo-ellipsoid/actions)

NAME
====

Geo::Ellipsoid - Geodetic ellipsoid definitions

SYNOPSIS
========

```raku
    use Geo::Ellipsoid;
    my $ellipsoid = %Ellipsoids{"Australian National"};
    my $semimajor-axis = $ellipsoid.semi-major-axis;
```

DESCRIPTION
===========

Geo::Ellipsoid is a collection of definitions of ellipsoids useful for mapping purposes.

A class Geo::Ellipsoid is defined which contains five accessors:

  * `name` — the name of the ellipsoid.

  * `semi-major-axis` — the semi-major axis of the ellipsoid in metres.

  * `semi-minor-access` — the semi-minor axis of the ellipsoid in metres. 

  * `inverse-flattening` — the reciprocal of the ellipsoid flattening.

  * `eccentricity-squared` — the square of the ellipsoid's eccentricity.

Objects of this class are created by specifying the name, the semi-major axis, and exactly one of the semi-minor axis, the inverse flattening or the square of the eccentricity. The other values are created at object creation time and may be accessed using the accessors.

In addition an array of predefined ellipsoids is available as `@Geo::Ellipsoid::Ellipsoids`, and as a hash indexed on the name as `%Geo::Ellipsoid::Ellipsoids`.

The following subroutines are available:

  * `cleanup-ellisoid-name` — takes a string, and canonicalises it to make it more likely to find a match in the `%Ellipsoids` hash. Spaces, dashes and text between parentheses are removed, and the result forced to lower case. The standard ellisoids below appear in the `%Ellipsoids` hash with both their full name and their canonicalised name as keys.

  * `ellipsoid-names` — returns an array containing a sorted list of the non-canonicalised names of the ellipsoids in `@Ellipsoids`.

Datums and Ellipsoids
---------------------

Unlike local surveys, which treat the Earth as a plane, the precise determination of the latitude and longitude of points over a broad area must take into account the actual shape of the Earth. To achieve the precision necessary for accurate location, the Earth cannot be assumed to be a sphere. Rather, the Earth's shape more closely approximates an ellipsoid (oblate spheroid): flattened at the poles and bulging at the Equator. Thus the Earth's shape, when cut through its polar axis, approximates an ellipse. A "Datum" is a standard representation of shape and offset for coordinates, which includes an ellipsoid and an origin. You must consider the Datum when working with geospatial data, since data with two different Datums will not line up. The difference can be as much as a kilometer!

Predefined ellipsoids
---------------------

The ellipsoids available are as follows:

  * Airy

  * Australian National

  * Bessel 1841

  * Bessel 1841 (Nambia)

  * Clarke 1866

  * Clarke 1880

  * Everest 1830 (India)

  * Fischer 1960 (Mercury)

  * Fischer 1968

  * GRS 1967

  * GRS 1980

  * Helmert 1906

  * Hough

  * International

  * Krassovsky

  * Modified Airy

  * Modified Everest

  * Modified Fischer 1960

  * South American 1969

  * WGS 60

  * WGS 66

  * WGS-72

  * WGS-84

  * Everest 1830 (Malaysia)

  * Everest 1956 (India)

  * Everest 1964 (Malaysia and Singapore)

  * Everest 1969 (Malaysia)

  * Everest (Pakistan)

  * Indonesian 1974

  * Arc 1950

  * NAD 27

  * NAD 83

AUTHOR
======

Kevin Pye <Kevin@pye.id.au>

Much of the data in this module is taken from the Perl 5 Geo::Coordinates::UTM module.

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Kevin Pye

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

