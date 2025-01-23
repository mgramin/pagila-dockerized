# Dockerized pagila


## Build it:

```
docker build -t mgramin/pagila .
```


## Run it:

``` 
docker run -d --name pagila -e POSTGRES_PASSWORD=postgres -t -p 5432:5432 mgramin/pagila
```
