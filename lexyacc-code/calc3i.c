#include <stdio.h>
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"


static int lbl;
char *registers[] = {"rax", "rbx", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"};

int ex(nodeType *p) {
    int lbl1, lbl2;

    if (!p) return 0;   // Ret if node is null
    switch(p->type) {
    case typeCon:       // If node is contstant -> 
        printf("\tpushq\t$%d\n", p->con.value); // Push constant onto stack
        break;
    case typeId:    // If variable -> push the value of the variable by its offset from the base pointer onto the stack
        printf("\tpushq\t%d(%%rbp)\n", -(p->id.i + 1) * 8);  // Adjusted to 8-byte offsets
        break;
    case typeOpr:       // If the node is an operator
        switch(p->opr.oper) {
        case WHILE:
            printf("L%03d:\n", lbl1 = lbl++);   // Start of loop, create label.
            lbl2 = lbl;
            ex(p->opr.op[0]);   // Evaluate condition
            //printf("\tjz\tL%03d\n", lbl2 = lbl++);
            ex(p->opr.op[1]); // Execute body
            printf("\tjmp\tL%03d\n", lbl1); // Jmp to start of the loop
            printf("L%03d:\n", lbl2); // Label for the end of the loop
            break;
        case IF:
            lbl2 = lbl;
            ex(p->opr.op[0]); // Evaluate condition
            if (p->opr.nops > 2) {
                /* if else */
                ex(p->opr.op[1]); // Do if branch
                printf("\tjmp\tL%03d\n", lbl1 = lbl++);
                printf("L%03d:\n", lbl2);
                ex(p->opr.op[2]);   // Else branch
                printf("L%03d:\n", lbl1);
            } else {
                /* if */
                //printf("\tjz\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("L%03d:\n", lbl2);
            }
            break;
        case PRINT:     
            ex(p->opr.op[0]); // Evaluate expression to print
            printf("\tpopq\t%%rsi\n");  // Pop result to rsi for printing
            printf("\tlea\tformat(%%rip), %%rdi\n");    // Load address of format string to rdi
            printf("\tmovq\t$0, %%rax\n");  // Clear rax
            printf("\tcall\tprintf\n"); // Call printf
            break;
        case '=':       
            ex(p->opr.op[1]);   // Evaluate right side
            printf("\tpopq\t%d(%%rbp)\n", -(p->opr.op[0]->id.i + 1) * 8); // Pop the result and store it in the variable 
            break;
        case UMINUS:    
            ex(p->opr.op[0]); // Evaluate expression
            printf("\tpopq\t%%rax\n");  // Pop into rax
            printf("\tneg\t%%rax\n");   // neg rax
            printf("\tpushq\t%%rax\n"); // push result back
            break;
    case FACT:
        ex(p->opr.op[0]); // Evaluate expression
        printf("%s%s%s", "\tcall\tfact\n", "\taddq\t$8,%rsp\n","\tpushq\t%rax\n"); // Call factorial function and adjust stack
        break;
    case LNTWO:
        ex(p->opr.op[0]);
        printf("\tcall\tlntwo\n");
        break;
        default:
            ex(p->opr.op[0]);
            ex(p->opr.op[1]);
            switch(p->opr.oper) {
        case GCD:   printf("\tcall\tgcd\n"); break;
            case '+':
                printf("\tpopq\t%%rbx\n");
                printf("\tpopq\t%%rax\n");
                printf("\taddq\t%%rbx, %%rax\n");
                printf("\tpushq\t%%rax\n");
                break;
            case '-':
                printf("\tpopq\t%%rbx\n");
                printf("\tpopq\t%%rax\n");
                printf("\tsubq\t%%rbx, %%rax\n");
                printf("\tpushq\t%%rax\n");
                break;
            case '*':
                printf("\tpopq\t%%rbx\n");
                printf("\tpopq\t%%rax\n");
                printf("\timulq\t%%rbx\n");
                printf("\tpushq\t%%rax\n");
                break;
            case '/':
                printf("\tpopq\t%%rbx\n");
                printf("\tpopq\t%%rax\n");
                printf("\tidivq\t%%rbx\n");
                printf("\tpushq\t%%rax\n");
                break;
            case '<':
                printf("\tpopq\t%%rax\n");
                printf("\tpopq\t%%rbx\n");
                printf("\tcmpq\t%%rax, %%rbx\n");
                printf("\tjge\tL%03d\n", lbl2 = lbl++);
                break;
            case '>':
                printf("\tpopq\t%%rdx\n");
                printf("\tpopq\t%%rax\n");
                printf("\tcmpq\t%%rdx, %%rax\n");
                printf("\tjle\tL%03d\n", lbl2 = lbl++);
                break;
            case GE:
                printf("\tpopq\t%%rdx\n");
                printf("\tpopq\t%%rax\n");
                printf("\tcmpq\t%%rdx, %%rax\n");
                printf("\tjl\tL%03d\n", lbl2 = lbl++);
                break;
            case LE:
                printf("\tpopq\t%%rax\n");
                printf("\tpopq\t%%rbx\n");
                printf("\tcmpq\t%%rax, %%rbx\n");
                printf("\tjg\tL%03d\n", lbl2 = lbl++);
                break;
            case NE:
                printf("\tpopq\t%%rax\n");
                printf("\tpopq\t%%rbx\n");
                printf("\tcmpq\t%%rbx, %%rax\n");
                printf("\tje\tL%03d\n", lbl2 = lbl++);
                break;
            case EQ:
                printf("\tpopq\t%%rax\n");
                printf("\tpopq\t%%rbx\n");
                printf("\tcmpq\t%%rbx, %%rax\n");
                printf("\tjne\tL%03d\n", lbl2 = lbl++);
                break;
            }
        }
    }
    return 0;
}  
