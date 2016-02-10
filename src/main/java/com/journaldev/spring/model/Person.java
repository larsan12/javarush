package com.journaldev.spring.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name="User")
public class Person {

	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	@Column(name="name")
	private String name;

	@Column(name="age")
	private int age;

	@Column(name = "isAdmin")
	private Boolean isAdmin;

	@Column(name="createdDate")
	private Date createdDate;

	public Boolean getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(Boolean admin) {
		isAdmin = admin;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}


	@Override
	public String toString(){
		return "id="+id+", name="+name;
	}
}
