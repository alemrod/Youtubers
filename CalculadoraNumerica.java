import java.util.Scanner;

public class CalculadoraNumerica {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        int soma = 0;
        int quantidade = 0;
        int quantidadePares = 0;
        int quantidadeImpares = 0;
        int maior = Integer.MIN_VALUE;
        int somaPares = 0;

        System.out.println("Digite os números (digite 30000 para finalizar):");

        while (true) {
            int numero = scanner.nextInt();

            if (numero == 30000) {
                break;
            }

            soma += numero;
            quantidade++;

            if (numero > maior) {
                maior = numero;
            }

            if (numero % 2 == 0) {
                quantidadePares++;
                somaPares += numero;
            } else {
                quantidadeImpares++;
            }
        }

        double media = (double) soma / quantidade;
        double mediaPares = (double) somaPares / quantidadePares;
        double percentualImpares = (double) quantidadeImpares / quantidade * 100;

        System.out.println("Soma dos números digitados: " + soma);
        System.out.println("Quantidade de números digitados: " + quantidade);
        System.out.println("Média dos números digitados: " + media);
        System.out.println("Maior número digitado: " + maior);
        System.out.println("Média dos números pares: " + mediaPares);
        System.out.println("Percentagem dos números ímpares: " + percentualImpares + "%");

        scanner.close();
    }
}
