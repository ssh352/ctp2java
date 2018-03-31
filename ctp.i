%module(directors="1") ctp

%header %{
#include "ThostFtdcUserApiDataType.h"
#include "ThostFtdcUserApiStruct.h"
#include "ThostFtdcMdApi.h"
#include "ThostFtdcTraderApi.h"
%}

%rename(ThostTeResumeType) THOST_TE_RESUME_TYPE;
%rename("%(lowercamelcase)s", %$isfunction) "";

%include "various.i"
%apply char **STRING_ARRAY { char *ppInstrumentID[] };

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
