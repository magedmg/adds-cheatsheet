#set page(margin: 0cm, columns: 2)
#set text(size: 8pt, font: "Roboto")
#set table(inset: 2pt, align: horizon + center, stroke: 0.4pt)
#set heading(numbering: "I.1")
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 0.5em,
  radius: 2pt,
)

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
  table.cell(rowspan: 2)[], table.cell(colspan: 3)[*Worst*], table.cell(colspan: 3)[*Average*], table.cell(rowspan: 2)[*Space*],
  [*Insert*], [*Delete*], [*Search*], [*Insert*], [*Delete*], [*Search*],
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
  )[#text(size: 0.8em)[\*: Amortised - ie over a sequence of this operation. Resizing vector $O(n)$ \ \*\*: Remove highest priority]]
)

#image("complexity.png")

= Complexity

== Master Theorem

#grid(
  columns: 2,
  column-gutter: 2pt,
  [
    $T(n)=a T(n / b) + f(n)$

    $T(x)=cases( Theta(n^d) "if" a<b^d, Theta(n^d log(n)) "if" a=b^d, Theta(n^(log_b(n))) "if" a>b^d)$
  ],
  [
    *a*: number of subproblems in the recursion\
    *n/b*: size of each subproblem\
    *d*: the exponent in the cost of the work done outside the recursive calls, specifically in the non-recursive part of the algorithm (like splitting or merging the problem)\
  ],
)
e.g. *Binary Search* a=1 b=2 d=0 $log(n)$ *Merge Sort* a=2 b=2 d=1 $n log(n)$

== Bound

=== Big O - Upper Bound
$f(n) = O(g(n))$ iff (if and only if)\
$exists c in RR^\+, exists n_0 in NN, "such that" forall n >= n_0 : f(n) <= c g(n)$

=== Big $ohm$ - Lower Bound
$f(n) = Omega(g(n))$ iff (if and only if)\
$exists c in RR^\+, exists n_0 in NN, "such that" forall n >= n_0 : f(n) >= c g(n)$

=== Big $Theta$ - Tight Bound
$f(n) = Theta(g(n))$ iff (if and only if)\
$f(n) = O(g(n)) "and" f(n) = Omega(g(n))$

=== Little o upper Bound
$exists c in RR^\*, exists n_0 in NN, "such that" forall n >= n_0 "such that" f(n) < c g(n) (abs(f(n)/g(n))<c)$\
In other words: $limits(lim)_(n arrow.r infinity) f(n)/g(n) = 0$

= Sorting

== Selection
不断从未排序部分中选择最小（或最大）元素，并将其与第一个未排序元素交换，每次迭代后将排序边界向前移动一步 repeatedly selects the smallest (or largest) element from the unsorted portion of an array and swaps it with the first unsorted element, moving the sorted boundary one step forward with each iteration
```cpp
for (int i = 0; i < array.size(); i++) {
  // Find min element from i to n-1
  for (int j = i + 1; i < array.size(); j++) {
  }
  // Swap elements at index i and min elements
}
```

== Insertion
逐一将未排序部分的下一个元素插入到（不断交换）已排序部分的正确位置，逐步构建出一个已排序的数组 builds the sorted array one element at a time by repeatedly taking the next unsorted element and inserting it into its correct position in the sorted part
```cpp
for (int i = 1; i < array.size(); i++) {
  for (int j = i; j > 0; j--) {
    if (array.at(j) < array.at(j - 1)) {
      swap(array.at(j - 1), array.at(j));
    } else break;
  }
}
```

== Bubble
repeatedly compares adjacent elements and swaps them if they are in the wrong order, causing larger elements to "bubble" to the end of the array. With each pass through the list, the largest (or smallest) element settles in its correct position, and this process continues until the entire array is sorted.
```cpp
for (int i = array.size() - 1; i > 0; i--) {
		for (int j = 0; j < i; j++) {
			if (array.at(j) > array.at(j + 1)) {
				swap(array.at(j), array.at(j + 1));
			}
		}
	}
```

== Merge
#grid(
  columns: (3fr, 7fr),
  image("merge-sort.png"),
  [
    ```cpp
    if (array.size() == 1) return array;
    // Sort left and right subarrays
    int mid = array.size() / 2;
    // ... Define left and right arrays
    vector<int> sortedRightArray = sort(rightArray);
    vector<int> sortedLeftArray = sort(leftArray);
    // Merge left and right subarrays
    vector<int> result;
    int l = 0, r = 0;
    while (l < sortedLeftArray.size() && r < sortedRightArray.size()) {
      if (sortedLeftArray.at(l) < sortedRightArray.at(r)) {
        result.push_back(sortedLeftArray.at(l)); l++;
      } else {
        result.push_back(sortedRightArray.at(r)); r++;
      }
    }
    // ... Add remaining elements form sortedLeftArray or sortedRightArray
    return result;
    ```
  ],
)

== Quick
```cpp
if (start >= end) return;
// Select the last element as pivot
int pivot = array.at(end);
int pivotIndex = start;
for (int i = start; i < end; i++) {
  if (array.at(i) < pivot) {
    swap(array.at(i), array.at(pivotIndex));
    pivotIndex++;
  }
}
swap(array.at(pivotIndex), pivot);
sort(array, start, pivotIndex - 1);
sort(array, pivotIndex + 1, end);
```
