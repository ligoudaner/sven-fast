package com.sven;

import com.sven.service.DynamicDataSourceTestService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.Statement;

/**
 * 多数据源测试
 *
 * @author Sven i_xiangwei@163.com
 */
@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class DynamicDataSourceTest {
    @Autowired
    private DynamicDataSourceTestService dynamicDataSourceTestService;

    @Autowired
    private DataSource dataSource;

    @Test
    public void test(){
        Long id = 1L;

        dynamicDataSourceTestService.updateUser(id);
        dynamicDataSourceTestService.updateUserBySlave1(id);
        dynamicDataSourceTestService.updateUserBySlave2(id);
    }
    @Test
    public void test2(){
        try(Connection connection=dataSource.getConnection();
            Statement statement= connection.createStatement();
        ){
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
