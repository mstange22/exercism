package Acronym

fun generate(phrase: String): String = phrase
  .toUpperCase().split('-', ' ')
  .fold("") { acc, e -> if (e.length > 0) acc + e[0] else acc }