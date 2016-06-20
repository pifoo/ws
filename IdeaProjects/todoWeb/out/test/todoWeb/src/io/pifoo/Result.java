package io.pifoo;

import java.util.List;

/**
 * Created by pifoo on 15/12/7.
 */
public class Result {
    private int result;
    private List<Person> personData;

    public List<Person> getPersonData() {
        return personData;
    }

    public void setPersonData(List<Person> personData) {
        this.personData = personData;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }
}
