#include <stdio.h>
#include <stdlib.h>
#define LENVETOR(vetor)		(sizeof(vetor)/sizeof(vetor[0]))
#define w						printf

struct Node {
   int idata;
   struct Node *next;
};
struct Node *head;

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
   temp  = *top1;
   val   = temp->idata;
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

/*****************************************************************************/

struct Node *get(int pos) {
   struct Node *current = head;

   int i;
   for(i=0; i<pos; i++) {
      current = current->next;
   }
   return current;
}

void insert(int pos, int value) {
   struct Node *newNode = (struct Node *)malloc(sizeof(struct Node));
   newNode->idata = value;
   newNode->next  = 0;

   if(pos == 0) {
      newNode->next = head;
      head          = newNode;
   } else {
      struct Node *prev = get(pos-1);
      struct Node *curr = prev->next;
      newNode->next     = curr;
      prev->next        = newNode;
   }
}

void delete(int pos) {
   if(pos == 0) {
      struct Node *toDelete = head;
      head = toDelete->next;
      free(toDelete);
   } else {
      struct Node *prev     = get(pos-1);
      struct Node *toDelete = prev->next;
      prev->next            = toDelete->next;
      free(toDelete);
   }
}

void destroy() {
   struct Node *current = head;
   struct Node *prev;

   while(current != 0) {
      prev = current;
      current = current->next;
      free(prev);
   }
}

void display() {
   struct Node *current = head;
   while(current != 0) {
      printf("Address: %p, Value: %d\n", current, current->idata);
      current = current->next;
   }
}

/*****************************************************************************/

int main() {
   struct Node *head    = (struct Node *)malloc(sizeof(struct Node));
   struct Node *newnode;
   struct Node *top     = (struct Node *)malloc(sizeof(struct Node)); // NULL;
   struct Node *top1    = (struct Node *)malloc(sizeof(struct Node)); // NULL;
   struct Node third    = {3, 0};
   struct Node second   = {2, &third};
   struct Node first    = {1, &second};
   int i;
   int idata;

   head = 0;
   insert(0,1);
   insert(1,2);
   insert(2,3);
   insert(3,4);
   insert(0,5);
   insert(0,6);
   display();
   printf("\n");
   delete(0);
   delete(2);
   display();
   destroy();


   w("item 1 : %d\n", first.idata);
   w("item 2 : %d\n", first.next->idata);
   w("item 3 : %d\n", first.next->next->idata);


//   head->idata       = 45;
//   head->next        = NULL;
//
//   newnode = (struct Node *)malloc(sizeof(struct Node));
//   newnode->idata = 98;
//   newnode->next  = NULL;
//   head->next     = newnode;
//
//   for(i=0; i<1; i++)
//      add_node_at_end(head, i);
//   count_of_nodes(head);
//
//   for(i=0; i<1; i++)
//      add_node_at_begin(&head, i);
//   count_of_nodes(head);
//
//   add_node_at_pos(&head, 55, 2);
//   count_of_nodes(head);
//
//   print_data_nodes(head);
//   Print_node(head);
//   count_of_nodes(head);
//
//   push(1, &top);
//   push(2, &top);
//   idata = pop(&top);
//   push(idata, &top1);
//   count_of_nodes(head);
//
//   w("head->idata : %d\n", head->idata);
//   w("head->idata : %d\n", head->next->idata);
//   w("head->idata : %d\n", head->next->next->idata);

   return 0;
}
