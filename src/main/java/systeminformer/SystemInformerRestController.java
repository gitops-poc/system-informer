package systeminformer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.sql.Connection;
import java.sql.ResultSet;

import javax.sql.DataSource;

@RestController

public class SystemInformerRestController {
    private final String DATE_FORMAT = "yyyy/MM/dd HH:mm";
    @Autowired
    private DataSource dataSource;

    @RequestMapping("/info")
    public InformationDto getInfo() throws Exception {
        InformationDto dto = new InformationDto();
        dto.setHostname(InetAddress.getLocalHost().getHostName());
        dto.setIpAddress(InetAddress.getLocalHost().getHostAddress());
        int intentionalPmdViolation = 9;
        return dto;
    }

    @RequestMapping("/sql")
    public String getSql(@RequestParam(value = "text") String text) throws Exception {
      String sql = "select "
        + "customer_id,acc_number,branch_id,balance "
        + "from Accounts where customer_id = '"
        + text 
        + "'";
      Connection c = this.dataSource.getConnection();
      ResultSet rs = c.createStatement().executeQuery(sql);
      return rs.getString(0);
    // ...
    }
}
