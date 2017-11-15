package com.caas.util;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class BaseRedis {
	private final Logger logger = LoggerFactory.getLogger(BaseRedis.class);
	protected String redis_servers;
	protected String redis_port;
	protected String redis_maxActive;
	protected String redis_maxIdle;
	protected String redis_maxWait;
	protected String redis_testOnBorrow;
	protected String redis_timeout;
	protected String redis_password;
	private JedisPool jedisPool = null;
	private JedisPoolConfig config = null;

	public String getRedis_servers() {
		return redis_servers;
	}

	public void setRedis_servers(String redis_servers) {
		this.redis_servers = redis_servers;
	}

	public String getRedis_port() {
		return redis_port;
	}

	public void setRedis_port(String redis_port) {
		this.redis_port = redis_port;
	}

	public String getRedis_maxActive() {
		return redis_maxActive;
	}

	public void setRedis_maxActive(String redis_maxActive) {
		this.redis_maxActive = redis_maxActive;
	}

	public String getRedis_maxIdle() {
		return redis_maxIdle;
	}

	public void setRedis_maxIdle(String redis_maxIdle) {
		this.redis_maxIdle = redis_maxIdle;
	}

	public String getRedis_maxWait() {
		return redis_maxWait;
	}

	public void setRedis_maxWait(String redis_maxWait) {
		this.redis_maxWait = redis_maxWait;
	}

	public String getRedis_testOnBorrow() {
		return redis_testOnBorrow;
	}

	public String getRedis_timeout() {
		return redis_timeout;
	}

	public void setRedis_timeout(String redis_timeout) {
		this.redis_timeout = redis_timeout;
	}

	public String getRedis_password() {
		return redis_password;
	}

	public void setRedis_password(String redis_password) {
		this.redis_password = redis_password;
	}

	public void setRedis_testOnBorrow(String redis_testOnBorrow) {
		this.redis_testOnBorrow = redis_testOnBorrow;
	}

	public void init() {
		synchronized (BaseRedis.class) {
			if (config == null) {
				config = new JedisPoolConfig();
				logger.info("加载ip={},port={}的Redis配置", this.redis_servers, this.redis_port);
			}
		}
		initPool();
		synchronized (BaseRedis.class) {
			if (jedisPool == null) {
				jedisPool = new JedisPool(config, redis_servers, Integer.parseInt(redis_port),
						Integer.parseInt(redis_timeout), redis_password);
				logger.info("初始化ip={},port={}的Redis连接池", this.redis_servers, this.redis_port);
			}
		}
	}

	private void initPool() {
		if (config != null) {
			config.setMaxTotal(Integer.parseInt(redis_maxActive));
			config.setMaxIdle(Integer.parseInt(redis_maxIdle));
			config.setMaxWaitMillis(Long.parseLong(redis_maxWait));
			config.setTestOnBorrow(Boolean.parseBoolean(redis_testOnBorrow));
			logger.info("初始化ip={},port={}的Redis配置信息", this.redis_servers, this.redis_port);
		}
	}

	private Jedis getJedis() {
		if (jedisPool == null) {
			initPool();
		}
		Jedis jedis = null;
		if (jedisPool != null) {
			jedis = jedisPool.getResource();
			if (!jedis.isConnected()) {
				logger.error("redis未连接");
				try {
					logger.info("redis尝试连接");
					jedis.connect();
					logger.info("redis连接成功");
				} catch (Exception e) {
					logger.error("redis连接失败");
				}
			}

		}
		return jedis;
	}

	/**
	 * 判断当前连接redis是否能连通
	 * 
	 * @return
	 */
	public Boolean isJedisConnecd() {
		Jedis jedis = null;
		try {
			if (jedisPool == null) {
				return false;
			}
			jedis = jedisPool.getResource();
			return jedis.isConnected();
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return false;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * @param regx
	 * @return Set<String>
	 */
	public Set<String> keys(String regx) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Set<String> set = jedis.keys(regx);
			return set;
		} catch (Exception e) {
			logger.error("RedisService.keys", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// add
	public Long add(String key, String... value) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			long res = jedis.sadd(key, value);
			logger.info("add key " + key);
			return res;
		} catch (Exception e) {
			logger.error("RedisService.add", e);
			jedisPool.returnBrokenResource(jedis);
			return 0l;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// all members
	public Set<String> smembers(String key) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Set<String> res = jedis.smembers(key);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// key is exist
	public boolean exists(String key) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			boolean res = jedis.exists(key);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return false;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// is exist
	public boolean sismember(String key, String value) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			boolean res = jedis.sismember(key, value);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return false;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// numbers
	public Long scard(String key) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Long res = jedis.scard(key);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return 0l;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// delete
	public Long delKey(final String... key) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Long res = jedis.del(key);
			return res;
		} catch (Exception e) {
			logger.error("RedisService.delKey", e);
			jedisPool.returnBrokenResource(jedis);
			return 0l;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// set a
	public String set(String key, String value) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			String res = jedis.set(key, value);
			logger.info("add key " + key + ",value " + value);
			return res;
		} catch (Exception e) {
			logger.error("RedisService.set", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	public synchronized String getAndSet(String key) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			String cur = jedis.get(key);
			long curNum = 0;
			if (StringUtils.isNotEmpty(cur)) {
				curNum = Long.parseLong(cur);
			}
			long nownum = curNum + 1;
			jedis.set(key, String.valueOf(nownum));
			logger.info("getAndSet key " + key);
			return String.valueOf(nownum);
		} catch (Exception e) {
			logger.error("RedisService.getAndSet", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// get a
	public String get(String key) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			String res = jedis.get(key);
			logger.info("get key " + key);
			return res;
		} catch (Exception e) {
			logger.error("RedisService.get", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	public Map<String, String> hgetall(String key) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Map<String, String> res = jedis.hgetAll(key);
			return res;
		} catch (Exception e) {
			logger.error("RedisService.hgetall", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	public String hget(String key, String field) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			String res = jedis.hget(key, field);
			return res;
		} catch (Exception e) {
			logger.error("RedisService.hgetall", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * 返回哈希表 key 中的所有域
	 * 
	 * @param key
	 * @return
	 */
	public Set<String> hkeys(String key) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Set<String> res = jedis.hkeys(key);
			return res;
		} catch (Exception e) {
			logger.error("RedisService.hkeys", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * 设置hash数据
	 * 
	 * @param key
	 * @param hash
	 * @param seconds
	 *            (0表示永久)
	 * @return
	 */
	public String hmset(String key, Map<String, String> hash, int seconds) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			String res = jedis.hmset(key, hash);
			if (seconds > 0) { // 设置超时时间
				jedis.expire(key, seconds);
			}
			return res;
		} catch (Throwable e) {
			logger.error("redis的hmset方法错误, key = " + key + ",hash = " + hash + ",异常：", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * 获取hash数据
	 * 
	 * @param key
	 * @param fields
	 * @return
	 */
	public List<String> hmget(String key, String fields) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			List<String> res = jedis.hmget(key, fields);
			logger.info("hmget,key= " + key + " fields= " + fields);
			return res;
		} catch (Throwable e) {
			logger.error("hmget,error = ", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * 删除hash数据
	 * 
	 * @param key
	 * @param fields
	 * @return
	 */
	public Long hdel(String key, String... fields) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Long res = jedis.hdel(key, fields);
			logger.info("hdel,key= " + key + " fields= " + fields);
			return res;
		} catch (Throwable e) {
			logger.error("hdel,error= ", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	public long hset(String key, String field, String value) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			long res = jedis.hset(key, field, value);
			logger.info("hset key " + key);
			return res;
		} catch (Exception e) {
			logger.error("RedisService.hset", e);
			jedisPool.returnBrokenResource(jedis);
			return 0;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// random a
	public String srandmember(String key) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			String res = jedis.srandmember(key);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// remove a random
	public String spop(String key) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			String res = jedis.spop(key);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// remove a or more member
	public Long srem(String key, String... members) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Long res = jedis.srem(key, members);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return 0l;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// move a member from one to another
	public Long smove(String srckey, String dstkey, String member) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Long res = jedis.smove(srckey, dstkey, member);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return 0l;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// union all
	public Set<String> sunion(String... keys) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Set<String> res = jedis.sunion(keys);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// uoion all keys store to dstkey
	public Long sunionstore(String dstkey, String... keys) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Long res = jedis.sunionstore(dstkey, keys);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return 0l;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// join inner all keys
	public Set<String> sinter(String... keys) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Set<String> res = jedis.sinter(keys);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// inner all keys store to dstkey
	public Long sinter(String dstkey, String... keys) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Long res = jedis.sinterstore(dstkey, keys);
			return res;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return 0l;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * @param regx
	 * @return Set<String> getKeys
	 */
	public Set<String> getKeys(String regx) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Set<String> set = jedis.keys(regx);
			return set;
		} catch (Exception e) {
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// set a
	public String setAndExpire(String key, String value, int seconds) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			String res = jedis.setex(key, seconds, value);
			logger.info("setAndExpire key " + key + ",value " + value + ",seconds " + seconds);
			return res;
		} catch (Exception e) {
			logger.error("RedisService.setAndExpire", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * 获取redis缓存key
	 * 
	 * @param key
	 * @param str
	 * @return String
	 */
	public String getKey(String key, String str) {
		StringBuffer sBuffer = new StringBuffer();
		sBuffer.append(key).append(str);
		return sBuffer.toString();
	}

	/**
	 * 添加有序集合
	 * 
	 * @param key
	 * @param score
	 * @param member
	 * @return
	 */
	public Long zadd(String key, double score, String member) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Long res = jedis.zadd(key, score, member);
			return res;
		} catch (Throwable e) {
			logger.error("zadd,error = ", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * 批量添加有序集合
	 * 
	 * @param key
	 * @param scoreMembers
	 * @return
	 */
	public Long zadd(String key, Map<String, Double> scoreMembers) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Long res = jedis.zadd(key, scoreMembers);
			return res;
		} catch (Throwable e) {
			logger.error("zaddBatch,error = ", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	public Long zrem(String key, String... members) {
		Jedis jedis = null;
		Long remNum = Long.valueOf(0);
		try {
			jedis = getJedis();
			for (String member : members) {
				Long res = jedis.zrem(key, members);
				if (res == 1) {
					remNum++;
					logger.info("zrem,key= " + key + "member= " + member);
				}
			}
			return remNum;
		} catch (Throwable e) {
			logger.error("zrem,error = ", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// 批量删除
	public Long abatchZrem(String key, String[] members) {
		Jedis jedis = null;
		Long remNum = Long.valueOf(0);
		try {
			jedis = getJedis();
			for (String member : members) {
				Long res = jedis.zrem(key, members);
				if (res == 1) {
					remNum++;
					logger.info("zrem,key= " + key + "member= " + member);
				}
			}
			return remNum;
		} catch (Throwable e) {
			logger.error("zrem,error = ", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	// 批量新增
	public Long abatchZadd(String key, int score, String[] members) {
		Jedis jedis = null;
		Long remNum = Long.valueOf(0);
		try {
			jedis = getJedis();
			for (String member : members) {
				Long res = jedis.zadd(key, score, member);
				if (res == 1) {
					remNum++;
					logger.info("zrem,key= " + key + "member= " + member);
				}
			}
			return remNum;
		} catch (Throwable e) {
			logger.error("zadd,error = ", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * 添加有序集合(map)
	 * 
	 * @param key
	 * @param scoreMembers
	 * @return
	 */
	public Long zaddMap(String key, Map<String, Double> scoreMembers) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Long res = jedis.zadd(key, scoreMembers);
			logger.info("zadd,key= " + key + " scoreMembers= " + scoreMembers);
			return res;
		} catch (Throwable e) {
			logger.error("zadd,error = ", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * 获取指定排序index范围内的有序集合(默认升序)
	 * 
	 * @param key
	 * @param start
	 * @param end
	 * @return
	 */
	public Set<String> zrange(String key, long start, long end) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Set<String> set = jedis.zrange(key, start, end);
			logger.info("zrange,key= " + key + " start= " + start + " end= " + end);
			return set;
		} catch (Throwable e) {
			logger.error("zrange,error = ", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * 获取key键下的member元素下的值
	 * 
	 * @param key
	 * @param member
	 * @return
	 */
	public Double zscore(String key, String member) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Double res = jedis.zscore(key, member);
			logger.info("zscore,key=" + key + ",member=" + member);
			return res;
		} catch (Throwable e) {
			logger.error("zrange,error = ", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}

	/**
	 * 返回有序集 key的基数
	 * 
	 * @param key
	 * @return 当 key 存在且是有序集类型时,返回有序集的基数;当 key 不存在时,返回 0.
	 */
	public Long zcard(String key) {
		Jedis jedis = null;
		try {
			jedis = getJedis();
			Long res = jedis.zcard(key);
			logger.info("zcard,key= " + key);
			return res;
		} catch (Throwable e) {
			logger.error("zcard,error= ", e);
			jedisPool.returnBrokenResource(jedis);
			return null;
		} finally {
			jedisPool.returnResource(jedis);
		}
	}
}
