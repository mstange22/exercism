using System;
using System.Collections.Generic;

public static class NucleotideCount
{
    public static IDictionary<char, int> Count(string sequence)
    {
        Dictionary<char, int> res = new Dictionary<char, int>(){
            { 'A', 0 },
            { 'C', 0 },
            { 'G', 0 },
            { 'T', 0 },
        };

        foreach (char c in sequence) {
            if (!res.ContainsKey(c)) {
                throw new ArgumentException("Invalid nucleotide.");
            }
            res[c]++;
        }
        return res;
    }
}