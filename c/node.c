#include <stdio.h>
#include <stdlib.h>

typedef struct {
	int data;
	struct Node* next;
} Node;

void Insert(Node** head, int x) {
	Node* temp = (Node*)malloc(sizeof(Node));
	temp->data = x;
	temp->next = NULL;
	if(*head != NULL)
		temp->next = *head;
	*head = temp;
}

void Print(Node *head) {
	printf("List is: ");
	while(head != NULL)
	{
		printf(" %d", head->data);
		head = head->next;
	}
	printf("\n");
}

int main() {
	Node* head = NULL; 		// emtpy list
	int n;
	int i;
	int x;
	printf("How many numbers?\n");
	scanf("%d", &n);

	for(i=0;i<n;i++){
		printf("Enter the number \n");
		scanf("%d", &x);
		Insert(&head, x);
		Print(head);
	}
	return 0;
}
