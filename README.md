# From-sratch-user

An example of a from scratch docker image running in non root user

# build

```
docker build . -t scratch-user
```

# Run

```
docker run -ti scratch-user
```

# Example 

```
$ docker run -ti toto
Hello from MyUser
Hello from MyUser
^C
```