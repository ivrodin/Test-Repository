from contextlib import ContextDecorator
from datetime import datetime, timedelta
from timeit import default_timer as timer


class LogFile(ContextDecorator):

    def __init__(self, name) -> None:
        super().__init__()
        self.log_file_name = name

    def __enter__(self):
        self.start_time = datetime.now().isoformat()
        self.timer_start = timer()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.exc_val = exc_val
        self.run_time = timedelta(seconds = timer() - self.timer_start)
        with open (self.log_file_name, 'a') as f:
            f.write(f'Start: {self.start_time} | Run: {self.run_time} | An error occurred: {self.exc_val}')
            f.write('\n')
        return False
    

@LogFile('my_trace.log')
def sum_of_ints(a, b):
    return a / b

sum_of_ints(2,1)


