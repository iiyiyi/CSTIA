package uk.ac.cam.yc440.Algorithms.Tick1Star;

import uk.ac.cam.rkh23.Algorithms.Tick1.EmptyHeapException;
import uk.ac.cam.rkh23.Algorithms.Tick1Star.MaxHeapInterface;
import java.util.*;

public class MaxHeap< T extends Comparable<T> > implements MaxHeapInterface<T> {
	protected List<T> heapArray;
	
	public MaxHeap(List<T> list){
		heapArray = new ArrayList<T>();
		for (T s : list) insert(s);
	}

	// Get and remove the maximum value (or exception if empty)
	@Override
	public T getMax() throws EmptyHeapException{
		if (getLength() == 0){
		    throw new EmptyHeapException();
		}
		T maximum = heapArray.get(0);
		heapArray.set(0, heapArray.get(getLength()-1));
		heapArray.remove(getLength()-1);
		updateFromTop();
		return maximum;
	}

	// Insert a new value into the heap
	@Override
	public void insert(T x){
		heapArray.add(x);
		updateFromBottom();
	}

	// Get the number of items in the heap
	@Override
	public int getLength(){
		return heapArray.size();
	}

	private void updateFromTop(){
		int current = 0;
		int left = getLeftChild(current);
		int right = getRightChild(current);
		while (!isLeaf(current))
		{
		    int next;
		    if (hasRightChild(current)){
		        next = heapArray.get(left).compareTo(heapArray.get(right))>0?left:right;
		    }
		    else next = left;
		    if (heapArray.get(next).compareTo(heapArray.get(current)) > 0){
    		    Collections.swap(heapArray, current, next);
			    current = next;
			    left = getLeftChild(current);
			    right = getRightChild(current);
		    }
		    else break;
		}
	}

	private void updateFromBottom(){
		int current = getLength() - 1;
		int parent = getParent(current);
		while (!isRoot(current) && heapArray.get(current).compareTo(heapArray.get(parent))>0){
			Collections.swap(heapArray, current, parent);
			current = parent;
			parent = getParent(current);
		}
	}

	protected int getLeftChild(int n) {return (n*2 + 1);}
	protected int getRightChild(int n) {return (n*2 + 2);}
	protected int getParent(int n) {return (n-1)/2;}
	protected boolean hasRightChild(int n) {return n*2 + 2>= getLength()?false:true;} // ATTENTION: DON'T forget to check the right child
	protected boolean isLeaf(int n) {return n*2 + 1>= getLength()?true:false;} // ATTENTION: >= instead of >
	protected boolean isRoot(int n) {return n==0?true:false;}
}
