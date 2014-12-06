package competition.codenmore.ld31.gfx;

import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;

public class ImageLoader {

	private static volatile ImageLoader instance = new ImageLoader();
	
	private static ImageLoader getInstance(){
		if(instance == null)
			instance = new ImageLoader();
		
		return instance;
	}
	
	public static BufferedImage loadImage(String path){
		try {
			return ImageIO.read(getInstance().getClass().getResource(path));
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
		
		return null;
	}
	
}
