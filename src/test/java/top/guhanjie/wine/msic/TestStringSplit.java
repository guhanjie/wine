package top.guhanjie.wine.msic;

/**
 * Created by guhanjie on 2017-09-03.
 */
public class TestStringSplit {

	public static void main(String[] args) {
		String str = "5|2";
		String[] ss = str.split("\\|");
		for(String sss : ss) {
			System.out.println(sss);
		}
	}

}
