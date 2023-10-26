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
        printf("\tpushq\t%%%s\n", registers[p->id.i % 14]);
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
            printf("\tleaq\tformat(%%rip), %%rdi\n");
            printf("\tmovq\t%%rax, %%rsi\n");
            printf("\txorq\t%%rax, %%rax\n"); 
            printf("\tcall\tprintf\n");
            break;
        case '=':       
            ex(p->opr.op[1]);
            printf("\tpopq\t%%%s\n", registers[(p->opr.op[0]->id.i % 14)]);
            //printf("\tpopq\t%%%d\n", p->opr.op[0]->id.i);
            break;
        case UMINUS:    
            ex(p->opr.op[0]);
            printf("\tneg\t%%%s\n", registers[(p->opr.op[0]->id.i % 14)]);
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
            case '+':
                //ex(p->opr.op[0]);
                //ex(p->opr.op[1]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[1]->id.i % 14]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                printf("\taddq\t%%%s, %%%s\n", registers[p->opr.op[1]->id.i % 14], registers[p->opr.op[0]->id.i % 14]);
                printf("\tpushq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                break;
            case '-':
                printf("\tpopq\t%%%s\n", registers[p->opr.op[1]->id.i % 14]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                printf("\tsubq\t%%%s, %%%s\n", registers[p->opr.op[1]->id.i % 14], registers[p->opr.op[0]->id.i % 14]);
                printf("\tpushq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                break;
            case '*':
                printf("\tpopq\t%%%s\n", registers[p->opr.op[1]->id.i % 14]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                printf("\timulq\t%%%s, %%%s\n", registers[p->opr.op[1]->id.i % 14], registers[p->opr.op[0]->id.i % 14]);
                printf("\tpushq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                break;
            case '/':
                printf("\tpopq\t%%%s\n", registers[p->opr.op[1]->id.i % 14]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                printf("\tmovq\t%%rax, %%%s\n", registers[p->opr.op[0]->id.i % 14]);
                printf("\txorq\t%%rdx, %%rdx\n");
                printf("\tidivq\t%%%s\n", registers[p->opr.op[1]->id.i % 14]);
                printf("\tpushq\t%%rax\n");
                break;
            case '<':
                printf("\tpopq\t%%%s\n", registers[p->opr.op[1]->id.i % 14]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                printf("\tcmpq\t%%%s, %%%s\n\tjg\tL%03d\n", registers[p->opr.op[1]->id.i % 14], registers[p->opr.op[0]->id.i % 14], lbl);
                break;
            case '>': 
                //ex(p->opr.op[0]);
                //ex(p->opr.op[1]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[1]->id.i % 14]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                printf("\tcmpq\t%%%s, %%%s\n\tjl\tL%03d\n", registers[p->opr.op[1]->id.i % 14], registers[p->opr.op[0]->id.i % 14], lbl);
                break;
            case GE:
                ex(p->opr.op[0]);
                ex(p->opr.op[1]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[1]->id.i % 14]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                printf("\tcmpq\t%%%s, %%%s\n\tjl\tL%03d\n", registers[p->opr.op[1]->id.i % 14], registers[p->opr.op[0]->id.i % 14], lbl);
                break;
            case LE:
                ex(p->opr.op[0]);
                ex(p->opr.op[1]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[1]->id.i % 14]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                printf("\tcmpq\t%%%s, %%%s\n\tjg\tL%03d\n", registers[p->opr.op[1]->id.i % 14], registers[p->opr.op[0]->id.i % 14], lbl);
                break;
            case NE:
                ex(p->opr.op[0]);
                ex(p->opr.op[1]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[1]->id.i % 14]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                printf("\tcmpq\t%%%s, %%%s\n\tje\tL%03d\n", registers[p->opr.op[1]->id.i % 14], registers[p->opr.op[0]->id.i % 14], lbl);
                break;
            case EQ:
                ex(p->opr.op[0]);
                ex(p->opr.op[1]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[1]->id.i % 14]);
                printf("\tpopq\t%%%s\n", registers[p->opr.op[0]->id.i % 14]);
                printf("\tcmpq\t%%%s, %%%s\n\tjne\tL%03d\n", registers[p->opr.op[1]->id.i % 14], registers[p->opr.op[0]->id.i % 14], lbl);
                break;
            }
        }
    }
    return 0;
}  
