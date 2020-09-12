import click


@click.command()
@click.argument("a", type=click.INT)
@click.argument("b", type=click.INT)
@click.option("--op", default='add', help='Math opperation')
def soma(a, b, op):
    if op == 'add':
        print(a + b)
    if op == 'sub':
        print(a - b)
    if op == 'mul':
        print(a * b)
    if op == 'div':
        print(a / b)


if __name__ == '__main__':
    soma()
