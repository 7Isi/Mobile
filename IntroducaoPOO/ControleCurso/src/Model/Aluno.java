package Model;

public class Aluno extends Pessoa{
    //Atributos
    private String matricula;
    private double nota;

    //Método
    //Construtor
    public Aluno(String nome, String cpf, String matricula, double nota) {
        super(nome, cpf);
        this.matricula = matricula;
        this.nota = nota;
    }

    //getter and setter
    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public double getNota() {
        return nota;
    }

    public void setNota(double nota) {
        this.nota = nota;
    }

    //exibirInformações
    @Override
    public void ExibirInformacoes () {
        System.out.println("Matricula: " +matricula);
        System.out.println("Nota: " +nota);
    }
    
}
