package com.clz.core.extend;

import java.lang.annotation.ElementType;
import java.lang.annotation.Target;

@Target(ElementType.TYPE)
public @interface Interface {
	Class<?> value();
}
