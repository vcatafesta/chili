#include <stdio.h>
#include <stdlib.h>

struct node {
	int data;
	struct node *prox;
};

void add_at_pos(struct node* head, int data, int pos)
{
	struct node *ptr  = head;
	struct node *ptr2 = malloc(sizeof(struct node));
	ptr2->data = data;
	ptr2->prox = NULL;

	pos--;
	while(pos != 1)
	{
		ptr = ptr->prox;
		pos--;
	}
	ptr2->prox = ptr->prox;
	ptr->prox  = ptr2;
}

struct node* del_last(struct node *head)
{
	if(head == NULL)
		printf("List is already empty!");
	else if(head->prox == NULL){
		free(head);
		head = NULL;
	}else	{
		struct node *temp = head;
		struct node *temp2 = head;
		while(temp->prox != NULL){
			temp2 = temp;
			temp = temp->prox;
		}
		temp2->prox = NULL;
		free(temp);
		temp = NULL;
	}
	return head;
}

struct node* add_at_begin(struct node* head, int data)
{
	struct node *ptr = malloc(sizeof(struct node));
	ptr->data = data;
	ptr->prox = NULL;

	ptr->prox = head;
	head = ptr;
	return head;
}

int main(){
	struct node *head = malloc(sizeof(struct node));	
	if(head){
		head->data = 45;
		head->prox = NULL;
		printf("%d\n", head->data);
	}

	int data     = 3;

	struct node *ptr  = malloc(sizeof(struct node));
	if(ptr){
		ptr->data  = 55;
		ptr->prox  = NULL;
		head->prox = ptr;
		head       = add_at_begin(head, data);
		ptr        = head;
		while(ptr != NULL){
			printf("ptr->data : %d\n", ptr->data);
			ptr = ptr->prox;
		}
	}

	int position = 3;
	add_at_pos(head, data, position);
	struct node *ptr2 = head;

	while(ptr2 != NULL){
		printf("ptr2->data : %d\n", ptr2->data);
		ptr2 = ptr2->prox;
	}

	head = del_last(head);
	ptr = head;
	while(ptr != NULL){
		printf("ptr2->data : %d\n", ptr->data);
		ptr = ptr->prox;
	}

	return 0;
}
