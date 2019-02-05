package uk.ac.cam.yc440.Algorithms.Tick1Star;

import uk.ac.cam.rkh23.Algorithms.Tick1.EmptyHeapException;
import uk.ac.cam.rkh23.Algorithms.Tick1Star.MaxHeapInterface;
import java.util.*;

public class BottomUpMaxHeap<T extends Comparable<T>> extends MaxHeap<T>{
	public BottomUpMaxHeap(List<T> list){
		super(list);
	}

	@Override 
	public T getMax() throws EmptyHeapException{
		if (getLength() == 0){
		    throw new EmptyHeapException();
		}
		T maximum = heapArray.get(0);

		//Swap the end element and the root as before. Save the new root value in a temporary variable.
		heapArray.set(0, heapArray.get(getLength()-1));
		heapArray.remove(getLength()-1);
		
		if (getLength()>0){
			T newrootvalue = heapArray.get(0);

		//Walk down the tree, always following the biggest child. We end up at a leaf with, say, index L.
			int L = 0;
			while (!isLeaf(L)){
				int left = getLeftChild(L);
				int right = getRightChild(L);
		       	if (hasRightChild(L)){
		       	    L = heapArray.get(left).compareTo(heapArray.get(right))>0?left:right;
		       	}
		       	else L = left;
			}

		//Now walk up the tree, starting from L. Stop when we find a value that is bigger than the new root held in the temporary variable: this is where the root element needs to end up. Call the index for this position p.
			while (!isRoot(L) && heapArray.get(L).compareTo(newrootvalue)<0) L = getParent(L);
			int p = L;

		//Continue walking up, starting at p. However, now we push up each element to be its parent. This leaves a void at position p, which we fill with the root value. No comparisons are made for this stage.
			T nextValue = heapArray.get(L);
			while (!isRoot(L)){
				int next = getParent(L);
				T currentValue = nextValue;
				nextValue = heapArray.get(next);
				heapArray.set(next, currentValue);
				L = next;
			}
			heapArray.set(p, newrootvalue);
		}	
		return maximum;
	}
}	
