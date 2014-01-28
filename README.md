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
CharNode is then passed to the Collector, which gathers the 25
most frequent descendants.  The Autocomplete object then concats
the prefix to the results of the Collector and returns an
array.

    > autocomplete.suggest "ther"
    => ["there 2212", "therefore 627", "thersites 125", "therein 56", "thereof 39", "thereby 26", "thereto 17", "therewithal 9", "thereupon 8", "thereon 7", "thereabouts 4", "thereat 3", "thereunto 3", "therewith 2", "thereabout 1", "thereafter 1"]

One ticklish thing about this data model is that
while we have explicit
knowledge of how many unique children each node has at the end
of each branch,
the same knowledge cannot be implicitly detected from the data
structure or from explicit metadata within parent branches.
The tree traversal only leeds to the proper pool of
children, but you still have to sort them and slice out the subset.
In a perfect solution, the tree traversal would proceed along a
branch such that the children would already be sorted, and then
you would only have to select the first X results. 
I know of no tree-based data structure that
offers that implicit information, but I would love to
search for one. [Adding that as a TODO.]

## Contributing

1. Fork it ( http://github.com/<my-github-username>/c_trie/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
