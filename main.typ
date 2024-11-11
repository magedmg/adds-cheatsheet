#set page(margin: 0cm, columns: 3)
#set columns(gutter: 0pt)
#set text(size: 8pt, font: "Roboto")
#set table(inset: 2pt, align: horizon + center, stroke: 0.4pt)
#set heading(numbering: "I.1")
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 0.5em,
  radius: 2pt,
  sticky: true,
)
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 2pt, y: 0pt),
  outset: (y: 2pt),
  radius: 2pt,
)
#let false-option(t) = text(fill: red)[#t]

= SOLID

== Single Responsibility Principle (SRP)
- *Definition*: A class should have only one reason to change, meaning it should only handle one responsibility.
- *Violation*: A `User` class handles both storing user data and sending emails to new users. This means it’s responsible for managing data and handling email communication, which are two distinct tasks.
- *Fix*: Create separate classes: a `UserDataService` to handle user data and an `EmailService` to handle email communication.
- *Explanation*: By splitting the responsibilities, we make each class easier to maintain and understand. If there’s a change in how we send emails, we only modify the `EmailService`, leaving the `UserDataService` untouched.

== Open/Closed Principle (OCP)
- *Definition*: Classes should be open for extension but closed for modification, allowing new functionality without altering existing code.
- *Violation*: A `DiscountCalculator` class has logic to apply discounts based on customer types like "Regular" and "VIP." When a new customer type, "Premium," is introduced, the class needs modification to add the new discount rule.
- *Fix*: Create individual discount strategies for each customer type that can be applied without modifying the `DiscountCalculator`. For example, use separate classes like `RegularDiscount`, `VIPDiscount`, and `PremiumDiscount` that `DiscountCalculator` can use without needing changes.
- *Explanation*: This makes it easy to add new discounts without modifying existing code, reducing the risk of bugs and keeping the system stable as it grows.

== Liskov Substitution Principle (LSP)
- *Definition*: Subtypes should be substitutable for their base types. If a function uses a base class, it should work with any subclass without issue.
- *Violation*: Suppose there’s a `Bird` class with a `fly` method. If we create a `Penguin` class that inherits from `Bird` but overrides the `fly` method to throw an error (because penguins can’t fly), it breaks the substitution.
- *Fix*: Use a different hierarchy or interface that better represents different types of birds. For instance, create a `FlyingBird` class that includes `fly` only for birds that actually fly, and a `NonFlyingBird` class for those that don’t.
- *Explanation*: This maintains predictable behavior. By ensuring subclasses behave consistently with the base class, the code is easier to understand and maintain.

== Interface Segregation Principle (ISP)
- *Definition*: A class should not be forced to implement interfaces it doesn’t use. Instead, create smaller, more specific interfaces.
- *Violation*: Imagine an interface called `Worker` with methods like `startWork`, `stopWork`, and `submitReport`. If some workers only need `startWork` and `stopWork` and have no use for `submitReport`, they’re forced to implement an unnecessary method.
- *Fix*: Split the `Worker` interface into smaller interfaces like `Workable` (with `startWork` and `stopWork`) and `Reportable` (with `submitReport`). Classes can implement only the interfaces they need.
- *Explanation*: By dividing interfaces into focused ones, classes only depend on what they actually need. This keeps classes and interfaces lean, reducing complexity and making them easier to maintain.

== Dependency Inversion Principle (DIP)
- *Definition*: High-level modules should not depend on low-level modules; both should depend on abstractions. Abstractions should not depend on details.
- *Violation*: A `Report` class directly creates a `PDFGenerator` to generate reports. This tightly couples the `Report` to the specific `PDFGenerator`, making it difficult to switch to another report generator without modifying `Report`.
- *Fix*: Define an interface, such as `ReportGenerator`, that `PDFGenerator` implements. Now, `Report` depends on `ReportGenerator` rather than the concrete `PDFGenerator`, allowing flexibility.
- *Explanation*: By depending on abstractions, the `Report` class can work with any `ReportGenerator` implementation. This makes the system more modular and flexible for changes, as new types of report generators can be added without altering the `Report` class.

= Recursion

- *Tail recursion* uses less memory than non-tail recursion.

== Tail Recursion
=== Cost of recursion
- Each call to a function adds another frame on the stack
- Each frame contains local variables and parameters and where to return the result
=== Reducing what needs to be stored
- If we can guarantee we won't need them, we can free the memory for the local variables and parameters.
- We won't need them as long as *we do not use them after the recursive call*.
- Tail recursive functions have the *recursive call as the last thing the function does before it returns*.

= Complexity

== Master Theorem

$T(n)=a T(n / b) + f(n)$

$T(x)=cases( Theta(n^d) "if" a<b^d, Theta(n^d log(n)) "if" a=b^d, Theta(n^(log_b(n))) "if" a>b^d)$

*a*: number of subproblems in the recursion\
*n/b*: size of each subproblem\
*d*: the exponent in the cost of the work done outside the recursive calls, specifically in the non-recursive part of the algorithm (like splitting or merging the problem)\

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

== Quiz
===
- if $f(n)=Theta(g(n)) $ then $g(n)=Theta(f(n))$
- #false-option[if $f(n)=O(n)$ then $f(n)=o(n)$]
- if $f(n)=o(n)$ and $g(n)=o(n)$ then $f(n)+g(n)=o(n)$
- #false-option[$O(n)$ is the complexity in the worst case]
- #false-option[if $f(n)=Omega(g(n))$ and $f(n)=O(h(n))$, then $g(n)<=h(n)$ for all $n>0$]
===
$o(n^2)$ = $sqrt(n)$ / $1$ / $n log(n)$ / $n$
===
*$1$* < *$log(n)$* < $log(n^2)$ < $(log(n))^2$ < $5n log(log(n)) + 100$ < *$n$* < *$n log(n)$* < $n^1.5+1000000$ < *$n^2$* < *$n^3$* < *$2^n$* < $3^n$ < *$n!$* < *$n^n$*
===
- #false-option[If $f(n)=O(g(n))$, then $f(n)=o(g(n))$. The opposite is not true, because Little o assumes that $f(n)$ and $g(n)$ can't be of the same order.]
- If $f(n)=o(g(n))$, then $f(n)=O(g(n))$. The opposite is not true, because Little o assumes that $f(n)$ and $g(n)$ can't be of the same order.
- #false-option[$f(n)=o(g(n))$ if and only if $f(n)=O(g(n))$.]
- #false-option[If $f(n)=O(g(n))$ it does not mean $f(n)=o(g(n))$, and if $f(n)=o(g(n))$ it does not mean $f(n)=O(g(n))$.]
===
- $f(n)=Theta(g(n)) "if and only if" f(n)=O(g(n)) "and" f(n)=ohm(g(n))$
- $n=o(n^2) "and" n=O(n^2)$
- #false-option[$"If" f(n)=ohm(n), "then" f(n)>=n "for all" n "starting from some" n_0$]
- $"If" f(n)=o(g(n)) "and" g(n) = O(h(n)), "then" f(n)=o(h(n))$
===
Suppose we need to find an occurrence of the array of size m inside a larger array of size n. We know that the array of size n is sorted and consists of unique elements. What will be the time complexity of the optimal algorithm?
- $Theta(log(n)+m)$

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
#image("merge-sort.png", width: 80%)
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

= Linked List & Friend Class

#pagebreak()
#set page(columns: 2)
#include "complexity.typ"