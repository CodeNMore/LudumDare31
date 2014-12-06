package competition.codenmore.ld31.particles;

import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.Random;

public class ParticleEmitter {
	
	private Random random;
	
	private float x, y;
	private float minSpeed, maxSpeed;
	private int amount, generated = 0, removed = 0;
	private Color color;
	private long last, now;
	
	private ArrayList<Particle> particles;

	public ParticleEmitter(float x, float y, int amount, float minSpeed, float maxSpeed, Color color){
		this.x = x;
		this.y = y;
		
		this.amount = amount;
		this.minSpeed = minSpeed;
		this.maxSpeed = maxSpeed;
		this.color = color;
		particles = new ArrayList<Particle>();
		
		random = new Random();
		last = System.currentTimeMillis();
	}
	
	public boolean tick(){
		if(generated <= amount){
			emit();
			generated++;
		}
		
		now = System.currentTimeMillis();
		
		for(Particle p : particles){
			if(p.isActive() && p.tick((int) (now - last))){
				removed++;
				p.setActive(false);
			}
		}
		
		last = now;
		
		if(removed >= amount)
			return true;
		
		return false;
	}
	
	public void render(Graphics g){
		g.setColor(color);
		
		for(Particle p : particles)
			if(p.isActive())
				p.render(g);
	}
	
	public void emit(){
		particles.add(new Particle(x, y, randomSpeed(), randomAngle(), 500));
	}
	
	private float randomSpeed(){
		return random.nextFloat();
	}
	
	private int randomAngle(){
		return random.nextInt(360);
	}
	
}
