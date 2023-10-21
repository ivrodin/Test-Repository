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

c = Counter(start=42)
c.increment()
c.increment()
c.increment()
c.get()



