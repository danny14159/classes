package com.clz.core.extend;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.clz.core.bean.TStu;
import com.clz.core.module.SystemModule;

/**权限控制--过滤器
 * @author Administrator
 *
 */
public class RequestFilter extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		//在这里进行权限认证
		String reqURI = request.getRequestURI();
		String referer = request.getHeader("Referer");
		System.out.println("getRequestURI:"+reqURI+",referer:"+referer);
		
		
		//公开的URI
		
		if(reqURI.matches("^/(login-p|logout|iparty/(.*)|circle/(.*)|publics/(.*)|icenter_(.*)|index-p|exhibition|login|f/assets/(.*)|include_(.*)|WEB-INF/(.*))?")){
			return true;
		}
		else{
			//需要登录的权限
			//超级管理员有所有权限
				TStu s = SystemModule.getLoginStu(request);
//				if(null != s && s.getType()=='S') return true;
				if(null == s) return false;
				//需要提供referer的URI
	//			if(!Strings.isBlank(referer)/* && referer.startsWith(BASE_URI)*/){
				else{	
					char type = s.getType();
					if(AuthorityUtils.hasAuthority(type,reqURI))
					return true;
				}
//			}
		}
		
		response.setStatus(403);
		return false;
		//return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		response.setCharacterEncoding("UTF-8");
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		super.afterConcurrentHandlingStarted(request, response, handler);
	}

	
}
