# C-Trie

1. Search around for a tree structure that implicitly
knows how many unique leaves exist downstream while
simultaneously allowing concurrent updates to the tree.

2. Build in error-handling for malformed trees, such
as ones built without endlines.

3. Change CharNode#unique_children on "\n" nodes to 0, and
handle traversal accordingly; conversely, the root node
always has unique_children => 0, because we never look at
that value.

4. Exception handling. This code only handles correct
code execution at the moment.  Tsk tsk.  What would
Avdi say?  ;-)

5. WordEnumerator, if used incorrectly, could leave a
file handle open.
