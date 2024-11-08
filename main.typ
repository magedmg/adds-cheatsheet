#table(
  columns: 6,
  inset: 6pt,
  align: center,
  table.header([], [*Best*], [*Average*], [*Worst*], [*Space*], [*Stable*]),
  [*Selection*], table.cell(colspan: 3)[$O(n^2)$], [$O(1)$], [],
  [*Insertion*], [$O(n)$], table.cell(colspan: 2)[$O(n^2)$], [$O(1)$], [#sym.checkmark],
  [*Bubble*], table.cell(colspan: 3)[$O(n^2)$], [$O(1)$], [],
  [*Merge*], table.cell(colspan: 3)[$O(n log(n))$], [$O(n)$], [#sym.checkmark],
  [*Quick*], table.cell(colspan: 2)[$O(n log(n))$], [$O(n^2)$], [$O(log(n))$], [],
  [*Bucket*], [$O(n)$], [$O(n+k)$ \ #text(0.8em)[(k: numbers of buckets)]], [$O(n^2)$], [$O(n+k)$], [#sym.checkmark],
  [*Counting*], table.cell(colspan: 3)[$O(n+k)$ \ #text(0.8em)[(k: range of the input values, max-min)]], [$O(
        n+k
      )$], [#sym.checkmark],
  [*Heap*], table.cell(colspan: 3)[$O(n log(n))$], [$O(1)$], [],
)