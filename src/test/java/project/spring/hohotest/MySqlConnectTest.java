package project.spring.hohotest;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/** JUnit에 의해서 실행될 클래스임을 명시함 */
@RunWith(SpringJUnit4ClassRunner.class)

/** 스프링이 로딩될 수 있도록 경로 설정 */
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MySqlConnectTest {
	
	/** DataSource 객체를 선언하면 실행시, Spring에 의해서 주입된다. */
	@Autowired
	DataSource ds;
	
	/** 테스트용 메서드 정의 */
	@Test
	public void testFactory() {
		try {
			/** DB접속하기 */
			Connection con = ds.getConnection();
			System.out.println(con.toString());
			System.out.println("----- DATABASE 접속 성공 ----");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
