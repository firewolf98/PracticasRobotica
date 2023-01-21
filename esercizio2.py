def DecoratorFactF(v):
    def decorator(fun):
        def wrapper(*args,**kwargs):
            flag=0
            for arg in args:
                if not isinstance(arg,v):
                    flag=1
            if(flag==0):
                return fun(*args,**kwargs)
            else:
                return v(fun(*args,**kwargs))
        return wrapper
    return decorator


if __name__=="__main__":

    def funct(x,y,z=3,**kwargs):
        l=[v for k,v in kwargs.items()]
        return [x,y,z]+l

    
    def funzione(*args,**kwargs):
        l=[v for k,v in kwargs.items()]
        return list(args)+l
    
    functInt=DecoratorFactF(1)(funct)
    functTuple=DecoratorFactF((2,3))(funct)
    functList=DecoratorFactF([1,2,3])(funct)

    funzioneInt=DecoratorFactF(1)(funzione)
    funzioneTuple=DecoratorFactF((2,3))(funzione)
    funzioneList=DecoratorFactF([1,2,3])(funzione)
    
    print("Invoco functInt(100,200,k1=10,k2=11)")
    try:
        print(functInt(100,200,k1=10,k2=11))
    except TypeError as e:
        print(e)
    print("Invoco funct sullo stesso input")
    try:
        print(funct(100,200,k1=10,k2=11))
    except TypeError as e:
        print(e)

    print("\nInvoco functTuple(100,200,k1=10,k2=11)")
    try:
        print(functTuple(100,200,k1=10,k2=11))
    except TypeError as e:
        print(e)
    print("Invoco funct sullo stesso input")
    try:
        print(funzione(100,200,k1=10,k2=11))
    except TypeError as e:
        print(e)

    print("\nInvoco functList([100],[200,5],k1=[10,6],k2=11)")
    try:
        print(functList([100],[200,5],k1=[10,6],k2=11))
    except TypeError as e:
        print(e)
    print("Invoco funzione sullo stesso input")
    try:
        print(funct([100],[200,5],k1=[10,6],k2=11))
    except TypeError as e:
        print(e)

    print("\nInvoco functInt(100,(2,),k1=10,k2=11)")
    try:
        print(functInt(100,(2,),k1=10,k2=11))
    except TypeError as e:
        print(e)
    print("Invoco funct sullo stesso input")
    try:
        print(funct(100,(2,),k1=10,k2=11))
    except TypeError as e:
        print(e)


    print("\nInvoco functInt(100,200,k1=10,k2=11,**{\'k3\':(5,8),\'k4\':\'op\',\'k5\':8})")
    try:
        print(functInt(100,200,k1=10,k2=11,**{'k3':(5,8),'k4':"op",'k5':8}))
    except TypeError as e:
        print(e)
    print("Invoco funct sullo stesso input")
    try:
        print(funct(100,200,k1=10,k2=11,**{'k3':(5,8),'k4':"op",'k5':8}))
    except TypeError as e:
        print(e)
    
    print("\nInvoco funzioneInt(100,200,k1=10,k2=11)")
    try:
        print(funzioneInt(100,200,k1=10,k2=11))
    except TypeError as e:
        print(e)
    print("Invoco funzione sullo stesso input")
    try:
        print(funzione(100,200,k1=10,k2=11))
    except TypeError as e:
        print(e)

    print("\nInvoco funzioneTuple(100,200,k1=10,k2=11)")
    try:
        print(funzioneTuple(100,200,k1=10,k2=11))
    except TypeError as e:
        print(e)
    print("Invoco funzione sullo stesso input")
    try:
        print(funzione(100,200,k1=10,k2=11))
    except TypeError as e:
        print(e)

    print("\nInvoco funzioneList([100],[200,5],k1=[10,6],k2=11)")
    try:
        print(funzioneList([100],[200,5],k1=[10,6],k2=11))
    except TypeError as e:
        print(e)
    print("Invoco funzione sullo stesso input")
    try:
        print(funzione([100],[200,5],k1=[10,6],k2=11))
    except TypeError as e:
        print(e)

    print("\nInvoco funzioneInt(100,(2,),k1=10,k2=11)")
    try:
        print(funzioneInt(100,(2,),k1=10,k2=11))
    except TypeError as e:
        print(e)
    print("Invoco funzione sullo stesso input")
    try:
        print(funzione(100,(2,),k1=10,k2=11))
    except TypeError as e:
        print(e)


    print("\nInvoco funzioneInt(100,200,k1=10,k2=11,**{\'k3\':(5,8),\'k4\':\'op\',\'k5\':8})")
    try:
        print(funzioneInt(100,200,k1=10,k2=11,**{'k3':(5,8),'k4':"op",'k5':8}))
    except TypeError as e:
        print(e)
    print("Invoco funzione sullo stesso input")

    try:
        print(funzione(100,200,k1=10,k2=11,**{'k3':(5,8),'k4':"op",'k5':8}))
    except TypeError as e:
        print(e)
   

"""Il programma deve stampare:
Invoco functInt(100,200,k1=10,k2=11)
[100, 200, 3, 10, 11]
Invoco funct sullo stesso input
[100, 200, 3, 10, 11]

Invoco functTuple(100,200,k1=10,k2=11)
funct() missing 2 required positional arguments: 'x' and 'y'
Invoco funct sullo stesso input
[100, 200, 10, 11]

Invoco functList([100],[200,5],k1=[10,6],k2=11)
[[100], [200, 5], 3, [10, 6]]
Invoco funzione sullo stesso input
[[100], [200, 5], 3, [10, 6], 11]

Invoco functInt(100,(2,),k1=10,k2=11)
funct() missing 1 required positional argument: 'y'
Invoco funct sullo stesso input
[100, (2,), 3, 10, 11]

Invoco functInt(100,200,k1=10,k2=11,**{'k3':(5,8),'k4':'op','k5':8})
[100, 200, 3, 10, 11, 8]
Invoco funct sullo stesso input
[100, 200, 3, 10, 11, (5, 8), 'op', 8]

Invoco funzioneInt(100,200,k1=10,k2=11)
[100, 200, 10, 11]
Invoco funzione sullo stesso input
[100, 200, 10, 11]

Invoco funzioneTuple(100,200,k1=10,k2=11)
[]
Invoco funzione sullo stesso input
[100, 200, 10, 11]

Invoco funzioneList([100],[200,5],k1=[10,6],k2=11)
[[100], [200, 5], [10, 6]]
Invoco funzione sullo stesso input
[[100], [200, 5], [10, 6], 11]

Invoco funzioneInt(100,(2,),k1=10,k2=11)
[100, 10, 11]
Invoco funzione sullo stesso input
[100, (2,), 10, 11]

Invoco funzioneInt(100,200,k1=10,k2=11,**{'k3':(5,8),'k4':'op','k5':8})
[100, 200, 10, 11, 8]
Invoco funzione sullo stesso input
[100, 200, 10, 11, (5, 8), 'op', 8]
"""
