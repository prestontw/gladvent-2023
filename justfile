default: test

run day:
    gleam run -m {{day}}

test:
    gleam test

watch-test:
    watchexec -- gleam test
