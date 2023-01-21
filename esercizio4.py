class Pietanza():
        stato={}
        def __init__(self):
                self.stato="spesa_in_corso"
        def stampaStato(self):
                print("La pietanza e` nello stato {}".format(self.stato))

        def pred(self):
                if self.stato=="controllo_sapore":
                        self.stato="preparazione_ricetta"
                elif self.stato=="preparazione_ingredienti":
                        self.stato="spesa_in_corso"
                elif self.stato=="fine":
                        print("La pietanza e` nello stato {}:  non e` possibile andare in uno stato precedente".format(self.stato))
                else:
                        print("La ricetta e' nello stato {}: non e' possibile tornare indietro".format(self.stato))

        def succ(self):
                if self.stato=="spesa_in_corso":
                        self.stato="preparazione_ingredienti"
                elif self.stato=="preparazione_ingredienti":
                        self.stato="preparazione_ricetta"
                elif self.stato=="preparazione_ricetta":
                        self.stato="controllo_sapore"
                elif self.stato=="controllo_sapore":
                        self.stato="fine"
                elif self.stato=="fine":
                        print("La pietanza e` nello stato {}:  non e` possibile andare in uno stato successivo".format(self.stato))

        def saltaI(self):
                if self.stato=="controllo_sapore":
                        self.stato="preparazione_ingredienti"
                else:
                        print("La ricetta e` nello stato {}: non e` possibile salta all'indietro".format(self.stato))

        def saltaA(self):
                if self.stato=="preparazione_ricetta":
                        self.stato="fine"
                else:
                        print("La ricetta e` nello stato {}: non e` possibile saltare in avanti".format(self.stato))


def main():
        pietanza =Pietanza()
        pietanza.stampaStato()
        print("Invoco pred")
        pietanza.pred()
        pietanza.stampaStato()
        print("Invoco saltaI")
        pietanza.saltaI()
        pietanza.stampaStato()
        print("Invoco saltaA")
        pietanza.saltaA()
        pietanza.stampaStato()
        print("Invoco succ")
        pietanza.succ()
        pietanza.stampaStato()
        print("Invoco saltaA")
        pietanza.saltaA()
        pietanza.stampaStato()
        print("Invoco saltaI")
        pietanza.saltaI()
        pietanza.stampaStato()
        print("Invoco pred")
        pietanza.pred()
        pietanza.stampaStato()
        print("Invoco succ")
        pietanza.succ()
        pietanza.stampaStato()
        print("Invoco succ")
        pietanza.succ()
        pietanza.stampaStato()
        print("Invoco pred")
        pietanza.pred()
        pietanza.stampaStato()
        print("Invoco saltaI")
        pietanza.saltaI()
        pietanza.stampaStato()
        print("Invoco succ")
        pietanza.succ()
        pietanza.stampaStato()
        print("Invoco saltaA")
        pietanza.saltaA()
        
        pietanza.stampaStato()
        print("Invoco pred")
        pietanza.pred()
        pietanza.stampaStato()
        print("Invoco saltaA")
        pietanza.saltaA()
        pietanza.stampaStato()
        print("Invoco succ")
        pietanza.succ()
        pietanza.stampaStato()
        print("Invoco pred")
        pietanza.pred()
        print("Invoco saltaA")
        pietanza.saltaA()
        pietanza.stampaStato()
        print("Invoco saltaI")
        pietanza.saltaI()
        pietanza.stampaStato()

if __name__== "__main__":
        main()



"""Il programm deve stampare:


La pietanza e` nello stato  spesa_in_corso
Invoco pred
La ricetta e` nello stato spesa_in_corso: non e` possibile tornare indietro
La pietanza e` nello stato  spesa_in_corso
Invoco saltaI
La ricetta e` nello stato spesa_in_corso: non e` possibile salta all'indietro
La pietanza e` nello stato  spesa_in_corso
Invoco saltaA
La ricetta e` nello stato spesa_in_corso: non e` possibile saltare in avanti
La pietanza e` nello stato  spesa_in_corso
Invoco succ
La pietanza e` nello stato  preparazione_ingredienti
Invoco saltaA
La ricetta e` nello stato preparazione_ingredienti: non e` possibile saltare in avanti
La pietanza e` nello stato  preparazione_ingredienti
Invoco saltaI
La ricetta e` nello stato preparazione_ingredienti: non e` possibile saltare all'indietro
La pietanza e` nello stato  preparazione_ingredienti
Invoco pred
La pietanza e` nello stato  spesa_in_corso
Invoco succ
La pietanza e` nello stato  preparazione_ingredienti
Invoco succ
La pietanza e` nello stato  preparazione_ricetta
Invoco pred
La ricetta e` nello stato preparazione_ricetta: non e` possibile tornare indietro
La pietanza e` nello stato  preparazione_ricetta
Invoco saltaI
La ricetta e` nello stato preparazione_ricetta: non e` possibile saltare all'indietro
La pietanza e` nello stato  preparazione_ricetta
Invoco succ
La pietanza e` nello stato  controllo_sapore
Invoco saltaA
La ricetta e` nello stato controllo_sapore: non e` possibile saltare in avanti
La pietanza e` nello stato  controllo_sapore
Invoco pred
La pietanza e` nello stato  preparazione_ricetta
Invoco saltaA
La pietanza e` nello stato  fine
Invoco succ
La pietanza e` nello stato fine:  non e` possibile andare in uno stato successivo
La pietanza e` nello stato  fine
Invoco pred
La pietanza e` nello stato fine:  non e` possibile andare in uno stato precedente
Invoco saltaA
La ricetta e` nello stato fine: non e` possibile saltare in avanti
La pietanza e` nello stato  fine
Invoco saltaI
La ricetta e` nello stato fine: non e` possibile saltare indietro
La pietanza e` nello stato  fine
"""
