from multiprocessing import Pool

def loop(a):
    while True:
        pass

Pool().map(loop, range(100))
