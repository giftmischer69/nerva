import sys
import time
import logging
from watchdog.observers import Observer
from watchdog.events import LoggingEventHandler
import subprocess


def run_checked(command):
    proc = subprocess.run(command, stdout=sys.stdout, shell=True,)
    return_code = proc.returncode
    logging.info(f"return_code: {return_code}")
    if return_code != 0:
        raise Exception


class Event(LoggingEventHandler):
    def dispatch(self, event):
        run_checked("python temp\\particle.py")


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    path = sys.argv[1] if len(sys.argv) > 1 else "."
    event_handler = Event()
    observer = Observer()
    observer.schedule(event_handler, path, recursive=True)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
