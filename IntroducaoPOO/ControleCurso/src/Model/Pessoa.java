package Model;

public abstract class Pessoa {
    //Atributos (Encapsulamento)
    private String nome;
    private String cpf;

    //Métodos
    //Construtor
    public Pessoa (String nome, String cpf) {
        this.nome = nome;
        this.cpf = cpf;
    }

    //getter and setter
    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    //Exibir Informações
    public void ExibirInformacoes () {
        System.out.println("Nome: " +nome);
        System.out.println("CPF: " +cpf);
    }
}
