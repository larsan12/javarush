package com.journaldev.spring.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.journaldev.spring.model.Person;

@Repository
public class PersonDAOImpl implements PersonDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(PersonDAOImpl.class);

	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}

	@Override
	public void addPerson(Person p) {
		Session session = this.sessionFactory.getCurrentSession();
		Date date = new Date();
		p.setCreatedDate(date);
		if(p.getIsAdmin()==null) p.setIsAdmin(false);
		session.persist(p);
		logger.info("Person saved successfully, Person Details="+p);
	}

	@Override
	public void updatePerson(Person p) {
		Session session = this.sessionFactory.getCurrentSession();
		Person pers = (Person) session.load(Person.class, new Integer(p.getId()));
		pers.setAge(p.getAge());
		if(p.getIsAdmin()==null) p.setIsAdmin(false);
		pers.setIsAdmin(p.getIsAdmin());
		pers.setName(p.getName());
		session.update(pers);
		logger.info("Person updated successfully, Person Details="+p);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Person> listPersons() {
		Session session = this.sessionFactory.getCurrentSession();
		List<Person> personsList = session.createQuery("from Person").list();
		for(Person p : personsList){
			logger.info("Person List::"+p);
		}
		return personsList;
	}

	@Override
	public Person getPersonById(int id) {
		Session session = this.sessionFactory.getCurrentSession();		
		Person p = (Person) session.load(Person.class, new Integer(id));
		logger.info("Person loaded successfully, Person details="+p);
		return p;
	}

	@Override
	public void removePerson(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		Person p = (Person) session.load(Person.class, new Integer(id));
		if(null != p){
			session.delete(p);
		}
		logger.info("Person deleted successfully, person details="+p);
	}

	@Override
	public List<Person> searchByName(String name) {
		Session session = this.sessionFactory.getCurrentSession();
		String query = "from Person p WHERE p.name like '%"+ name +"%'";
		List<Person> personsList = session.createQuery(query).list();
		for(Person p : personsList){
			logger.info("Person List found by name::"+p);
		}
		return personsList;
	}

}
