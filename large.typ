#set page(numbering: "1")
#set text(size: 11pt, font: "Roboto")
#set table(inset: 2pt, align: horizon + center, stroke: 0.4pt)
#set heading(numbering: "I.1")
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 0.5em,
  radius: 2pt,
)
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 2pt, y: 0pt),
  outset: (y: 2pt),
  radius: 2pt,
)
#let redt(t) = text(fill: red)[#t]
#show emph: t => {
  text(style: "italic")[#underline(t)]
}

#outline(depth: 1)

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

$T(x)=cases(Theta(n^d) "if" a<b^d, Theta(n^d log(n)) "if" a=b^d, Theta(n^(log_b(n))) "if" a>b^d)$

*a*: number of subproblems in the recursion\
*n/b*: size of each subproblem\
*d*: the exponent in the cost of the work done outside the recursive calls, specifically in the non-recursive part of the algorithm (like splitting or merging the problem)\

e.g. *Binary Search* a=1 b=2 d=0 $log(n)$ *Merge Sort* a=2 b=2 d=1 $n log(n)$

== Bound

=== Big O - Upper Bound
$f(n) = O(g(n))$ iff (if and only if)\
$exists c in RR^\+, exists n_0 in NN, "such that" forall n >= n_0 : f(n) <= c g(n)$

=== Big $Omega$ - Lower Bound
$f(n) = Omega(g(n))$ iff (if and only if)\
$exists c in RR^\+, exists n_0 in NN, "such that" forall n >= n_0 : f(n) >= c g(n)$

=== Big $Theta$ - Tight Bound
$f(n) = Theta(g(n))$ iff (if and only if)\
$f(n) = O(g(n)) "and" f(n) = Omega(g(n))$

=== Little o upper Bound
$exists c in RR^\*, exists n_0 in NN, "such that" forall n >= n_0 "such that" f(n) < c g(n) (abs(f(n) / g(n))<c)$\
In other words: $limits(lim)_(n arrow.r infinity) f(n) / g(n) = 0$

== Quiz
===
- if $f(n)=Theta(g(n))$ then $g(n)=Theta(f(n))$
- #redt[if $f(n)=O(n)$ then $f(n)=o(n)$]
- if $f(n)=o(n)$ and $g(n)=o(n)$ then $f(n)+g(n)=o(n)$
- #redt[$O(n)$ is the complexity in the worst case]
- #redt[if $f(n)=Omega(g(n))$ and $f(n)=O(h(n))$, then $g(n)<=h(n)$ for all $n>0$]
===
$o(n^2)$ = $sqrt(n)$ / $1$ / $n log(n)$ / $n$
===
*$1$* < *$log(n)$* < $log(n^2)$ < $(log(n))^2$ < $5n log(log(n)) + 100$ < *$n$* < *$n log(n)$* < $n^1.5+1000000$ < *$n^2$* < *$n^3$* < *$2^n$* < $3^n$ < *$n!$* < *$n^n$*
===
- #redt[If $f(n)=O(g(n))$, then $f(n)=o(g(n))$. The opposite is not true, because Little o assumes that $f(n)$ and $g(n)$ can't be of the same order.]
- If $f(n)=o(g(n))$, then $f(n)=O(g(n))$. The opposite is not true, because Little o assumes that $f(n)$ and $g(n)$ can't be of the same order.
- #redt[$f(n)=o(g(n))$ if and only if $f(n)=O(g(n))$.]
- #redt[If $f(n)=O(g(n))$ it does not mean $f(n)=o(g(n))$, and if $f(n)=o(g(n))$ it does not mean $f(n)=O(g(n))$.]
===
- $f(n)=Theta(g(n)) "if and only if" f(n)=O(g(n)) "and" f(n)=Omega(g(n))$
- $n=o(n^2) "and" n=O(n^2)$
- #redt[$"If" f(n)=Omega(n), "then" f(n)>=n "for all" n "starting from some" n_0$]
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

```cpp
template <class T>
class Node {
	T data;
	Node<T>* link;
	Node(T data) {
		this->data = data;
	}
public:
	template <class U>
	friend class LinkedList;
};

template <class T>
class LinkedList {
	Node<T>* head;
	bool isEmpty() {
		return this->head == NULL;
	}
public:
	LinkedList() {
		this->head = NULL;
	}
	void insert(T value) {
		Node<T>* newNode = new Node<T>(value);
		newNode->link = this->head;
		this->head = newNode;
	}
	void traverse() {
		if (isEmpty()) {
			cout << "List is empty\n";
			return;
		}
		Node<T>* tmp = this->head;
		while (tmp != NULL) {
			cout << tmp->data << " ";
			tmp = tmp->link;
		}
		cout << endl;
	}
};
```

== Quiz
===
- #redt[Linked lists require at least two methods for insertion, one to cover addition at the front and another for addition at an arbitrary position.]
- #redt[Linked lists have $O(1)$ access to any node.]
- Linked lists are not guaranteed to have their nodes located in adjacent blocks of memory.
- Linked lists have an aggregation relationship with nodes.
===
- A singly linked list has all the nodes linking in one direction.
- #redt[A singly linked list can have a tail as well as head. When it does, insertion and deletion at both either end becomes $O(1)$]
- Insertion/deletion from the front of a singly linked list is $O(1)$.
- #redt[A singly linked list cannot have a tail member variable that records where the last node is in memory, as it violates the definition of the singly linked list.]

= Stack & Queue

== Stack
- LIFO (Last-in/First-out)
- implemented using linked lists or dynamic arrays
- `push(item)` `pop()` `isEmpty()`
- only have access to the top of the stack

== Queue
- FIFO (First-in/First-out)
- usually implemented using linked lists
- `enqueue(item)` `dequeue()` `isEmpty()`
- You have access to both the front and back of the queue.

== Quiz
===
- #redt[Removing an element from a queue requires the queue to search through all of the remaining elements to update their positions and ensure that the queue is properly ordered, resulting in a time complexity of O(n).]
- #redt[Solving the Tower of Hanoi maps well to the queue data structure.]
- Queues are FIFO/LILO.
- #redt[Since queues involve operations at both ends, they must be implemented using a doubly linked list.]

===
- #redt[A priority queue implemented using a single queue where each node has a priority value, has both $O(n)$ insertion and $O(n)$ removal.]
- #redt[A priority queue with n elements that is implemented using multiple queues (with a queue for each priority) have $O(n)$ removal.]
- A priority queue with n elements that is implemented using multiple queues (with a queue for each priority) have $O(1)$ insertion.
- A priority queue implemented using a single queue where each node has a priority value, has either $O(n)$ insertion or $O(n)$ removal.
==== Explanation
- Priority queues with n nodes implemented using multiple queues, have:
  - $O(1)$ insertion, as at the time of insertion you know what priority the node will have so you can simply find which queue it should belong to in $O(1)$, and then insert to the back of that queue in $O(1)$.
  - $O(m)$ removal, where m is the number of queues. This is because we need to run the isEmpty function on up to m queues.
- Priority queues implemented using one queue will either have either $O(n)$ insertion or removal. Because you have to check who the highest priority is either:
  - At insertion, to place them in the appropriate position. They "cut" in line.
  - At removal, to take out the appropriate item.

= Tree

== Tree Traversals
- Level Order (level by level) 1, 4, 2, 6, 5, 3
- In-order (left, root, right) 6, 4, 5, 1, 3, 2
- Pre-order (root, left, right) 1, 4, 6, 5, 2, 3
- Post-order (left, right, root) 6, 5, 4, 3, 2, 1
#image("tree-traversals.png", width: 40%)

== BST Delete
- *0 child*: just delete
- *1 child*: set parent's pointer to point to the one child
- *2 children*: replace with in-order successor child (leftmost child of right subtree)

== Trie
#image("trie.png", width: 60%)
- Tries are a tree data structure that are particularly suited for searching for keys that begin with a specific prefix
- Usually, these keys are strings
- Each path from root represents one key
```cpp
struct TrieNode {
	bool isEndOfWord;
	vector<TrieNode*> childern;
}
```
=== Adding keys
#grid(
  columns: (9fr, 1fr),
  [
    - While the key forms a path in the trie, follow the trie while next key character matches the characters in trie
    - Add remaining non-matching key characters to tree, mark node with last character as end of word
    - Example: Insert “ape” and “apes” - nodes coloured #redt[red] have `isEndOfWord == true`
  ],
  image("trie-add.png"),
)
=== Deleting key
```cpp
// If root is nullptr, key is not in the Trie
if (!root) return nullptr;
// If we've reached the end of the key
if (depth == key.length()) {
	// This node is no longer an end of a word
	if (root->isEndOfWord) root->isEndOfWord = false;
	// If node has no children, delete it (free memory) and return nullptr
	if (root->children.empty()) {
		delete root;
		return nullptr;
	}
	return root;
}
// Recursive case for deleting in child
char ch = key[depth];
root->children[ch] = deleteKey(root->children[ch], key, depth + 1);
// If no children and not end of word, delete this node
if (root->children.empty() && !root->isEndOfWord) {
	delete root;
	return nullptr;
}
return root;
```

== Quiz
===
The height of a binary tree can not have a tight bound
===
Running time of searching a Binary Search Tree with n nodes: $Theta("height")$
===
The minimum number of nodes that could be in a balanced binary tree of height h: $2^h$
===
In a red black, we keep the same number of black nodes between a given node and any other node. The reason for this is: to ensure search is $log(n)$
===
For which of the following would a Trie be a good choice of Tree data structure
- Storing key-value pairs with string keys
- Storing a collection of unsorted strings
- #redt[Storing key-value pairs with integer keys]
- #redt[Storing a collection of unsorted integers]

= Heap

== Binary Tree in array
- If a node is at index $i$
- Its left child is at $2*i$
- Its right child is at $2*i+1$
- Its parent is at $floor(i / 2)$

== Operations
Swap the node with the largest(smallest) child until the heap property is satisfied
- *Insert*: bottom to top
- *Delete*: top to bottom
- *Heapify*: bottom to top (back to front)

== Quiz
===
- A min-heap is a binary tree
- In a min-heap node after deletion, the maximum levels that a parent will sift down during heapify is O(log(n))
- #redt[A heap can become an unbalanced tree]
- #redt[When traversing by level a Heap implemented as a tree, the values will be in order from smallest to largest.]
===
When deleting the root node, which of the following should take place to restore the Heap
- #redt[sift up each of the leaf nodes]
- #redt[copy the value of the last element to the root and heapify the root element]
- copy the value of the last element to the root and delete the last element, heapify the root element.
- #redt[copy the value to the root and heapify each parent node starting from the bottom right parent working across tree to the left, level by level until the root node is heapified]
===
maximum depth of a Heap implemented as a Tree: $O(log(n))$
===
- Implementing a Heap as a vector will allow faster insertion deletion of elements compared to implementing as a Tree
- Implementing a Heap as a vector uses less memory compared to implementing as a Tree
- #redt[Implementing a Heap as a vector better matches the Heap abstraction compared to implementing as a Tree]
- #redt[Implementing a Heap as a vector results in a lower run-time complexity for all operations compared to implementing as a Tree]

= Red Black Tree
+ Root is always black
+ No two adjacent临近的 nodes are red
+ Any path between a node and any descendant (lower) node子孙 has the same number of black nodes

#let rotate-image-size = 96%
== Rotate
*Left*
#image("rbt/rotate/left.png", width: rotate-image-size)
*Right*
#image("rbt/rotate/right.png", width: rotate-image-size)

== Insert
=== Root
Change colour to black
=== Violated 2 & Uncle is #redt[*red*]
- Change parent and uncle to black
- Change grandparent to red
- Make grandparent n, and repeat
=== Violated 2 & Uncle is *black*
==== Left Left
rotate right, swap colours of parent and grandparent
==== Left Right
rotate left, then right, swap colours of new node and grandparent
==== Right Right
rotate left, swap colours of parent and grandparent
==== Right Left
rotate right, then left, swap colours of new node and grandparent
#image("rbt/insert.png")

== Delete
=== Simple Cases
- If a node is #redt[red] with nullptr child (no children)
- If a node has 1 child and *either* _the node_ OR _child_ (but not both) is #redt[red]
1. Delete node 2. Updated node #sym.arrow *black* (node replaced the deleted node)

=== Double Black
If both _node to be deleted_ AND _child_ are *black* (or the node has no children), the _updated node_ becomes *double black*

- n's _sibling_ is *black*
  - with at least one #redt[*red*] _child_
    + Rotate (as per insertion following path to #redt[red] _child_)
    + Recolour #redt[red] _child_ to *black*, _sibling_ to #redt[red]
  - with _all children_ *black*
    + Recolour sibling to #redt[red]
    + Push *black* up (*black* _parent_ #sym.arrow *double black*, #redt[red] _parent_ #sym.arrow *black*)
- n's _sibling_ is #redt[*red*]
  + Rotate
  + Recolour _Sibling_ to *black* _Parent_ to #redt[red]

= Selecting Data Structures and Algorithmic Strategies Quiz
==
- *Heap Sort*: Transform and Conquer
- *Memoisation*: Synamic Programming
- *Selection Sort*: Brute Force
- *Quick Sort*: Divide and Conquer
==
You need to store a list of words and know that words that were recently searched for are likely to be searched for again. *ANSWER: Linked List*

$O(n)$ to find a word and when a word is found, move it to the head (most recent will be at front of list) $O(1)$. The most recently searched for words will always be at the start of the list, improving the average case to find these words $O(1)$ if most recently searched word.
==
- *Linear Structures*: Queue, Linked List, Array, Heap, Stack, Vector
- *Non-linear Structures*: Red-Black Tree, Binary Search Tree, Trie
==
Which of the following C++ containers could be shuffled using the C++ shuffle function from the algorithm library? *ANSWER: vector, array*
==
- `list`: Doubly Linked List
- `priority_queue`: Heap
- `map` `set`: Red-Black Tree (balanced binary search tree)

==
We are implementing a scheduler for choosing the next process to run on a computer. System processes, that keep the computer running are more important than user processes (someone's C++ homework); but otherwise processes should be run on a first come first served basis Assuming we decide to keep all of these processes in a single ordered array, which sorting algorithms could be used (assume the base algorithms as you learned in this course, not variations). *ANSWER: Bubble Sort, Insertion Sort, Merge Sort*

#pagebreak()
#set page(columns: 2)
#set text(size: 7pt)
#image("bigo/bigo.jpg")
#image("bigo/bigomega.jpg")
#image("bigo/bigtheta.jpg")
#image("bigo/littleo.jpg")
#image("complexity.png")
#include "complexity.typ"

