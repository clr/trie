# C-Trie

1. Search around for a tree structure that implicitly
knows how many unique leaves exist downstream while
simultaneously allowing concurrent updates to the tree.
An ideal solution would somehow presort the results
according to a higher node in the branch than the leaf. 

2. Build in error-handling for malformed trees, such
as ones built without endlines.

3. Exception handling. This code only handles correct
code execution at the moment.  Tsk tsk.  What would
Avdi say?  ;-)

4. WordEnumerator, if used incorrectly, could leave a
file handle open.
