# 01. Binary Tree Nodes

[HackerRank link](https://www.hackerrank.com/challenges/binary-search-tree-1/problem)

## What it's asking
There's a `BST` table describing a binary tree: each row is a node `N`
with its parent `P`. For every node, print whether it's the:
- **Root** — its `P` is empty (no parent)
- **Leaf** — no other row has this node as *their* parent (it has no
  children)
- **Inner** — neither of the above (it has both a parent and children)

Print one line per node, ordered by `N`.

**BST table**
| Column | Type |
|---|---|
| N | Integer |
| P | Integer (empty for the root) |

## Steps
1. A node is the **Root** if its own `P` column is empty — check that with
   `P IS NULL`.
2. A node is a **Leaf** if it never shows up as someone else's parent — in
   other words, its `N` doesn't appear anywhere in the `P` column.
3. Anything left over is **Inner**.
4. Since you're picking one of three labels per row based on conditions,
   this is a `CASE WHEN` — like "Type of Triangle" back in the Easy set.

## Code
```sql
SELECT N,
  CASE
    WHEN P IS NULL THEN 'Root'
    WHEN N IN (SELECT DISTINCT P FROM BST WHERE P IS NOT NULL) THEN 'Inner'
    ELSE 'Leaf'
  END
FROM BST
ORDER BY N;
```

## Walkthrough
- `P IS NULL` checks for an empty parent column — SQL uses `IS NULL` / `IS
  NOT NULL` instead of `= NULL`, because "empty" isn't a value you can
  compare with `=`.
- `N IN (SELECT DISTINCT P FROM BST WHERE P IS NOT NULL)` is a subquery
  that builds the list of every value that appears as *someone's* parent.
  If the current row's `N` is in that list, some other row points to it as
  a parent — meaning it has children, so it's `Inner`.
- If neither the Root check nor the Inner check matches, `ELSE 'Leaf'`
  catches everything else — a node with a parent but no children of its
  own.
- `CASE WHEN` still checks top to bottom and stops at the first match,
  exactly like in "Type of Triangle."
