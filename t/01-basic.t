use Test;
use Geo::Ellipsoid;

my $major = 6378160;
my $minor = 6356774.719;
my $inverse-flattening = 298.25;
my $eccentricity-squared = 0.006694542;

my $test1 = Geo::Ellipsoid.new(name => 'AN 66', semi-major-axis => $major, semi-minor-axis => $minor);
my $test2 = Geo::Ellipsoid.new(name => 'AN 66', semi-major-axis => $major, inverse-flattening => $inverse-flattening);
my $test3 = Geo::Ellipsoid.new(name => 'AN 66', semi-major-axis => $major, eccentricity-squared => $eccentricity-squared);

is-approx $test1.inverse-flattening, $inverse-flattening, 'inverse-flattening from semi-minor-eaxis';
is-approx $test1.eccentricity-squared, $eccentricity-squared, 'eccentricity-squared from semi-min-axis';
is-approx $test2.semi-minor-axis, $minor, 'semi-minor-axis from inverse-flattening';
is-approx $test2.eccentricity-squared, $eccentricity-squared, 'eccentricity-squared from inverse-flattening';
is-approx $test3.semi-minor-axis, $minor, 'semi-minor-axis from eccentricity-squared';
is-approx $test3.inverse-flattening, $inverse-flattening, 'inverse-flattening from eccentricity-squared';
# is-approx 2,3,'just testing';
done;
