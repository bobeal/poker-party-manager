import org.springframework.web.servlet.support.RequestContextUtils as RCU
import org.springframework.context.support.ReloadableResourceBundleMessageSource

class LocalizationService {
    
    ReloadableResourceBundleMessageSource messageSource
    
	def getMessage(request,code) {
		def message = messageSource.getMessage( code, null, "", RCU.getLocale(request) )

		return message
	}

	def getMessage(request,code,args) {
		def message = messageSource.getMessage( code, args == null ? null : args.toArray(), "", 
		        RCU.getLocale(request) )

		return message
	}

	
}