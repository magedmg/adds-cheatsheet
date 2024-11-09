#set page(margin: 0cm, columns: 2)
#set text(size: 6pt, font: "Roboto")
#set table(inset: 3pt, align: horizon + center)

#table(
  columns: 6,
  [], [*Best*], [*Average*], [*Worst*], [*Space*], [*Stable*],
  [*Selection*], table.cell(colspan: 3)[$O(n^2)$], [$O(1)$], [],
  [*Insertion*], [$O(n)$], table.cell(colspan: 2)[$O(n^2)$], [$O(1)$], [#sym.checkmark],
  [*Bubble*], table.cell(colspan: 3)[$O(n^2)$], [$O(1)$], [#sym.checkmark],
  [*Merge*], table.cell(colspan: 3)[$O(n log(n))$], [$O(n)$], [#sym.checkmark],
  [*Quick*], table.cell(colspan: 2)[$O(n log(n))$], [$O(n^2)$], [$O(log(n))$], [],
  [*Bucket*], [$O(n)$], [$O(n+k)$ \ #text(0.8em)[(k: numbers of buckets)]], [$O(n^2)$], [$O(n+k)$], [#sym.checkmark],
  [*Counting*], table.cell(colspan: 3)[$O(n+k)$ \ #text(0.8em)[(k: range of the input values, max-min)]],
  [$O(n+k)$], [#sym.checkmark],
  [*Heap*], table.cell(colspan: 3)[$O(n log(n))$], [$O(1)$], [],
)

#table(
  columns: 8,
  [], table.cell(colspan: 3)[*Worst*], table.cell(colspan: 3)[*Average*], table.cell(rowspan: 2)[*Space*],
  [], [*Insert*], [*Delete*], [*Search*], [*Insert*], [*Delete*], [*Search*],
  [*Vector Ordered*],table.cell(colspan: 2)[$O(n)$],[$O(log(n))$],table.cell(colspan: 2)[$O(n)$],[$O(log(n))$],
  table.cell(rowspan: 5)[$O(n)$],
  [*Vector Unordered*],[$O(1)$\*],table.cell(colspan: 2, rowspan: 2)[$O(n)$],
  [$O(1)$\*],table.cell(colspan: 2, rowspan: 2)[$O(n)$],
  [*Linked List*],[$O(1)$],[$O(1)$],
  [*Binary Search Tree*],table.cell(colspan: 3)[$O(n)$],table.cell(colspan: 3)[$O(log(n))$],
  [*Balanced BST (RBT)*],table.cell(colspan: 6)[$O(log(n))$],
  [*Priority Queues*], [*Insert*], [*RMH\*\**], [*Peek*], [*Insert*], [*RMH\*\**], [*Peek*], table.cell(rowspan: 3)[],
  [*Linked List*],[$O(n)$],table.cell(colspan: 2)[$O(1)$],[$O(n)$],table.cell(colspan: 2)[$O(1)$],
  [*Heap*],table.cell(colspan: 2)[$O(log(n))$],[$O(1)$],[$O(1)$],[$O(log(n))$],[$O(1)$],
  table.cell(
    colspan: 8,
    align: left,
  )[#text(size: 0.8em)[\*: Amortised - ie over a sequence of this operation. Resizing vector $O(n)$ \
      \*\*: Remove highest priority]]
)

#image("complexity.png")