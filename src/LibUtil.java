package com.scalats.ctp;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

class LibUtil {
  public static void loadLib(final String name) throws IOException {
    File f = new File("/tmp/com.scalats/ctp/lib/" + name);
    if (!f.exists()) {
      f.getParentFile().mkdirs();

      InputStream is = LibUtil.class.getResourceAsStream("/" + name);
      FileOutputStream os = new FileOutputStream(f);

      int i;
      byte[] buf = new byte[1024];
      while ((i = is.read(buf)) != -1) {
        os.write(buf, 0, i);
      }
      is.close();
      os.close();
    }
    f.deleteOnExit();

    System.load(f.getPath());
  }
}
