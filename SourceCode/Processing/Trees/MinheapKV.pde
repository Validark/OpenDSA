// Min-heap implementation: Key-Value pairs
public class MinHeap {
  private KVPair[] Heap; // Pointer to the heap array
  private int size;    // Maximum size of the heap
  private int n;       // Number of things now in heap

  // Constructor supporting preloading of heap contents
  public MinHeap(KVPair[] h, int num, int max)
  { Heap = h;  n = num;  size = max;  buildheap(); }

  // Return current size of the heap
  public int heapsize() { return n; }

  // Return true if pos a leaf position, false otherwise
  public boolean isLeaf(int pos)
  { return (pos >= n/2) && (pos < n); }

  // Return position for left child of pos
  public int leftchild(int pos) {
    if (pos >= n/2) return -1;
    return 2*pos + 1;
  }

  // Return position for right child of pos
  public int rightchild(int pos) {
    if (pos >= (n-1)/2) return -1;
    return 2*pos + 2;
  }

  // Return position for parent
  public int parent(int pos) {
    if (pos <= 0) return -1;
    return (pos-1)/2;
  }

  // Insert val into heap
  public void insert(int key, Object val) {
    if (n >= size) {
      println("Heap is full");
      return;
    }
    int curr = n++;
    Heap[curr] = new KVPair(key, val);  // Start at end of heap
    // Now sift up until curr's parent's key < curr's key
    while ((curr != 0)  &&
           (Heap[curr].key() < Heap[parent(curr)].key())) {
      swap(Heap, curr, parent(curr));
      curr = parent(curr);
    }
  }

  // Heapify contents of Heap
  public void buildheap()
    { for (int i=n/2-1; i>=0; i--) siftdown(i); }

  // Put element in its correct place
  private void siftdown(int pos) {
    if ((pos < 0) || (pos >= n)) return; // Illegal position
    while (!isLeaf(pos)) {
      int j = leftchild(pos);
      if ((j<(n-1)) && (Heap[j].key() > Heap[j+1].key()))
        j++; // j is now index of child with greater value
      if (Heap[pos].key() <= Heap[j].key()) return;
      swap(Heap, pos, j);
      pos = j;  // Move down
    }
  }

  // Remove and return maximum value
  public KVPair removemin() {
    if (n == 0) return null;  // Removing from empty heap
    swap(Heap, 0, --n); // Swap maximum with last value
    if (n != 0)      // Not on last element
      siftdown(0);   // Put new heap root val in correct place
    return Heap[n];
  }

  // Remove and return element at specified position
  public KVPair remove(int pos) {
    if ((pos < 0) || (pos >= n)) return null; // Illegal heap position
    if (pos == (n-1)) n--; // Last element, no work to be done
    else {
      swap(Heap, pos, --n); // Swap with last value
      // If we just swapped in a big value, push it up
      while ((pos > 0) &&
             (Heap[pos].key() < Heap[parent(pos)].key())) {
        swap(Heap, pos, parent(pos));
        pos = parent(pos);
      }
      if (n != 0) siftdown(pos); // If it is little, push down
    }
    return Heap[n];
  }
}

