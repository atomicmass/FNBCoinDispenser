package za.co.fnb.coindispenser.dto;

import java.io.Serializable;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class LoginResult implements Serializable {
    private String result;
    private boolean success;
    
    public LoginResult() {}
    
    public LoginResult(String result, boolean success) {
        this();
        this.result = result;
        this.success = success;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }
}
