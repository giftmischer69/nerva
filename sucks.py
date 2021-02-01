from wfc_2019f.wfc import wfc_control
import typer

"""
space trucks!

inspired by the 17th cowboy bebop episode "heavy metal queen" and truck
simulator games.

backgrounds of destinations based on wavefunction collapse on bmp images
then they get converted to ascii art

maybe cmd interface (like a shell, python cmd based)

with like 5 minute travels between destinations. you have to dodge asteroids
and stay on track in space. for each trip you earn money with which you can
upgrade your truck and personalize the interior

the vibe of the game is the music, ambiance and sound effects. there are
multiple music stations based on sona-fm and maybe on some journeys there
is dialogue taken from videos and stuff

the waiting time is used to procedurally generate the next planet / environment
- background with wavefunction collapse (pixel art -> crop & downscale ->
-> wavefunction collapse algorithm -> background)
- mission giving character
    - dialogue (cmd part)
    - ai chatbot
    - va11 ha11a like
    


TUI with clicking
"""


def cli(
    filename,
    tile_size: int = 1,
    pattern_width: int = 2,
    rotations: int = 8,
    output_size=[48, 48],
    ground: int = 1,
    attempt_limit: int = 10,
    output_periodic: bool = True,
    input_periodic: bool = True,
    loc_heuristic: str = "lexical",
    choice_heuristic: str = "lexical",
    visualize: bool = False,
    global_constraint: bool = False,
    backtracking: bool = False,
    log_filename: str = "log",
    logging: bool = True,
    global_constraints=None,
    log_stats_to_output=None,
):
    wfc_control.execute_wfc(
        filename,
        tile_size,
        pattern_width,
        rotations,
        output_size,
        ground,
        attempt_limit,
        output_periodic,
        input_periodic,
        loc_heuristic,
        choice_heuristic,
        visualize,
        global_constraint,
        backtracking,
        log_filename,
        logging,
        global_constraints,
        log_stats_to_output,
    )


def main():
    typer.run(cli)


if __name__ == "__main__":
    main()
