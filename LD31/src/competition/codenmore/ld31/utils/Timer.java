package competition.codenmore.ld31.utils;

public class Timer {

	private long timer;
	private long now, last;
	
	public Timer(){
		timer = 0;
		now = 0;
		last = System.currentTimeMillis();
	}
	
	public void update(){
		now = System.currentTimeMillis();
		timer += now - last;
		last = now;
	}
	
	public long getTime(){
		return timer;
	}
	
	public void reset(){
		timer = 0;
		fromDelay();
	}
	
	public void fromDelay(){
		last = System.currentTimeMillis();
	}
	
}
