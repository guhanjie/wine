package top.guhanjie.wine.msic;

import java.util.UUID;

/**
 * Created by guhanjie on 2017-09-18.
 */
public class TestUUID {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(UUID.randomUUID());
		String str = UUID.randomUUID().toString();
		System.out.println(UUID.fromString(str));
	}

}
