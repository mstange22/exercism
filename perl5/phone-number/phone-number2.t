#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 19;
use JSON::PP;
use FindBin qw($Bin);
use lib $Bin, "$Bin/local/lib/perl5";
use PhoneNumber qw(clean_number);

can_ok 'PhoneNumber', 'import' or BAIL_OUT 'Cannot import subroutines from module';

my $JSON_TESTS = decode_json( join '', <DATA>);

my @cases =
    map {
        $_->[2] .= ' - ' . $_->[0];
        $_;
    }
    map {
        my @test = ( $_->{input}{phrase}, $_->{expected}, $_->{description} );

        if ( ref $test[1] ) {
            $test[1] = $test[1]->{error};
            push @test, 1;
        }

        \@test;
    }
    map { @$_ }
    map { $_->{cases} }
    map { @$_ }
        $JSON_TESTS->{cases};

$_->[3] ? error_test(@$_) : regular_test(@$_) for @cases;

sub regular_test {
    my( $input, $expected, $desc ) = @_;
    is clean_number($input), $expected, $desc;
}

sub error_test {
    my( $input, $error, $desc ) = @_;
    eval { clean_number($input) };

    like $@, qr/$error/, $desc;
}

__DATA__
{
  "exercise": "phone-number",
  "version": "1.7.0",
  "cases": [
    {
      "description": "Cleanup user-entered phone numbers",
      "comments": [
        " Returns the cleaned phone number if given number is valid, "
      , " else returns error object. Note that number is not formatted,"
      , " just a 10-digit number is returned.                        "
      ],
      "cases": [
        {
          "description": "cleans the number",
          "property": "clean",
          "input": {
            "phrase": "(223) 456-7890"
          },
          "expected": "2234567890"
        },
        {
          "description": "cleans numbers with dots",
          "property": "clean",
          "input": {
            "phrase": "223.456.7890"
          },
          "expected": "2234567890"
        },
        {
          "description": "cleans numbers with multiple spaces",
          "property": "clean",
          "input": {
            "phrase": "223 456   7890   "
          },
          "expected": "2234567890"
        },
        {
          "description": "invalid when 9 digits",
          "property": "clean",
          "input": {
            "phrase": "123456789"
          },
          "expected": {"error": "incorrect number of digits"}
        },
        {
          "description": "invalid when 11 digits does not start with a 1",
          "property": "clean",
          "input": {
            "phrase": "22234567890"
          },
          "expected": {"error": "11 digits must start with 1"}
        },
        {
          "description": "valid when 11 digits and starting with 1",
          "property": "clean",
          "input": {
            "phrase": "12234567890"
          },
          "expected": "2234567890"
        },
        {
          "description": "valid when 11 digits and starting with 1 even with punctuation",
          "property": "clean",
          "input": {
            "phrase": "+1 (223) 456-7890"
          },
          "expected": "2234567890"
        },
        {
          "description": "invalid when more than 11 digits",
          "property": "clean",
          "input": {
            "phrase": "321234567890"
          },
          "expected": {"error": "more than 11 digits"}
        },
        {
          "description": "invalid with letters",
          "property": "clean",
          "input": {
            "phrase": "123-abc-7890"
          },
          "expected": {"error": "letters not permitted"}
        },
        {
          "description": "invalid with punctuations",
          "property": "clean",
          "input": {
            "phrase": "123-@:!-7890"
          },
          "expected": {"error": "punctuations not permitted"}
        },
        {
          "description": "invalid if area code starts with 0",
          "property": "clean",
          "input": {
            "phrase": "(023) 456-7890"
          },
          "expected": {"error": "area code cannot start with zero"}
        },
        {
          "description": "invalid if area code starts with 1",
          "property": "clean",
          "input": {
            "phrase": "(123) 456-7890"
          },
          "expected": {"error": "area code cannot start with one"}
        },
        {
          "description": "invalid if exchange code starts with 0",
          "property": "clean",
          "input": {
            "phrase": "(223) 056-7890"
          },
          "expected": {"error": "exchange code cannot start with zero"}
        },
        {
          "description": "invalid if exchange code starts with 1",
          "property": "clean",
          "input": {
            "phrase": "(223) 156-7890"
          },
          "expected": {"error": "exchange code cannot start with one"}
        },
        {
          "description": "invalid if area code starts with 0 on valid 11-digit number",
          "property": "clean",
          "input": {
            "phrase": "1 (023) 456-7890"
          },
          "expected": {"error": "area code cannot start with zero"}
        },
        {
          "description": "invalid if area code starts with 1 on valid 11-digit number",
          "property": "clean",
          "input": {
            "phrase": "1 (123) 456-7890"
          },
          "expected": {"error": "area code cannot start with one"}
        },
        {
          "description": "invalid if exchange code starts with 0 on valid 11-digit number",
          "property": "clean",
          "input": {
            "phrase": "1 (223) 056-7890"
          },
          "expected": {"error": "exchange code cannot start with zero"}
        },
        {
          "description": "invalid if exchange code starts with 1 on valid 11-digit number",
          "property": "clean",
          "input": {
            "phrase": "1 (223) 156-7890"
          },
          "expected": {"error": "exchange code cannot start with one"}
        }
      ]
    }
  ]
}