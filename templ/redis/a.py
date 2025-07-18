# for p in {7000..7010}; do redis-cli -c -h localhost -p $p FLUSHALL; done
# for p in {7000..7010}; do redis-cli -c -h localhost -p $p SCAN 0; done
# for p in {7000..7010}; do KEYS=$(redis-cli -c -h localhost -p $p SCAN 0 | grep -v "^0$"); for KEY in $KEYS; do echo "- $KEY:"; redis-cli -c -h localhost -p $p HGETALL "$KEY"; done; done
from redis.cluster import RedisCluster
r = RedisCluster(host='localhost', port=7000, decode_responses=False)

r.hset("0",  b'\x00\x00\x00\x00\x00\x00\x00\x00\x00', b'\x00\x00\x00\x00\x00\x00\x00\x00\x00')
