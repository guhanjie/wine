package top.guhanjie.wine.util;

import java.net.InetAddress;
import java.util.Random;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;

/**
 * ID生成器
 * 
 * @author botao.liao
 * 
 */
public class IdGenerator {
    private static IdGenerator instance = new IdGenerator();
    private long workerId;
    private final static long twepoch = 1361753741828L;//2013-01-01
    private long sequence = 0L;
    private final static long workerIdBits = 8L;
    private final static long maxWorkerId = -1L ^ -1L << workerIdBits;
    private final static long sequenceBits = 5L;

    private final static long workerIdShift = sequenceBits;
    private final static long timestampLeftShift = sequenceBits + workerIdBits;
    private final static long sequenceMask = -1L ^ -1L << sequenceBits;

    private long lastTimestamp = -1L;
    
    public final static String[] chars = new String[] {
                "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
                "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
                "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V","W", "X", "Y", "Z"
    };

    private IdGenerator() {
        try {
            this.workerId = getWorkerId();
            if (workerId > maxWorkerId || workerId < 0) {
                throw new IllegalArgumentException(String.format("worker Id can't be greater than %d or less than 0", maxWorkerId));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static IdGenerator getInstance() {
        return instance;
    }

    /**
     * 15位
     * @return
     */
    public synchronized long nextId() {
        long timestamp = this.timeGen();
        if (this.lastTimestamp == timestamp) {
            this.sequence = (this.sequence + 1) & sequenceMask;
            if (this.sequence == 0) {
                timestamp = this.tilNextMillis(this.lastTimestamp);
            }
        } else {
            this.sequence = 0;
        }
        if (timestamp < this.lastTimestamp) {
            try {
                throw new Exception(String.format(
                        "Clock moved backwards.  Refusing to generate id for %d milliseconds", this.lastTimestamp  - timestamp));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        this.lastTimestamp = timestamp;
        long nextId = ((timestamp - twepoch) << timestampLeftShift) | (this.workerId << workerIdShift) | (this.sequence);
        return nextId;
    }

    private long tilNextMillis(final long lastTimestamp) {
        long timestamp = this.timeGen();
        while (timestamp <= lastTimestamp) {
            timestamp = this.timeGen();
        }
        return timestamp;
    }

    private long timeGen() {
//        Calendar c = Calendar.getInstance();
//        c.set(2050, 1, 1);
//        return c.getTimeInMillis();
        return System.currentTimeMillis();
    }

    private static long getWorkerId() throws Exception {
        byte[] ip = InetAddress.getLocalHost().getAddress();
        long id = (0x000000FF & (long) ip[ip.length - 1]);
        return id;
    }

    public static String uuid() {
		return StringUtils.replace(UUID.randomUUID().toString(), "-", "");
	}

    public static void main(String[] args) {
        IdGenerator generator = IdGenerator.getInstance();
        long begin = System.currentTimeMillis();
        for (int i = 0; i < 1000; i++) {
            System.out.println(generator.nextId());
        }
        System.out.println(System.currentTimeMillis() - begin);
    }
    
    /**
     * 生成短8位UUID
     * 短8位UUID思想其实借鉴微博短域名的生成方式，但是其重复概率过高，而且每次生成4个，需要随即选取一个。
	 * 本算法利用62个可打印字符，通过随机生成32位UUID，由于UUID都为十六进制，所以将UUID分成8组，每4个为一组，
	 * 然后通过模62操作，结果作为索引取出字符，这样重复率大大降低。
	 * 经测试，在生成一千万个数据也没有出现重复，完全满足大部分需求。
     */
	public static String getShortUuid() {
		StringBuffer stringBuffer = new StringBuffer();
		String uuid = UUID.randomUUID().toString().replace("-", "");
		for (int i = 0; i < 8; i++) {
			String str = uuid.substring(i * 4, i * 4 + 4);
			int strInteger = Integer.parseInt(str, 16);
			stringBuffer.append(chars[strInteger % 0x3E]);
		}
		return stringBuffer.toString();
	}

	/**
	 * 生成随机数字字符串
	 * @param size
	 * @return
	 */
	public static String randomNumCode(int size) {
		Random random = new Random();
		if(size < 1 || size > 1024){
			throw new IllegalAccessError("invalid size:"+size);
		}
		StringBuilder sb = new StringBuilder(size);
		for (int i = 0; i < size; i++) {
			sb.append(random.nextInt(10));
		}
		return sb.toString();
	}
}
