package competition.codenmore.ld31.particles;

import java.awt.Graphics;

public class Particle {

	private float x, y;
	private float speed;
	private float angle;
	private int life, timer;
	private boolean active;
	
	public Particle(float x, float y, float speed, int degAngle, int life){
		this.x = x;
		this.y = y;
		this.speed = speed;
		angle = (float) Math.toRadians(degAngle);
		this.life = life;
		active = true;
	}
	
	public boolean tick(int timePassed){
		timer += timePassed;
		if(timer > life){
			return true;
		}else{
			x += speed * Math.cos(angle);
			y += -speed * Math.sin(angle);
		}
		return false;
	}
	
	public void render(Graphics g){
		g.fillRect((int) x, (int) y, 6, 6);
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

	public float getSpeed() {
		return speed;
	}

	public void setSpeed(float speed) {
		this.speed = speed;
	}

	public float getAngle() {
		return angle;
	}

	public void setAngle(float angle) {
		this.angle = angle;
	}

	public int getLife() {
		return life;
	}

	public void setLife(int life) {
		this.life = life;
	}

	public int getTimer() {
		return timer;
	}

	public void setTimer(int timer) {
		this.timer = timer;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}
	
}
