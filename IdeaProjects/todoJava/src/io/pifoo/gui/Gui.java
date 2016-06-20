package io.pifoo.gui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

/**
 *
 * Created by pifoo on 15/12/25.
 */
public class Gui extends WindowAdapter {
    public static void main(String[] args) {
        JFrame f = new JFrame("swing窗体");
        f.setSize(400, 300);
        f.setBackground(Color.WHITE);
        f.setLocation(300, 100);

        f.setLayout(new FlowLayout(FlowLayout.CENTER, 3, 3));
        JButton btn = null;
        for (int i = 0; i < 9 ; i++) {
            btn = new JButton("Btn - " + i);
            f.add(btn);
        }
        f.addWindowListener(new Gui());

        f.setVisible(true);




    }

    @Override
    public void windowClosing(WindowEvent e) {
        super.windowClosing(e);
        System.out.println("窗口关闭 !");
        System.exit(1);
    }
}
