package io.pifoo.annotation.annJdk;


import io.pifoo.annotation.Description;

/**
 * Created by pifoo on 15/11/20.
 */

@Description("I am class annotation")
public class Child implements Person {

    @Override
    @Description("I am method annotation")
    public String name() {
        return null;
    }

    @Override
    public int age() {
        return 0;
    }

    @Deprecated
    public void sing() {

    }
}
