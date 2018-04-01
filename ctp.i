%module(directors="1") ctp

%header %{
#include "ThostFtdcUserApiDataType.h"
#include "ThostFtdcUserApiStruct.h"
#include "ThostFtdcMdApi.h"
#include "ThostFtdcTraderApi.h"
%}

%rename(ThostTeResumeType) THOST_TE_RESUME_TYPE;
%rename("%(lowercamelcase)s", %$isfunction) "";


%typemap(jni) (char *ppInstrumentID[], int nCount) "jobjectArray"
%typemap(jtype) (char *ppInstrumentID[], int nCount) "String[]"
%typemap(jstype) (char *ppInstrumentID[], int nCount) "String[]"
%typemap(javain) (char *ppInstrumentID[], int nCount) "$javainput"

%typemap(in) (char *ppInstrumentID[], int nCount) {
  if ($input) {
    jint size = JCALL1(GetArrayLength, jenv, $input);
    $1 = new char*[size + 1];

    int i = 0;
    for (i = 0; i < size; i++) {
      jstring j_string = (jstring)JCALL2(GetObjectArrayElement, jenv, $input, i);
      const char *c_string = JCALL2(GetStringUTFChars, jenv, j_string, 0);
      $1[i] = new char [strlen(c_string) + 1];
      strcpy($1[i], c_string);
      JCALL2(ReleaseStringUTFChars, jenv, j_string, c_string);
      JCALL1(DeleteLocalRef, jenv, j_string);
    }
    $1[i] = 0;
    $2 = (int)size;
  } else {
    $1 = 0;
    $2 = 0;
  }
}

%typemap(freearg) (char *ppInstrumentID[], int nCount) {
  for (int i = 0; i < $2; i++)
    delete[] $1[i];
  delete[] $1;
}

%javaconst(1);

%feature("director") CThostFtdcMdSpi;
%feature("director") CThostFtdcTraderSpi;

%ignore THOST_FTDC_VTC_BankBankToFuture;
%ignore THOST_FTDC_VTC_BankFutureToBank;
%ignore THOST_FTDC_VTC_FutureBankToFuture;
%ignore THOST_FTDC_VTC_FutureFutureToBank;

%ignore THOST_FTDC_FTC_BankLaunchBankToBroker;
%ignore THOST_FTDC_FTC_BrokerLaunchBankToBroker;
%ignore THOST_FTDC_FTC_BankLaunchBrokerToBank;
%ignore THOST_FTDC_FTC_BrokerLaunchBrokerToBank;

%include "ctp/ThostFtdcUserApiDataType.h"
%include "ctp/ThostFtdcUserApiStruct.h"
%include "ctp/ThostFtdcMdApi.h"
%include "ctp/ThostFtdcTraderApi.h"
