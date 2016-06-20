package io.pifoo.annotation.annJdk;

import io.pifoo.annotation.Description;

/**
 * Created by pifoo on 15/11/20.
 */
@Description("I am interface")
public interface Person {
    @Description("I am interface method")
    public String name();

    public int age();

    @Deprecated
    public void sing();

}
