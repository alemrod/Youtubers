import javax.swing.JOptionPane;

public class VERIFICAPRIMO{
    public static void main(String[]args){
        int n = Integer.parseInt(JOptionPane.showInputDialog("Digite um número a ser verificado"));
        boolean naoEPrimo = false;
        for (int conta = 2;conta<n; conta++){
            if(n%conta==0){
                JOptionPane.showMessageDialog("");
                naoEPrimo=true;
                break;
            }
            if (ePrimo)
        }
    }
}