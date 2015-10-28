#include <stdio.h>
#include <stdlib.h>

#define TAILLE          6
#define NB_CHIFFRE      2

int tableau[TAILLE][NB_CHIFFRE] = {{5, 6}, {8, 7}, {0, 2}, {3, 6}, {7, 4}, {1, 9}};

void triParDenombrement(int chiffre)
{
    int indexTab, indexTabTrie, indexChiffre;

    int max;
    int *effectif;

    int tableauTemp[TAILLE][NB_CHIFFRE];

    max = -42;

    for(indexTab = 0; indexTab < TAILLE; ++indexTab)
        for(indexChiffre = 0; indexChiffre < NB_CHIFFRE; ++indexChiffre)
            tableauTemp[indexTab][indexChiffre] = tableau[indexTab][indexChiffre];

    for(indexTab = 0; indexTab < TAILLE; ++indexTab)
        if(tableau[indexTab][chiffre] > max)
            max = tableau[indexTab][chiffre];

    effectif = calloc(max + 1, sizeof(int));

    for(indexTab = 0; indexTab < TAILLE; ++indexTab)
        ++effectif[tableau[indexTab][chiffre]];

    for(indexTab = 0, indexTabTrie = 0; indexTab <= max; ++indexTab)
    {
        if(effectif[indexTab] != 0)
        {
            int index;

            for(index = 0; index < effectif[indexTab]; ++index)
            {
                tableauTemp[indexTabTrie][chiffre] = indexTab;
                ++indexTabTrie;
            }
        }
    }

    free(effectif);

    for(indexTab = 0; indexTab < TAILLE; ++indexTab)
        for(indexChiffre = 0; indexChiffre < NB_CHIFFRE; ++indexChiffre)
            tableau[indexTab][indexChiffre] = tableauTemp[indexTab][indexChiffre];
}

int main(void)
{
    int index, indexChiffre, indexTab;

    for(index = 0; index < TAILLE; ++index)
    {
        for(indexChiffre = 0; indexChiffre < NB_CHIFFRE; ++indexChiffre)
            printf("%d", tableau[index][indexChiffre]);

        putchar(' ');
    }

    for(indexChiffre = NB_CHIFFRE - 1; indexChiffre >= 0; --indexChiffre)
    {
        triParDenombrement(indexChiffre);

        putchar('\n');

        for(index = 0; index < TAILLE; ++index)
        {
            for(indexTab = 0; indexTab < NB_CHIFFRE; ++indexTab)
                printf("%d", tableau[index][indexTab]);

            putchar(' ');
        }
    }



    return 0;
}
