class Counter:
    def __init__(self, start = 0, stop = None) -> None:
        self.start = start
        self.stop = stop

    def increment(self):
        if self.stop != None and self.start + 1 > self.stop:
            print("Maximal value is reached.")
        else:
            self.start += 1
            
    def get(self):
        print(self.start)

c = Counter(stop=7) #0
c.increment() #1
c.increment() #2
c.increment() #3
c.increment() #4
c.increment() #5
c.increment() #6
c.increment() #7
c.increment() # "Maximal value is reached."
c.get() #7

c = Counter(start=5, stop=7) #5
c.increment() #6
c.increment() #7
c.increment() # "Maximal value is reached."
c.get() #7


c = Counter(start=5) #5
c.increment() #6
c.increment() #7
c.increment() #8
c.increment() #9
c.increment() #10
c.get() #10


