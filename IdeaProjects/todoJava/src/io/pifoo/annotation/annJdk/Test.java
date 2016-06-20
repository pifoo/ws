package io.pifoo.annotation.annJdk;

/**
 * Created by pifoo on 15/11/20.
 */
public class Test {
    @SuppressWarnings("Deprecated")
    public void sing(){
        Person p = new Child();
        p.sing();
    }
}
