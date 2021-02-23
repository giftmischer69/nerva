# Simple pygame program

# Import and initialize the pygame library
import pygame
import random
import time


class Particle:
    def __init__(self, x, y, s_x, s_y, size):
        self.created = time.time()
        self.x = x
        self.y = y
        self.s_x = s_x
        self.s_y = s_y
        self.size = size


class AsteroidSystem:
    def get_random_speed(self, speed):
        x = ((random.random() * 2) - 1) * speed
        y = ((random.random() * 2) - 1) * speed
        return x, y

    def update(self):
        marigin = 100
        for particle in self.asteroids:
            if (
                # time.time() - particle.created > self.time_alive
                # or
                particle.x < self.x - marigin
                or particle.x > self.width + marigin
                or particle.y < self.y - marigin
                or particle.y > self.height + marigin
            ):
                self.asteroids.remove(particle)
                speed_x, speed_y = self.get_random_speed(self.speed)
                p = Particle(self.center[0], self.center[1], speed_x, speed_y, 1)
                self.asteroids.append(p)

            particle.x += particle.s_x
            particle.y += particle.s_y
            particle.s_x += particle.s_x * 0.005
            particle.s_y += particle.s_y * 0.005

    def __init__(
        self,
        x: int = 0,
        y: int = 0,
        width: int = 500,
        height: int = 500,
        delay: tuple = (1, 10),
        size: int = 1,
        speed: float = 0.1,
        num: int = 1,
    ):
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.center = (x + (width / 2), y + (height / 2))
        self.delay = delay
        self.size = size
        self.speed = speed
        self.asteroids = []
        for i in range(num):
            speed_x, speed_y = self.get_random_speed(speed)
            a = Particle(self.center[0], self.center[1], speed_x, speed_y, 1)
            self.asteroids.append(a)


class ParticleSystem:
    def get_random_speed(self, speed):
        x = ((random.random() * 2) - 1) * speed
        y = ((random.random() * 2) - 1) * speed
        return x, y

    def __init__(
        self,
        x: int = 0,
        y: int = 0,
        width: int = 500,
        height: int = 500,
        num: int = 100,
        speed: int = 10,
        time_alive: float = 5,
    ):
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.center = (x + (width / 2), y + (height / 2))
        self.num = num
        self.speed = speed
        self.time_alive = time_alive
        self.particles = []
        for i in range(num):
            # p_x = random.randint(self.x, self.width)
            # p_y = random.randint(self.y, self.height)
            speed_x, speed_y = self.get_random_speed(speed)
            p = Particle(self.center[0], self.center[1], speed_x, speed_y, 1)
            # p = Particle(p_x, p_y, speed_x, speed_y, 1)
            self.particles.append(p)

    def update(self):
        for particle in self.particles:
            if (
                time.time() - particle.created > self.time_alive
                or particle.x < self.x
                or particle.x > self.width
                or particle.y < self.y
                or particle.y > self.height
            ):
                self.particles.remove(particle)
                speed_x, speed_y = self.get_random_speed(self.speed)
                p = Particle(self.center[0], self.center[1], speed_x, speed_y, 1)
                self.particles.append(p)

            particle.x += particle.s_x
            particle.y += particle.s_y


class Game:
    def __init__(self):
        pygame.init()
        width = 500
        height = 500
        # Set up the drawing window
        self.screen = pygame.display.set_mode([width, height])
        self.running = True
        self.bg_color = (0, 0, 0)
        self.pt_color = (255, 255, 255)

        self.at_color = (70, 70, 70)
        self.p_sys = ParticleSystem(
            x=0,
            y=0,
            width=width,
            height=height,
            num=width + height,
            speed=0.2,
            time_alive=30,
        )
        self.a_sys = AsteroidSystem(
            x=0,
            y=0,
            width=width,
            height=height,
            delay=(1, 10),
            size=1,
            speed=0.005,
            num=1,
        )

    def run(self):

        # Run until the user asks to quit
        while self.running:

            # Did the user click the window close button?
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    self.running = False

            # Fill the background with black
            self.screen.fill(self.bg_color)
            self.p_sys.update()
            self.a_sys.update()

            for p in self.p_sys.particles:
                diff = time.time() - p.created
                if diff < 1:
                    # just spawned
                    pygame.draw.circle(
                        self.screen,
                        tuple(x * diff for x in self.pt_color),
                        (p.x, p.y),
                        p.size,
                    )
                else:
                    # white
                    pygame.draw.circle(self.screen, self.pt_color, (p.x, p.y), p.size)

            for a in self.a_sys.asteroids:
                diff = time.time() - a.created
                pygame.draw.circle(
                    self.screen,
                    tuple(min(x * diff, 255) for x in self.at_color),
                    (a.x, a.y),
                    a.size * diff * 50,
                )
            # Flip the display
            pygame.display.flip()

        # Done! Time to quit.
        pygame.quit()


if __name__ == "__main__":
    g = Game()
    g.run()
