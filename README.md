イメージのビルド

```
docker image build . -t hiyasichuka/java-python:3.12.0
```

バージョン確認

```
docker container run --rm -it hiyasichuka/java-python:3.12.0 bash
python3 -V
digdag --version
embulk --version 2>dev/null | head -n1
```
