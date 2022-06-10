package systeminformer;

import org.junit.Before;
import org.junit.Test;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

public class SystemInformerRestControllerTest {
  
  private MockMvc mockMvc;
  
  @Before
  public void setUp()  {
    SystemInformerRestController systemInformerRestController = new SystemInformerRestController();
    mockMvc = MockMvcBuilders.standaloneSetup(systemInformerRestController).build();
  }
  
  @Test
  public void getInfo_shouldReturnSysSpecs() throws Exception {
    
    this.mockMvc.perform(MockMvcRequestBuilders.get("/info"))
        .andExpect(MockMvcResultMatchers.status().is(200));
    
  }
  
}
