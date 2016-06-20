package io.pifoo.annotation;

import java.lang.annotation.*;

/**
 * Created by pifoo on 15/11/20.
 */
@Target({ElementType.METHOD,ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface Description {
    //String desc();
    //String auther();
    //int age() default 18;
    String value();


}
