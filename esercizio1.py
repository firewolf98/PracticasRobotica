def generatore(L,X):
    for i in range(len(X)):
        if(i<=len(X)):
            if 0<=X[i]<len(L):
                yield(sum(L[0:X[i]]))
            elif len(L)<X[i]:
                yield(IndexError("Indice Errato"))



if __name__=="__main__":
    l=[2,10,4,3,13,21,45,55]
    print("I test: la lista passata come secondo argomento non genera eccezioni")
    for s in generatore(l,[4,6,1,2,5]):
        try:
            print(s,end=" ")
        except IndexError as e:
                print(e)
    
               
        
    print("\n\nII test: viene stampata la stringa con cui viene creata l'eccezione restituita dal generatore")
    for s in generatore(l,[4,6,1,23,5]):
        print(s,end=" ")
        
    print("\n\nIII test: viene lanciata l'eccezione restituita dal generatore")
    for s in generatore(l,[4,6,1,23,5]):
        if type(s)==IndexException:
            raise s
        print(s,end=" ")

"""
Devono essere stampate le seguente stringhe e visualizzato il seguente messaaggio di errore:

I test: la lista passata come secondo argomento non genera eccezioni
19 53 2 12 32 

II test: viene stampata la stringa con cui viene creata l'eccezione restituita dal generatore
19 53 2 Indice errato 32 

III test: viene lanciata l'eccezione restituita dal generatore
Traceback (most recent call last):
  File "/Users/adb/Documents/prog2019/prrog20/2_11_2021/esercizio1.py", line 28, in <module>
    if type(s)==IndexException:
NameError: name 'IndexException' is not defined
"""







        
