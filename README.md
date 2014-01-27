# C-Trie

This library implements an autocomplete feature as a C-Trie.

## Installation

I did not publish a gem. Clone it.  Then run tests:

    $ rake

## Usage

From this library directory, run:

    $ ./console

Three dictionaries are included to practice with:

1. Shakespeare's complete works.
2. A sample from the Gutenberg Library.
3. Both of the above combined.

At the Ruby prompt, you can load a dictionary by creating a
new Autocomplete object:

    > autocomplete = CTrie::Autocomplete.new "./data/extended-sample.txt"

While loading, it should resemble:

    ************************************
        NOW ENCODING C-TRIE FROM
     ./data/extended-sample.txt
    ************************************
    ...........

Once done, you can now query your C-Trie for Autocomplete
suggestions:

    > autocomplete.suggest "ther"
    => ["there 2212", "therefore 627", "thersites 125", "therein 56", "thereof 39", "thereby 26", "thereto 17", "therewithal 9", "thereupon 8", "thereon 7", "thereabouts 4", "thereat 3", "thereunto 3", "therewith 2", "thereabout 1", "thereafter 1"]

Since creating a C-Trie from a corpus takes time, you may want to save
or load the C-Trie:

    > autocomplete.dump "./data/extended-sample.robject"
    Wrote C-Trie to: ./data/extended-sample.robject
    => nil 

Then you can load that C-Trie later for Autocompleting fun:

    > autocomplete = CTrie::Autocomplete.new
    > autocomplete.load "./data/extended-sample.robject"

## Algorithm

This library has 6 featured Classes:

1. Autocomplete
2. CharNode
3. Collector
4. Encoder
5. Finder
6. WordEnumerator

The code path can be outlined roughly:
An Autocomplete object is a coordinator.  It iterates through the
corpus using a WordEnumerator object.  Each word emitted is sent
through an Encoder.  The Encoder builds a tree using a CharNode
to represent a single letter at each node.  That is how the C-Trie
is built.  To query it, an Autocomplete object [still a coordinator]
runs a Finder object on the tree of CharNodes.  This returns a
CharNode that represents the prefix match if there is one.  This
CharNode is then passed to the Collector, which gathers the 20
most frequent descendants.  The Autocomplete object then concats
the prefix to the results of the Collector and returns an
array.

    > autocomplete.suggest "ther"
    => ["there 2212", "therefore 627", "thersites 125", "therein 56", "thereof 39", "thereby 26", "thereto 17", "therewithal 9", "thereupon 8", "thereon 7", "thereabouts 4", "thereat 3", "thereunto 3", "therewith 2", "thereabout 1", "thereafter 1"]


The ticklish part of building a tree like this is that you
can either
build it to be optimized for the number of occurrences of a given
letter, or you can optimize it for the number of unique words.
For example, you can record and sort by the frequency of the
word 'there' and include that frequency in the encoding of
the word 'therefore' but then you don't know at the start of the
retrieval whether the letter 't' has 1 unique word or N unique
words.  All N occurrences of the first letter 't' could be
the word 'the' as far as you know when you start to retrieve.

This is a problem, because you want the first 20 words in
order of frequency.  You need to know how many times a node
has been seen, and you also need to know how many unique leaves
exist on that branch.  We can solve this one of three ways:

1. Allow traversal of the tree upword as well as downward.
Then, on encoding, once you get to the end and discover that
the last node has only one count [a unique word thus far],
go back up the tree and inform parents that they have a new
unique child.
2. Allow traversal of the tree to sibling branches.  Then
you can retrieve the first result, and crawl down until
you have collected the subsequent 20 results.  This also
requires nodes to keep track of their parents.
3. Check if the word is unique first.  If so, then you can
build that into the nodes on write.

I chose option 3 above.  It requires an extra lookup and it
means that the algorithm can only be run serially, but it
prevents me from having to navigate up a tree.  I like the
added simplicity in the node structure of not having to
keep track of one's parents.  I track the uniqueness
in a hash in the word iterator to save some time.

One thing that bugs me about this data model is that
while we have explicit
knowledge of how many unique children each node has,
the same knowledge cannot be implicitly detected from the data
structure.  I know of no tree-based data structure that
offers that implicit information, but I would love to
search for one. [Adding that as a TODO.]

## Contributing

1. Fork it ( http://github.com/<my-github-username>/c_trie/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
