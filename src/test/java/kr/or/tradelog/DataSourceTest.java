package kr.or.tradelog;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.or.tradelog.mapper.MemberMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
    "file:src/main/webapp/WEB-INF/spring/root-context.xml"
)
public class DataSourceTest {

    @Autowired
    private DataSource dataSource;

    @Test
    public void connectionTest() throws Exception {

        try (Connection conn = dataSource.getConnection()) {

            System.out.println(conn);
            System.out.println("isClosed : " + conn.isClosed());
        }
    }
    
    @Autowired
    private MemberMapper memberMapper;

    @Test
    public void countTest() {

        int count = memberMapper.countMembers();

        System.out.println("회원 수 : " + count);
    }
    
    
}