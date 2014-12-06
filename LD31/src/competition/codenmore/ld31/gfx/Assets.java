package competition.codenmore.ld31.gfx;

import java.awt.image.BufferedImage;


public class Assets {
	
	private static final int SIZE = 32;
	
	public static BufferedImage player_blue;
	
	public static void init(){
		SpriteSheet sheet = new SpriteSheet(ImageLoader.loadImage("/spritesheet.png"));
		
		player_blue = sheet.crop(0 * SIZE, 0 * SIZE, SIZE, SIZE);
	}
	
}
