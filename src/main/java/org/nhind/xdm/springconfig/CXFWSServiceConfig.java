package org.nhind.xdm.springconfig;

import javax.xml.ws.Endpoint;

import org.apache.cxf.Bus;

import org.apache.cxf.jaxws.EndpointImpl;
import org.nhind.xdr.XDRin;
import org.nhind.xdr.XDRout;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
public class CXFWSServiceConfig
{
	@Autowired
	protected Bus bus;
	
	@Bean
   @Primary
	@ConditionalOnMissingBean
	public XDRout xdOutSvc()
	{
		return new XDRout();
	}

   @Bean
   @ConditionalOnMissingBean
   public XDRin xdInSvc()
   {
      return new XDRin();
   }


   @Bean
    public Endpoint xdrOutEndpointService()
    {
        final EndpointImpl endpoint = new EndpointImpl(bus, xdOutSvc());
        endpoint.publish("/DocumentRepository_Service");
        return endpoint;
    }

   @Bean
   public Endpoint xdrSTAEndpointService()
   {
      final EndpointImpl endpoint = new EndpointImpl(bus, xdInSvc());
      endpoint.publish("/DocumentRepository_STA_Service");
      return endpoint;
   }
}
