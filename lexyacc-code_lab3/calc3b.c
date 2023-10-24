#include <stdio.h>
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"


static int lbl;
char *registers[] = {"rax", "rbx", "rcx", "rdx", "rsi", "rdi"};

int ex(nodeType *p) {
    int lbl1, lbl2;

    if (!p) return 0;
    switch(p->type) {
    case typeCon:       
        printf("\tpushq\t%d\n", p->con.value); 
        break;
    case typeId:        
        printf("\tpushq\t%%%s\n", registers[p->id.i]);
        break;
    case typeOpr:
        switch(p->opr.oper) {
        case WHILE:
            printf("L%03d:\n", lbl1 = lbl++);
            ex(p->opr.op[0]);
            printf("\tjz\tL%03d\n", lbl2 = lbl++);
            ex(p->opr.op[1]);
            printf("\tjmp\tL%03d\n", lbl1);
            printf("L%03d:\n", lbl2);
            break;
        case IF:
            ex(p->opr.op[0]);
            if (p->opr.nops > 2) {
                /* if else */
                printf("\tjz\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("\tjmp\tL%03d\n", lbl2 = lbl++);
                printf("L%03d:\n", lbl1);
                ex(p->opr.op[2]);
                printf("L%03d:\n", lbl2);
            } else {
                /* if */
                printf("\tjz\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("L%03d:\n", lbl1);
            }
            break;
        case PRINT:     
            ex(p->opr.op[0]);
            printf("\tcall\tprint\n");
            break;
        case '=':       
            ex(p->opr.op[1]);
            printf("\tpopq\t%%%s\n", registers[p->opr.op[0]->id.i]);
            break;
        case UMINUS:    
            ex(p->opr.op[0]);
            printf("\tneg\n");
            break;
    case FACT:
        ex(p->opr.op[0]);
        printf("\tcall\tfact\n");
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
            case '+':   printf("\tadd\n"); break;
            case '-':
                ex(p->opr.op[0]);
                ex(p->opr.op[1]);
                printf("\tpopq\t%%rbx\n");
                printf("\tpopq\t%%rax\n");
                printf("\tsubq\t%%rbx, %%rax\n");
                printf("\tpushq\t%%rax\n");
                break;
            case '*':   printf("\tmul\n"); break;
            case '/':   printf("\tdiv\n"); break;
            case '<':   printf("\tcompLT\n"); break;
            case '>': 
                printf("\tcmpq\t%%rbx, %%rax\n\tjl\tL%03d\n", lbl); 
                
                break;
            case GE:    printf("\tcompGE\n"); break;
            case LE:    printf("\tcompLE\n"); break;
            case NE:    
                //printf("\tcompNE\n");
                printf("\tcmpq\t%%rbx, %%rax\n"); 
                break;
            }
        }
    }
    return 0;
}  
