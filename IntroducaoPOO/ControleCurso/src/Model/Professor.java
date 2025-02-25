package Model;

public class Professor extends Pessoa {

    private double salario;

    public Professor(String nome, String cpf, double salario) {
        super(nome, cpf);
        this.salario = salario;
}

public double getSalario() {
    return salario;
}

public void setSalario(double salario) {
    this.salario = salario;
}

@Override
public void ExibirInformacoes() {
    super.ExibirInformacoes();
    System.out.println("Salario: " +salario);
}


}