package ScrabbleScore;
use strict;
use warnings;
use List::AllUtils qw(sum);
use Exporter 'import';
our @EXPORT_OK = qw(score);

sub build_map {
  my %given_map = (
    1 => "AEIOULNSRT",
    2 => "DG",
    3 => "BCMP",
    4 => "FHVWY",
    5 => "K",
    8 => "JX",
    10 => "QZ",
  );
  my %new_map = ();
  foreach my $key (keys %given_map) {
    foreach my $letter (split('', $given_map{$key})) {
      $new_map{$letter} = $key;
    }
  }
  return \%new_map;
}

sub score {
  my ($word, %extensions) = @_;
  my $map = build_map();
  return sum(0, @{$map}{split('', uc($word))});
}

1;
