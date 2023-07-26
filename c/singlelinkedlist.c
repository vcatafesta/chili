#include <stdio.h>
#include <stdlib.h>

#define LENVETOR(vetor)		(sizeof(vetor)/sizeof(vetor[0]))
#define w						printf

struct Node {
   int idata;
   struct Node *next;
};

void count_of_nodes(struct Node *head) {
   size_t count = 0;
   if(head == NULL)
      w("Linked List is empty!");
   struct Node *ptr = head;
   ptr = head;
   while(ptr != NULL) {
      count++;
      ptr = ptr->next;
   }
   w("count_of_nodes: %d\n", count);
}

void print_data_nodes(struct Node *head) {
   if(head == NULL)
      w("Linked List is empty!");
   struct Node *ptr = head;
   ptr = head;
   while(ptr != NULL) {
      w("print_data_nodes: %d\n", ptr->idata);
      ptr = ptr->next;
   }
}

void add_node_at_end(struct Node *head, int idata) {
   struct Node *ptr;
   struct Node *temp;
   ptr  = head;
   temp = (struct Node *)malloc(sizeof(struct Node));

   temp->idata = idata;
   temp->next  = NULL;

   while(ptr->next != NULL) {
      ptr = ptr->next;
   }
   ptr->next = temp;
}

void *add_node_at_begin(struct Node **head, int idata) {
   struct Node *newnode = (struct Node *)malloc(sizeof(struct Node));
   newnode->idata = idata;
   newnode->next  = *head;
   *head          = newnode;
}

void *add_node_at_pos(struct Node **head, int idata, int pos) {
   struct Node *ptr = *head;
   struct Node *newnode = (struct Node *)malloc(sizeof(struct Node));
   newnode->idata = idata;
   newnode->next  = *head;
   pos--;
   while(pos != 1) {
      ptr = ptr->next;
      pos--;
   }
   newnode->next = ptr->next;
   ptr->next = newnode;
}

void push(int idata, struct Node **top1) {
   struct Node *newNode = (struct Node *)malloc(sizeof(newNode));

   if(newNode == NULL) {
      printf("Stack overflow");
      exit(1);
   }
   newNode->idata = idata;
   newNode->next  = NULL;
   newNode->next = *top1;
   *top1 = newNode;
}

int pop(struct Node **top1) {
   struct Node* temp;
   int val;
   temp = *top1;
   val = temp->idata;
   *top1 = (*top1)->next;
   free(temp);
   temp = NULL;
   return val;
}

void Print_node(struct Node *head) {
   while(head != NULL) {
      w("Print_node : %d\n", head->idata);
      head = head->next;
   }
}

int main() {
   struct Node *head    = (struct Node *)malloc(sizeof(struct Node));
   struct Node *newnode;
   struct Node *top     = (struct Node *)malloc(sizeof(struct Node)); // NULL;
   struct Node *top1    = (struct Node *)malloc(sizeof(struct Node)); // NULL;
   int i;
   int idata;

   head->idata       = 45;
   head->next        = NULL;

   newnode = (struct Node *)malloc(sizeof(struct Node));
   newnode->idata = 98;
   newnode->next  = NULL;
   head->next     = newnode;

   for(i=0; i<1; i++)
      add_node_at_end(head, i);
   count_of_nodes(head);

   for(i=0; i<1; i++)
      add_node_at_begin(&head, i);
   count_of_nodes(head);

   add_node_at_pos(&head, 55, 2);
   count_of_nodes(head);

   print_data_nodes(head);
   Print_node(head);
   count_of_nodes(head);

   push(1, &top);
   push(2, &top);
   idata = pop(&top);
   push(idata, &top1);
   count_of_nodes(head);

   w("head->idata : %d\n", head->idata);
   w("head->idata : %d\n", head->next->idata);
   w("head->idata : %d\n", head->next->next->idata);

   return 0;
}
