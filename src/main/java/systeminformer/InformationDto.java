package systeminformer;

public final class InformationDto {
  private String hostname;
  private String ipAddress;

  public String getHostname() {
    return hostname;
  }

  public void setHostname(final String hostname) {
    this.hostname = hostname;
  }

  public String getIpAddress() {
    return ipAddress;
  }

  public void setIpAddress(final String ipAddress) {
    this.ipAddress = ipAddress;
  }
}
