package com.scalats.ctp;

public class BaseMD extends CThostFtdcMdSpi {
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
