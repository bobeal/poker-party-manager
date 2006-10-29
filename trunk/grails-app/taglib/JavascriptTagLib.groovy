/* Copyright 2004-2005 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT c;pWARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import org.springframework.validation.Errors;
import org.springframework.context.NoSuchMessageException;
import org.springframework.web.servlet.support.RequestContextUtils as RCU;
import org.codehaus.groovy.grails.commons.GrailsClassUtils as GCU;

 /**
 *  A  tag lib that provides tags for developing javascript and ajax applications
 *
 * @author Graeme Rocher
 * @since 17-Jan-2006
 */
class JavascriptTagLib  {

	/**
	 * Mappings to the relevant files to be included for each library
	 */
	static final INCLUDED_LIBRARIES = "org.codehaus.grails.INCLUDED_JS_LIBRARIES"
	static final INCLUDED_JS = "org.codehaus.grails.INCLUDED_JS"	
	static final LIBRARY_MAPPINGS = [
										prototype : ['prototype/prototype'],
										yahoo : [ 'yahoo/yahoo-min','yahoo/connection-min', 'yahoo/dom-min','yahoo/event-min','yahoo/animation-min'],
										yahoofull : [ 'yahoo-full/yahoo','yahoo-full/dom', 'yahoo-full/event','yahoo-full/container_core', 'yahoo-full/menu'],
										dojo : [ 'dojo/dojo']
									]
										
	static {
		LIBRARY_MAPPINGS.scriptaculous = LIBRARY_MAPPINGS.prototype + ['prototype/scriptaculous','prototype/builder','prototype/controls','prototype/effects','prototype/slider','prototype/draganddrop']		
		LIBRARY_MAPPINGS.rico = LIBRARY_MAPPINGS.prototype + ['prototype/rico']				
	}									
	/**
	 * Includes a javascript src file, library or inline script
	 * if the tag has no 'src' or 'library' attributes its assumed to be an inline script:
	 *
	 * <g:javascript>alert('hello')</g:javascript>
	 *
	 * The 'library' attribute will attempt to use the library mappings defined above to import the 
	 * right js files and not duplicate imports eg.
	 *
	 * <g:javascript library="scripaculous" /> // imports all the necessary js for the scriptaculous library
	 *
	 * The 'src' attribute will merely import the js file but within the right context (ie inside the /js/ directory of 
	 * the Grails application:
	 *
	 * <g:javascript src="myscript.js" /> // actually imports '/app/js/myscript.js'
	 **/
	@Property javascript = { attrs, body ->
		if(!request[INCLUDED_JS]) request[INCLUDED_JS] = []
		if(!request[INCLUDED_LIBRARIES]) request[INCLUDED_LIBRARIES] = []
		
		if(attrs.src) {
			out << '<script type="text/javascript" src="'
			out << grailsAttributes.getApplicationUri(request)
			out << "/js/${attrs.src}"
			out.println '"></script>'		
		}
		else if(attrs.library) {

			if(LIBRARY_MAPPINGS.containsKey(attrs.library)) {
				if(!request[INCLUDED_LIBRARIES].contains(attrs.library)) {
					LIBRARY_MAPPINGS[attrs.library].each {
						if(!request[INCLUDED_JS].contains(it)) {
								request[INCLUDED_JS] << it
								out << '<script type="text/javascript" src="'
								out << grailsAttributes.getApplicationUri(request)
								out << "/js/${it}.js"							
								out.println '"></script>'
						}					
					}
					request[INCLUDED_LIBRARIES] << attrs.library					
				}				
			}
			else {
				if(!request[INCLUDED_LIBRARIES].contains(attrs.library)) {
					out << '<script type="text/javascript" src="'
					out << grailsAttributes.getApplicationUri(request)
					out << "/js/${attrs.library}.js"						
					out.println '"></script>'
					request[INCLUDED_LIBRARIES] << attrs.library
					request[INCLUDED_JS] << attrs.library					
				}
			}
		}
		else {
			out.println '<script type="text/javascript">'
				body()
			out.println '</script>'
		}
	}
    /**
     *  Creates a remote function call using the prototype library
     */
    @Property remoteFunction = { attrs  ->    
		// before remote function
		def after = ''
		if(attrs["before"])
			out << "${attrs.remove('before')};"
		if(attrs["after"])
			after = "${attrs.remove('after')};"

		def p = getProvider()
		p.doRemoteFunction(owner,attrs,out)
		attrs.remove('update')
		// after remote function
		if(after)
		   out <<  after			           		   
    }

    /**
     * A link to a remote uri that used the prototype library to invoke the link via ajax
     */
    @Property remoteLink = { attrs, body ->
       out << "<a href=\"#\" onclick=\""
        // create remote function
        remoteFunction(attrs)
        out << 'return false;" '
        // process remaining attributes
        attrs.each { k,v ->
            out << k << "=\"" << v << "\" "
        }
        out << ">"
        // output the body
        body()

        // close tag
        out << "</a>"
    }

    /**
     * A form which used prototype to serialize its parameters and submit via an asynchronous ajax call
     */
    @Property formRemote = { attrs, body ->
        if(!attrs.name) {
            throwTagError("Tag [formRemote] is missing required attribute [name]")
        }        
        if(!attrs.url) {
            throwTagError("Tag [formRemote] is missing required attribute [url]")
        }        
        
        // get javascript provider
 		def p = getProvider()				
		def url = attrs.url.clone()
 		
		// prepare form settings
		prepareAjaxForm(p,attrs)
        
        def params = [  onsubmit:TagLibUtil.outToString(remoteFunction,attrs) + 'return false',
					    method: (attrs.method? attrs.method : 'POST' ),
					    action: (attrs.action? attrs.action : TagLibUtil.outToString(createLink,url))		                 
		             ]
		attrs.remove('url')		             
	    params.putAll(attrs)
	    withTag(name:'form',attrs:params) {
			body()   
	    }		
    }

    /**
     *  Creates a form submit button that submits the current form to a remote ajax call
     */
    @Property submitToRemote = { attrs, body ->
    	// get javascript provider
		def p = getProvider()    
		// prepare form settings
		prepareAjaxForm(p,attrs)    
        def params = [  onclick:TagLibUtil.outToString(remoteFunction,attrs) + 'return false',
					    type: 'button',
					    name: attrs.remove('name'),
					    value: attrs.remove('value'),
		             ]
		             
		withTag(name:'input', attrs:params) {
			body()	
		}
    }
	
	 private prepareAjaxForm(provider,attrs) {
		if(provider instanceof PrototypeProvider) {
		    attrs.params = "Form.serialize(this)"
		}
		else if(provider instanceof YahooProvider) {
			if(attrs.before) {
				attrs.before += ";YAHOO.util.Connect.setForm('${attrs.name}')"
			}
			else {
				attrs.before = "YAHOO.util.Connect.setForm('${attrs.name}')"
			}
		}
		else if(provider instanceof DojoProvider) {
			if(attrs.params) attrs.params.formNode = "dojo.byId('${attrs.name}')"
			else {
				attrs.params = [formNode:"dojo.byId('${attrs.name}')"]
			}
		}
	 }
	/**
	 * Escapes a javasacript string replacing single/double quotes and new lines
	 *
	 * <g:escapeJavascript>This is some "text" to be escaped</g:escapeJavascript>
	 */
	@Property escapeJavascript = { attrs,body ->
		def js = ''
		if(body instanceof Closure) {
			def tmp = out
			def sw = new StringWriter()
			out = new PrintWriter(out)
			// invoke body
			body()
			// restore out
			out = tmp
			js = sw.toString()
			
		}
		else if(body instanceof String) {
			js = body
		}
		else if(attrs instanceof String) {
			js = attrs	
		}
		out << 	js.replaceAll(/\r\n|\n|\r/, '\\\\n')
					.replaceAll("[\"']",{ (it[0] == '"'? '\\"' : "\\'") } )
	}

	/**
	 * Returns the provider of the necessary function calls to perform Javascript functions
	 *
	 **/
	private JavascriptProvider getProvider() {					
		if(request[JavascriptTagLib.INCLUDED_LIBRARIES]?.contains('yahoo')) {
			return new YahooProvider()
		}
		else if(request[JavascriptTagLib.INCLUDED_LIBRARIES]?.contains('dojo')) {
			return new DojoProvider()
		}		
		else {
			return new PrototypeProvider()
		}
	}
}
/**
 * Interface defining methods that a JavaScript provider should implement
 *
 * @author Graeme Rocher
 **/
interface JavascriptProvider {
	/**
	 * Creates a remote function call
	 *
	 * @param The attributes to use
	 * @param The output to write to
	 */
	def doRemoteFunction(taglib,attrs, out)
}

/**
 * Prototype implementation of JavaScript provider
 *
 * @author Graeme Rocher
 */
class PrototypeProvider implements JavascriptProvider {
	def doRemoteFunction(taglib,attrs, out) {
		out << 'new Ajax.'
		if(attrs.update) {
			out << 'Updater('
			if(attrs.update instanceof Map) {
				out << "{"
				def update = []
				if(attrs.update?.success) {
					update << "success:'${attrs['update']['success']}'"
				}
				if(attrs.update?.failure) {
					update << "failure:'${attrs['update']['failure']}'"
				}
				out << update.join(',')
				out << "},"
			}
			else {
				out << "'" << attrs.update << "',"
			}
			attrs.remove("update")
		}
		else {
			out << "Request("
		}
		out << "'"						
		
		if(attrs.url) {
			taglib.createLink(attrs.url)
		}
		else {
			taglib.createLink(attrs)
		}		
		
		out << "',"
		
		// process options
		out << getAjaxOptions(attrs)
		// close
		out << ');'		
	}
	
    // helper function to build ajax options
    def getAjaxOptions(options) {
        def ajaxOptions = []

        if(options) {
            // process callbacks
            def callbacks = options.findAll { k,v ->
                k ==~ /on(\p{Upper}|\d){1}\w+/
            }
            callbacks.each { k,v ->
                ajaxOptions << "${k}:function(e){${v}}"
                options.remove(k)
            }

            // necessary defaults
            if(options['asynchronous'])
                ajaxOptions << "asynchronous:${options.remove('asynchronous')}"
            else
                ajaxOptions << "asynchronous:true"


            if(options['evalScripts'])
                ajaxOptions << "evalScripts:${options.remove('evalScripts')}"
            else
                ajaxOptions << "evalScripts:true"

            if(options.params) {
                ajaxOptions << "parameters:${options.remove('params')}"
            }
            // remaining options
            options.each { k, v ->
            	if(k!='url') {
	                 switch(v) {
	                    case 'true': ajaxOptions << "${k}:${v}"; break;
	                    case 'false': ajaxOptions << "${k}:${v}"; break;
	                    case ~/\s*function(\w*)\s*/: ajaxOptions << "${k}:${v}"; break;
	                    default:ajaxOptions << "${k}:'${v}'"; break;
	                 }            	
            	}
            }
        }
        // set defaults
        else {
             ajaxOptions << "asynchronous:true"
             ajaxOptions << "evalScripts:true"
        }

        return "{${ajaxOptions.join(',')}}"
    }
	
}

/**
 * A implementation for the Yahoo library
 *
 * @author Graeme Rocher
 **/
class YahooProvider implements JavascriptProvider {
	def doRemoteFunction(taglib,attrs, out)	{
		def method = (attrs.method ? attrs.method : 'GET' )
		out << "YAHOO.util.Connect.asyncRequest('${method}','"
				
		if(attrs.url) {
			taglib.createLink(attrs.url)
		}
		else {
			taglib.createLink(attrs)
		}		
		
		out << "',"
		buildYahooCallback(attrs,out)
		out << ',null);'
	}	
	

	// helper method to create yahoo callback object
	def buildYahooCallback(attrs,out) {
		out << '{ '
			if(attrs.update) {
			  out <<'success: function(o) { '
				if(attrs.update instanceof Map) {
					if(attrs.update.success) {
						out << "YAHOO.util.Dom.get('${attrs.update.success}').innerHTML = o.responseText;"									
					}								
				}
				else {
					out <<  "YAHOO.util.Dom.get('${attrs.update}').innerHTML = o.responseText;"
				}
				if(attrs.onSuccess) {
					out << ";${attrs.onSuccess}(o);"
				}			  
				out << ' }'
				out << 	', failure: function(o) {'									
				if(attrs.update instanceof Map) {
					if(attrs.update.failure) {
						out << "YAHOO.util.Dom.get('${attrs.update.failure}').innerHTML = o.statusText;"																				
					}
				}
				if(attrs.onFailure) {
					out << "${attrs.onFailure}(o);"
				}										
				out << '}'				
			}			
			out << '}'		
	}	
}
/**
 * An implementation for the Dojo javascript library
 *
 * @author Graeme Rocher
 */
class DojoProvider implements JavascriptProvider {
	 def doRemoteFunction(taglib,attrs, out) {
		 out << 'dojo.io.bind({url:\''
		 taglib.createLink(attrs)
		 out << '\',load:function(type,data,evt) {'
		 if(attrs.update) {			
			out << 'dojo.html.textContent( dojo.byId(\''
			out << (attrs.update instanceof Map ? attrs.update.success : attrs.update)
			out << '\'),data);'		
		 }
		if(attrs.onSuccess) {
			out << ";${attrs.onSuccess}(type,data,evt);"
		}
		out << '}'
		out << ',error:function(type,error) { '
		if(attrs.update instanceof Map) {
			if(attrs.update.failure) {
				out << "dojo.html.textContent( dojo.byId('${attrs.update.failure}'),error.message);"									
			}
		}
		if(attrs.onFailure) {
			out << ";${attrs.onFailure}(type,error.message);"
		}			
	     out << '}'
	     attrs.params?.each {k,v ->
	     	out << ",$k:$v"
	     }
		 out << '});'
	 }
}