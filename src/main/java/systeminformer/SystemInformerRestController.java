package systeminformer;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;

@RestController
public final class SystemInformerRestController {

  @RequestMapping("/info")
  public InformationDto getInfo() throws Exception {
    System.out.println("test");
    InformationDto dto = new InformationDto();
    dto.setHostname(InetAddress.getLocalHost().getHostName());
    dto.setIpAddress(InetAddress.getLocalHost().getHostAddress());
    return dto;
  }
}
