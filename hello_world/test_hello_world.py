import hello_world

def test_hello_world():
    assert hello_world.hello_world(None, None) == "hello world!"

if __name__ == '__main__':
    test_hello_world()
