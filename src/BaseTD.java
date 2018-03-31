package com.scalats.ctp;

public class BaseTD extends CThostFtdcTraderSpi {
  static {
    try {
      String[] libs = { "libthostmduserapi.so", "libthosttraderapi.so", "libctp.so" };
      for (String lib : libs) {
        LibUtil.loadLib(lib);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
