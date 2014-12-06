package competition.codenmore.ld31.particles;

import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.Random;

public class ParticleEmitter {
	
	private Random random;
	
	private float x, y;
	private int width = 4, height = 4;
	private int minSpeed, maxSpeed, minAngle, maxAngle, minLife, maxLife;
	private int amount, generated = 0, removed = 0;
	private Color color;
	private long last, now;
	private boolean swap = false;
	
	private ArrayList<Particle> particles;

	public ParticleEmitter(float x, float y, int amount, int minSpeed, int maxSpeed, int minAngle, int maxAngle, int minLife, int maxLife, Color color){
		this.x = x;
		this.y = y;
		
		this.amount = amount;
		this.minSpeed = minSpeed;
		this.maxSpeed = maxSpeed;
		this.minAngle = minAngle;
		this.maxAngle = maxAngle;
		this.minLife = minLife;
		this.maxLife = maxLife;
		this.color = color;
		particles = new ArrayList<Particle>();
		
		random = new Random();
		last = System.currentTimeMillis();
	}
	
	public boolean tick(){
		swap = !swap;
		
		if(swap && generated <= amount){
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
		particles.add(new Particle(x, y, randomize(minSpeed, maxSpeed), randomize(minAngle, maxAngle), randomize(minLife, maxLife), this));
	}
	
	private int randomize(int min, int max){
		return random.nextInt((max - min) + 1) + min;
	}

	public float getX() {
		return x;
	}

	public void setX(float x) {
		this.x = x;
	}

	public float getY() {
		return y;
	}

	public void setY(float y) {
		this.y = y;
	}

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getMinSpeed() {
		return minSpeed;
	}

	public void setMinSpeed(int minSpeed) {
		this.minSpeed = minSpeed;
	}

	public int getMaxSpeed() {
		return maxSpeed;
	}

	public void setMaxSpeed(int maxSpeed) {
		this.maxSpeed = maxSpeed;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public Color getColor() {
		return color;
	}

	public void setColor(Color color) {
		this.color = color;
	}
	
}
