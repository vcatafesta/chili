// tree.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>

typedef struct treenode {
	int value;
	struct treenode *left;
	struct treenode *right;
} treenode;

treenode *createnode(int value) {
	treenode *result = malloc(sizeof(treenode));
	if (result != NULL) {
		result->left = NULL;
		result->right = NULL;
		result->value = value;
	}
	return result;
}

void printtabs(int numtabs) {
	for (int i=0; i< numtabs; i++) {
		printf("\t");
	}
}

void printtree_rec(treenode *root, int level) {
	if (root == NULL) {
		printtabs(level);
		printf("---<void>--\n");
		return;
	}
	printtabs(level);
	printf("value = %d\n", root->value);
	printtabs(level);
	printf("left\n");

	printtree_rec(root->left, level+1);
	printtabs(level);
	printf("right\n");

	printtree_rec(root->right, level+1);
	printtabs(level);
	printf("done\n");
	return;
}

void printtree(treenode *root) {
	printtree_rec(root, 0);
}

bool insert(treenode **rootptr, int value) {
	treenode *root = *rootptr;
	if (root == NULL) {
		// tree empty
		(*rootptr) = createnode(value);
		return true;
	}

	if (value == root->value) {
		// do nothing
		return false;
	}

	if (value < root->value) {
		return insert(&(root->left), value);
	} else {
		return insert(&(root->right), value);
	}
}

bool find(treenode *root, int value) {
	if (root == NULL) return false;
	if (root->value == value) {
		return true;
	}
	if (value < root->value == value) {
		return find(root->left, value);
	} else {
		return find(root->right, value);
	}
}

int main(int argc, char **argv) {
	treenode *root = NULL;
	insert(&root, 15);
	insert(&root, 11);
	insert(&root, 24);
	insert(&root, 5);
	insert(&root, 19);
	insert(&root, 16);
	printtree(root);
   printf("%d (%d)\n", 16, find(root, 16));
   printf("%d (%d)\n", 15, find(root, 15));
   printf("%d (%d)\n", 5, find(root, 5));
   printf("%d (%d)\n", 115, find(root, 115));
   printf("%d (%d)\n", 1, find(root, 1));
   printf("%d (%d)\n", 7, find(root, 7));
   return 0;
}

