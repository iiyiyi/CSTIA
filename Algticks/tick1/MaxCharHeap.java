package uk.ac.cam.yc440.Algorithms.Tick1;

import uk.ac.cam.rkh23.Algorithms.Tick1.MaxCharHeapInterface;
import uk.ac.cam.rkh23.Algorithms.Tick1.EmptyHeapException;

public class MaxCharHeap implements MaxCharHeapInterface{
	private char[] heapArray;
	private int heapLength;
	
	public MaxCharHeap(String s){
		heapLength = 0;
		heapArray = new char[s.length()];
		for (int i=0; i<s.length(); i++) insert(s.charAt(i));
	}

	// Get and remove the maximum value (or exception if empty)
	@Override
	public char getMax() throws EmptyHeapException{
		if (heapLength == 0){
		    throw new EmptyHeapException();
		}
		char maximum = heapArray[0];
		heapArray[0] = heapArray[heapLength-1];
		heapLength--;
		updateFromTop();
		return maximum;
	}

	// Insert a new value into the heap
	@Override
	public void insert(char x){
	    x = Character.toLowerCase(x); // ATTENTION: do not forget to convert x to lowercase 
		if (heapLength + 1 > heapArray.length)
		{
			int[] biggerArray = new int[heapArray.length * 2];
			for (int i=0; i<heapArray.length; i++)
     				biggerArray[i] = heapArray[i];
		}
		heapLength++;
		heapArray[heapLength-1] = x;
		updateFromBottom();
	}

	// Get the number of items in the heap
	@Override
	public int getLength(){
		return heapLength;
	}

	private void updateFromTop(){
		int current = 0;
		int left = getLeftChild(current);
		int right = getRightChild(current);
		while (!isLeaf(current))
		{
		    int next;
		    if (hasRightChild(current)){
		        next = (heapArray[left]>heapArray[right])?left:right;
		    }
		    else next = left;
		    if (heapArray[next]>heapArray[current]){
    		    	swap(current, next);
			current = next;
			left = getLeftChild(current);
			right = getRightChild(current);
		    }
		    else break;
		}
	}
	
	private void updateFromBottom(){
		int current = heapLength - 1;
		int parent = getParent(current);
		while (!isRoot(current) && heapArray[current] > heapArray[parent]){
			swap(current, parent);
			current = parent;
			parent = getParent(current);
		}
	}

	private int getLeftChild(int n) {return (n*2 + 1);}
	private int getRightChild(int n) {return (n*2 + 2);}
	private int getParent(int n) {return (n-1)/2;}
	private boolean isLeaf(int n) {return n*2 + 1>= heapLength?true:false;} // ATTENTION: >= instead of >
	private boolean isRoot(int n) {return n==0?true:false;}
	private boolean hasRightChild(int n) {return n*2 + 2>=heapLength?false:true;} // ATTENTION: DON'T forget to check right child
	private void swap(int a, int b){
		char temp = heapArray[a];
		heapArray[a] = heapArray[b];
		heapArray[b] = temp;
	}
}
