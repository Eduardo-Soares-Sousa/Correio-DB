DROP TABLE pessoa CASCADE CONSTRAINTS;
DROP TABLE remetente CASCADE CONSTRAINTS;
DROP TABLE gerente CASCADE CONSTRAINTS;
DROP TABLE destinatario CASCADE CONSTRAINTS;
DROP TABLE pacote CASCADE CONSTRAINTS;
DROP TABLE logistica CASCADE CONSTRAINTS;
DROP TABLE entrega CASCADE CONSTRAINTS;
DROP TABLE funcionarioEntrega CASCADE CONSTRAINTS;
DROP TABLE entregaFeita CASCADE CONSTRAINTS;

/* Criação das tabelas */

CREATE TABLE pessoa (
    codigo NUMBER PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    telefone VARCHAR2(20) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    cpf VARCHAR2(11) NOT NULL
);

CREATE TABLE remetente (
    codigo NUMBER PRIMARY KEY,
    endereco VARCHAR(200) NOT NULL,
    CONSTRAINT remetente_pessoa_fk FOREIGN KEY (codigo) REFERENCES pessoa (codigo)
);

CREATE TABLE gerente (
    codigo NUMBER PRIMARY KEY,
    CONSTRAINT gerente_pessoa_fk FOREIGN KEY (codigo) REFERENCES pessoa (codigo)
);

CREATE TABLE destinatario (
    codigo NUMBER PRIMARY KEY,
    endereco VARCHAR(200) NOT NULL,
    CONSTRAINT destinatario_pessoa_fk FOREIGN KEY (codigo) REFERENCES pessoa (codigo)
);

CREATE TABLE logistica (
    codigo NUMBER PRIMARY KEY,
    centroDistribuicao VARCHAR2(200) NOT NULL,
    codigoGerente NUMBER NOT NULL,
    CONSTRAINT logistica_gerente_fk FOREIGN KEY (codigoGerente) REFERENCES gerente (codigo)
);

CREATE TABLE entrega (
    codigo NUMBER PRIMARY KEY,
    dataEnvio DATE NOT NULL,
    dataEntrega DATE NOT NULL,
    localizacao VARCHAR2(200) NOT NULL,
    status VARCHAR(50) NOT NULL,
    codigoLogistica NUMBER NOT NULL,
    codigoGerente NUMBER NOT NULL,
    CONSTRAINT entrega_logistica_fk FOREIGN KEY (codigoLogistica) REFERENCES logistica (codigo),
    CONSTRAINT entrega_gerente_fk FOREIGN KEY (codigoGerente) REFERENCES gerente (codigo)
);

CREATE TABLE pacote (
    codigo NUMBER PRIMARY KEY,
    peso NUMBER(5, 2) NOT NULL,
    dataPostagem DATE NOT NULL,
    categoria VARCHAR2(50) NOT NULL,
    codigoRemetente NUMBER NOT NULL,
    codigoLogistica NUMBER NOT NULL,
    codigoEntrega NUMBER NOT NULL,
    CONSTRAINT pacote_remetente_fk FOREIGN KEY (codigoRemetente) REFERENCES remetente (codigo),
    CONSTRAINT pacote_logistica_fk FOREIGN KEY (codigoLogistica) REFERENCES logistica (codigo),
    CONSTRAINT pacote_entrega_fk FOREIGN KEY (codigoEntrega) REFERENCES entrega (codigo)
);

CREATE TABLE funcionarioEntrega (
    codigo NUMBER PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    codigoEntrega NUMBER NOT NULL,
    CONSTRAINT funcionarioEntrega_entrega_fk FOREIGN KEY (codigoEntrega) REFERENCES entrega (codigo)
);

CREATE TABLE entregaFeita (
    codigoDestinatario NUMBER NOT NULL,
    codigoFuncionarioEntrega NUMBER NOT NULL,
    PRIMARY KEY (codigoDestinatario, codigoFuncionarioEntrega),
    CONSTRAINT entregaFeita_destinatario_fk FOREIGN KEY (codigoDestinatario) REFERENCES destinatario (codigo),
    CONSTRAINT entregaFeita_funcionarioEntrega_fk FOREIGN KEY (codigoFuncionarioEntrega) REFERENCES funcionarioEntrega (codigo)
);

/* Inserção de dados */

INSERT INTO pessoa (codigo, nome, telefone, email, cpf) VALUES (1, 'João Silva', '11987654321', 'joao@gmail.com', '12345678901');
INSERT INTO pessoa (codigo, nome, telefone, email, cpf) VALUES (2, 'Maria Oliveira', '21987654321', 'maria@gmail.com', '98765432100');
INSERT INTO pessoa (codigo, nome, telefone, email, cpf) VALUES (3, 'Carlos Souza', '31987654321', 'carlos@gmail.com', '11223344556');
INSERT INTO pessoa (codigo, nome, telefone, email, cpf) VALUES (4, 'Ana Costa', '41987654321', 'ana@gmail.com', '66778899001');
INSERT INTO pessoa (codigo, nome, telefone, email, cpf) VALUES (5, 'Paulo Mendes', '51987654321', 'paulo@gmail.com', '55443322119');

INSERT INTO remetente (codigo, endereco) VALUES (1, 'Rua das Flores, 123');
INSERT INTO remetente (codigo, endereco) VALUES (2, 'Avenida Paulista, 1000');
INSERT INTO remetente (codigo, endereco) VALUES (3, 'Rua do Comércio, 45');
INSERT INTO remetente (codigo, endereco) VALUES (4, 'Praça da Sé, 50');
INSERT INTO remetente (codigo, endereco) VALUES (5, 'Alameda Santos, 800');

INSERT INTO gerente (codigo) VALUES (1);
INSERT INTO gerente (codigo) VALUES (2);
INSERT INTO gerente (codigo) VALUES (3);
INSERT INTO gerente (codigo) VALUES (4);
INSERT INTO gerente (codigo) VALUES (5);

INSERT INTO destinatario (codigo, endereco) VALUES (1, 'Rua A, 101');
INSERT INTO destinatario (codigo, endereco) VALUES (2, 'Rua B, 202');
INSERT INTO destinatario (codigo, endereco) VALUES (3, 'Rua C, 303');
INSERT INTO destinatario (codigo, endereco) VALUES (4, 'Rua D, 404');
INSERT INTO destinatario (codigo, endereco) VALUES (5, 'Rua E, 505');

INSERT INTO logistica (codigo, centroDistribuicao, codigoGerente) VALUES (1, 'Centro Sul', 1);
INSERT INTO logistica (codigo, centroDistribuicao, codigoGerente) VALUES (2, 'Centro Norte', 2);
INSERT INTO logistica (codigo, centroDistribuicao, codigoGerente) VALUES (3, 'Centro Oeste', 3);
INSERT INTO logistica (codigo, centroDistribuicao, codigoGerente) VALUES (4, 'Centro Leste', 4);
INSERT INTO logistica (codigo, centroDistribuicao, codigoGerente) VALUES (5, 'Centro Sudeste', 5);

INSERT INTO entrega (codigo, dataEnvio, dataEntrega, localizacao, status, codigoLogistica, codigoGerente) VALUES (1, TO_DATE('10-11-2024', 'DD-MM-YYYY'), TO_DATE('19-11-2024', 'DD-MM-YYYY'), 'SP', 'Em Transporte', 1, 1);
INSERT INTO entrega (codigo, dataEnvio, dataEntrega, localizacao, status, codigoLogistica, codigoGerente) VALUES (2, TO_DATE('11-11-2024', 'DD-MM-YYYY'), TO_DATE('20-11-2024', 'DD-MM-YYYY'), 'RJ', 'Pendente', 2, 2);
INSERT INTO entrega (codigo, dataEnvio, dataEntrega, localizacao, status, codigoLogistica, codigoGerente) VALUES (3, TO_DATE('12-11-2024', 'DD-MM-YYYY'), TO_DATE('21-11-2024', 'DD-MM-YYYY'), 'MG', 'Pendente', 3, 3);
INSERT INTO entrega (codigo, dataEnvio, dataEntrega, localizacao, status, codigoLogistica, codigoGerente) VALUES (4, TO_DATE('13-11-2024', 'DD-MM-YYYY'), TO_DATE('22-11-2024', 'DD-MM-YYYY'), 'BA', 'Em Transporte', 4, 4);
INSERT INTO entrega (codigo, dataEnvio, dataEntrega, localizacao, status, codigoLogistica, codigoGerente) VALUES (5, TO_DATE('14-11-2024', 'DD-MM-YYYY'), TO_DATE('18-11-2024', 'DD-MM-YYYY'), 'RS', 'A Caminho', 5, 5);

INSERT INTO pacote (codigo, peso, dataPostagem, categoria, codigoRemetente, codigoLogistica, codigoEntrega) VALUES (1, 2.5, TO_DATE('06-11-2024', 'DD-MM-YYYY'), 'Frágil', 1, 1, 1);
INSERT INTO pacote (codigo, peso, dataPostagem, categoria, codigoRemetente, codigoLogistica, codigoEntrega) VALUES (2, 1.2, TO_DATE('07-11-2024', 'DD-MM-YYYY'), 'Perecível', 2, 2, 2);
INSERT INTO pacote (codigo, peso, dataPostagem, categoria, codigoRemetente, codigoLogistica, codigoEntrega) VALUES (3, 3.0, TO_DATE('08-11-2024', 'DD-MM-YYYY'), 'Eletrônicos', 3, 3, 3);
INSERT INTO pacote (codigo, peso, dataPostagem, categoria, codigoRemetente, codigoLogistica, codigoEntrega) VALUES (4, 4.5, TO_DATE('09-11-2024', 'DD-MM-YYYY'), 'Documentos', 4, 4, 4);
INSERT INTO pacote (codigo, peso, dataPostagem, categoria, codigoRemetente, codigoLogistica, codigoEntrega) VALUES (5, 2.8, TO_DATE('10-11-2024', 'DD-MM-YYYY'), 'Geral', 5, 5, 5);

INSERT INTO funcionarioEntrega (codigo, nome, codigoEntrega) VALUES (1, 'Ricardo Lima', 1);
INSERT INTO funcionarioEntrega (codigo, nome, codigoEntrega) VALUES (2, 'Fernanda Alves', 2);
INSERT INTO funcionarioEntrega (codigo, nome, codigoEntrega) VALUES (3, 'Roberto Nunes', 3);
INSERT INTO funcionarioEntrega (codigo, nome, codigoEntrega) VALUES (4, 'Marina Rocha', 4);
INSERT INTO funcionarioEntrega (codigo, nome, codigoEntrega) VALUES (5, 'Carlos Soares', 5);

INSERT INTO entregaFeita (codigoDestinatario, codigoFuncionarioEntrega) VALUES (1, 1);
INSERT INTO entregaFeita (codigoDestinatario, codigoFuncionarioEntrega) VALUES (2, 2);
INSERT INTO entregaFeita (codigoDestinatario, codigoFuncionarioEntrega) VALUES (3, 3);
INSERT INTO entregaFeita (codigoDestinatario, codigoFuncionarioEntrega) VALUES (4, 4);
INSERT INTO entregaFeita (codigoDestinatario, codigoFuncionarioEntrega) VALUES (5, 5);

/* SELECT para teste */

SELECT * FROM pessoa;
SELECT * FROM remetente;
SELECT * FROM gerente;
SELECT * FROM destinatario;
SELECT * FROM logistica;
SELECT * FROM entrega;
SELECT * FROM pacote;
SELECT * FROM funcionarioEntrega;
SELECT * FROM entregaFeita;










































