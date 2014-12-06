package competition.codenmore.ld31;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferStrategy;

import competition.codenmore.ld31.gfx.Assets;
import competition.codenmore.ld31.gfx.Display;
import competition.codenmore.ld31.particles.ParticleEmitter;

public class Game implements Runnable{
	
	public static final String TITLE = "Game?";
	public static final int WIDTH = 720, HEIGHT = 480;
	
	private Thread thread;
	private boolean running = false;
	
	private Display display;
	private BufferStrategy bs;
	private Graphics g;
	
	public Game(){
		display = new Display(TITLE, WIDTH, HEIGHT);
	}
	
	ParticleEmitter pe, pe1, pe2;
	
	private void init(){
		Assets.init();
		pe = new ParticleEmitter(200, 200, 10000, 2, 5, 0, 360, 5000, 8000, Color.BLUE);
		pe.setWidth(8);
		pe.setHeight(8);
		
		pe1 = new ParticleEmitter(200, 200, 10000, 2, 5, 0, 360, 5000, 8000, Color.GREEN);
		pe1.setWidth(8);
		pe1.setHeight(8);
		
		pe2 = new ParticleEmitter(200, 200, 10000, 2, 5, 0, 360, 5000, 8000, Color.MAGENTA);
		pe2.setWidth(8);
		pe2.setHeight(8);
	}
	
	private void tick(){
		pe.tick();
		pe1.tick();
		pe2.tick();
	}

	private void render(){
		bs = display.getCanvas().getBufferStrategy();
		if(bs == null){
			display.getCanvas().createBufferStrategy(3);
			return;
		}
		g = bs.getDrawGraphics();
		g.setColor(Color.BLACK);
		g.fillRect(0, 0, WIDTH, HEIGHT);
		//RENDER
		
		pe.render(g);
		pe1.render(g);
		pe2.render(g);
		
		//END RENDER
		bs.show();
		g.dispose();
	}
	
	public void run(){
		init();
		
		int ns = 1000000000;
		double TIME_PER_TICK = ns / 60D;
		double delta = 0;
		long now = 0;
		long last = System.nanoTime();
		long timer = 0;
		int ticks = 0;
		
		while(running){
			now = System.nanoTime();
			delta += (now - last) / TIME_PER_TICK;
			timer += now - last;
			last = now;
			
			if(delta >= 1){
				tick();
				render();
				delta--;
				ticks++;
			}
			
			if(timer >= ns){
				display.setTitle("Ticks: " + ticks);
				ticks = 0;
				timer = 0;
			}
		}
		
		stop();
		System.exit(0);
	}
	
	public synchronized void start(){
		if(running)
			return;
		running = true;
		thread = new Thread(this);
		thread.start();
	}
	
	public synchronized void stop(){
		if(!running)
			return;
		running = false;
		try{thread.join();}catch(Exception e){e.printStackTrace();System.exit(1);}
	}

}
