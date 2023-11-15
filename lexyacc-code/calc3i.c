#include <stdio.h>
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"


static int lbl;
char *registers[] = {"rax", "rbx", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"};

int ex(nodeType *p) {
    int lbl1, lbl2;

    if (!p) return 0;
    switch(p->type) {
    case typeCon:       
        printf("\tpushq\t$%d\n", p->con.value);
        break;
    case typeId:
        printf("\tpushq\t%d(%%rbp)\n", -(p->id.i + 1) * 8);  // Adjusted to 8-byte offsets
        break;
    case typeOpr:
        switch(p->opr.oper) {
        case WHILE:
            printf("L%03d:\n", lbl1 = lbl++);
            lbl2 = lbl;
            ex(p->opr.op[0]);
            //printf("\tjz\tL%03d\n", lbl2 = lbl++);
            ex(p->opr.op[1]);
            printf("\tjmp\tL%03d\n", lbl1);
            printf("L%03d:\n", lbl2);
            break;
        case IF:
            lbl2 = lbl;
            ex(p->opr.op[0]);
            if (p->opr.nops > 2) {
                /* if else */
                ex(p->opr.op[1]);
                printf("\tjmp\tL%03d\n", lbl1 = lbl++);
                printf("L%03d:\n", lbl2);
                ex(p->opr.op[2]);
                printf("L%03d:\n", lbl1);
            } else {
                /* if */
                //printf("\tjz\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("L%03d:\n", lbl2);
            }
            break;
        case PRINT:     
            ex(p->opr.op[0]);
            printf("\tpopq\t%%rsi\n");
            printf("\tlea\tformat(%%rip), %%rdi\n");
            printf("\tmovq\t$0, %%rax\n"); 
            printf("\tcall\tprintf\n");
            break;
        case '=':       
            ex(p->opr.op[1]);
            printf("\tpopq\t%d(%%rbp)\n", -(p->opr.op[0]->id.i + 1) * 8);
            break;
        case UMINUS:    
            ex(p->opr.op[0]);
            printf("\tpopq\t%%rax\n");
            printf("\tneg\t%%rax\n");
            printf("\tpushq\t%%rax\n");
            break;
    case FACT:
        ex(p->opr.op[0]);
        printf("%s%s%s", "\tcall\tfact\n", "\taddq\t$8,%rsp\n","\tpushq\t%rax\n");
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
