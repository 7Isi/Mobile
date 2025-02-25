package Controller;

import java.util.ArrayList;
import java.util.List;

import Model.Aluno;
import Model.Professor;

public class Curso {
    private String nomeCurso;
    private Professor professor;
    private List<Aluno> alunos;


    public Curso(String nomeCurso, Professor professor) {
        this.nomeCurso = nomeCurso;
        this.professor = professor;
        alunos = new ArrayList<>()
    }

    public void adicionarAluno(Aluno aluno) {
        alunos.add(aluno);
    }

    public void exibirInformaçõesCurso () {
        
    }

}
