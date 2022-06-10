package systeminformer;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;

@RestController

public class SystemInformerRestController {
    private final String DATE_FORMAT = "yyyy/MM/dd HH:mm";

    @RequestMapping("/info")
    public InformationDto getInfo() throws Exception {
        InformationDto dto = new InformationDto();
        dto.setHostname(InetAddress.getLocalHost().getHostName());
        dto.setIpAddress(InetAddress.getLocalHost().getHostAddress());
        int intentionalPmdViolation = 9;
        return dto;
    }
}
