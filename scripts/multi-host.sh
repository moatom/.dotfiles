```sh
for i in $(seq 101 120); do   num=$(printf "%03d" $i);   host="foo${num}hoge";   docker run -it -u root -v $(pwd):/home/k6 grafana/k6:latest run --env HOST=$host test.js; done
for i in $(seq 101 120); do   num=$(printf "%03d" $i);   host="foo${num}hoge";   ssh $host -tt "ls /var/log/td-agent"; done
for i in $(seq 101 120); do   num=$(printf "%03d" $i);   host="foo${num}hoge";   ssh $host -tt "tail /home/fuga/aaa*"; done
for i in {1..10}; do echo -n "foo$i : "; echo ""; done


for i in $(seq 101 120); do
  num=$(printf "%03d" $i)
  host="foo${num}hoge"
  ssh aaa@$host -tt << EEOOSS
  echo "docker ps" | sudo su - bbb
  exit 0
EEOOSS
done

for i in $(seq 101 120); do
  num=$(printf "%03d" $i)
  host="foo${num}hoge"
  ssh aaa@$host -tt << EEOOSS
  sudo su - bbb << EOS
  ls
EOS
  exit 0
EEOOSS
done

for i in $(seq 101 120); do
  num=$(printf "%03d" $i)
  host="foo${num}hoge"
  ssh aaa@$host -tt << EEOOSS
  sudo su - bbb -c "ls"
EEOOSS
done
```
