package io.pifoo.oop.DesignPatterns;

/**
 * 代理设计模式:
 * 指由一个 代理主题 来操作 真实主题, 真实主题 执行具体的业务操作,而 代理主题 负责其它相关业务的处理;
 * 应用场景:如网络代理 即客户端通过网络代理连接网络,由代理服务器完成用户权限和访问限制等与上网操作相关的操作;
 * (实现:只需要定义一个'上网'的接口,'代理主题'和'真实主题'都实现此接口,然后再由 代理主题 操作 真实主题 即可)
 * 真实主题 完成的只是上网的最基本功能
 * 代理主题 要做比真实主题更多的业务相关的操作
 * Created by pifoo on 15/12/15.
 */

interface Network{                                              // 定义 Network 接口
    void browse();                                              // 定义 上网浏览 的抽象方法,可省略 public abstract
}

class Real implements Network{                                  // 真实上网
    @Override
    public void browse() {
        System.out.println("上网:浏览网页");
    }
}

class Proxy implements Network{                                 // 代理上网
    Network network;

    public Proxy(Network network) {                             // 设置代理的真实操作
        this.network = network;                                 // 设置代理的子类
    }
    public void check(){                                        // 与具体上网相关的操作
        System.out.println("检查用户是否合法");
    }
    @Override
    public void browse() {
        this.check();                                           // 可以同时调用多个与具体业务相关的操作
        this.network.browse();                                  // 调用真实上网操作
    }
}

public class ProxyPattern {
    public static void main(String[] args) {
        Network net = null;                                     // 定义接口对象
        net = new Proxy(new Real());                            // 实例化代理,同时传入代理的真实操作
        net.browse();                                           // 客户只关心上网浏览一个功能
    }
}
