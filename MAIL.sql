/* Cria��o das tabelas */

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
                              codigoEntrega NUMBER PRIMARY KEY,
                              codigoDestinatario NUMBER NOT NULL,
                              codigoFuncionarioEntrega NUMBER NOT NULL,
                              CONSTRAINT entregaFeita_entrega_fk FOREIGN KEY (codigoEntrega) REFERENCES entrega (codigo),
                              CONSTRAINT entregaFeita_destinatario_fk FOREIGN KEY (codigoDestinatario) REFERENCES destinatario (codigo),
                              CONSTRAINT entregaFeita_funcionarioEntrega_fk FOREIGN KEY (codigoFuncionarioEntrega) REFERENCES funcionarioEntrega (codigo)
);

/* Inser��o de dados */

INSERT INTO pessoa (codigo, nome, telefone, email, cpf) VALUES (1, 'Jo�o Silva', '11987654321', 'joao@gmail.com', '12345678901');
INSERT INTO pessoa (codigo, nome, telefone, email, cpf) VALUES (2, 'Maria Oliveira', '21987654321', 'maria@gmail.com', '98765432100');
INSERT INTO pessoa (codigo, nome, telefone, email, cpf) VALUES (3, 'Carlos Souza', '31987654321', 'carlos@gmail.com', '11223344556');
INSERT INTO pessoa (codigo, nome, telefone, email, cpf) VALUES (4, 'Ana Costa', '41987654321', 'ana@gmail.com', '66778899001');
INSERT INTO pessoa (codigo, nome, telefone, email, cpf) VALUES (5, 'Paulo Mendes', '51987654321', 'paulo@gmail.com', '55443322119');

INSERT INTO remetente (codigo, endereco) VALUES (1, 'Rua das Flores, 123');
INSERT INTO remetente (codigo, endereco) VALUES (2, 'Avenida Paulista, 1000');
INSERT INTO remetente (codigo, endereco) VALUES (3, 'Rua do Com�rcio, 45');
INSERT INTO remetente (codigo, endereco) VALUES (4, 'Pra�a da S�, 50');
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

INSERT INTO entrega (codigo, dataEnvio, dataEntrega, localizacao, status, codigoLogistica, codigoGerente) VALUES (1, TO_DATE('10-11-2024', 'DD-MM-YYYY'), TO_DATE('19-11-2024', 'DD-MM-YYYY'), 'S�o Paulo, SP', 'Em Transporte', 1, 1);
INSERT INTO entrega (codigo, dataEnvio, dataEntrega, localizacao, status, codigoLogistica, codigoGerente) VALUES (2, TO_DATE('11-11-2024', 'DD-MM-YYYY'), TO_DATE('20-11-2024', 'DD-MM-YYYY'), 'Niter�i, RJ', 'A Caminho', 2, 2);
INSERT INTO entrega (codigo, dataEnvio, dataEntrega, localizacao, status, codigoLogistica, codigoGerente) VALUES (3, TO_DATE('12-11-2024', 'DD-MM-YYYY'), TO_DATE('21-11-2024', 'DD-MM-YYYY'), 'Patos de Minas, MG', 'Em Transporte', 3, 3);
INSERT INTO entrega (codigo, dataEnvio, dataEntrega, localizacao, status, codigoLogistica, codigoGerente) VALUES (4, TO_DATE('13-11-2024', 'DD-MM-YYYY'), TO_DATE('22-11-2024', 'DD-MM-YYYY'), 'Salvador, BA', 'Em Transporte', 4, 4);
INSERT INTO entrega (codigo, dataEnvio, dataEntrega, localizacao, status, codigoLogistica, codigoGerente) VALUES (5, TO_DATE('14-11-2024', 'DD-MM-YYYY'), TO_DATE('18-11-2024', 'DD-MM-YYYY'), 'Gramado, RS', 'A Caminho', 5, 5);
INSERT INTO entrega (codigo, dataEnvio, dataEntrega, localizacao, status, codigoLogistica, codigoGerente) VALUES (6, TO_DATE('15-11-2024', 'DD-MM-YYYY'), TO_DATE('20-11-2024', 'DD-MM-YYYY'), 'Araraquara, SP', 'Em Transporte', 1, 1);

INSERT INTO pacote (codigo, peso, dataPostagem, categoria, codigoRemetente, codigoLogistica, codigoEntrega) VALUES (1, 2.5, TO_DATE('06-11-2024', 'DD-MM-YYYY'), 'Fr�gil', 1, 1, 1);
INSERT INTO pacote (codigo, peso, dataPostagem, categoria, codigoRemetente, codigoLogistica, codigoEntrega) VALUES (2, 1.2, TO_DATE('07-11-2024', 'DD-MM-YYYY'), 'Perec�vel', 2, 2, 2);
INSERT INTO pacote (codigo, peso, dataPostagem, categoria, codigoRemetente, codigoLogistica, codigoEntrega) VALUES (3, 3.0, TO_DATE('08-11-2024', 'DD-MM-YYYY'), 'Eletr�nicos', 3, 3, 3);
INSERT INTO pacote (codigo, peso, dataPostagem, categoria, codigoRemetente, codigoLogistica, codigoEntrega) VALUES (4, 4.5, TO_DATE('09-11-2024', 'DD-MM-YYYY'), 'Documentos', 4, 4, 4);
INSERT INTO pacote (codigo, peso, dataPostagem, categoria, codigoRemetente, codigoLogistica, codigoEntrega) VALUES (5, 2.8, TO_DATE('10-11-2024', 'DD-MM-YYYY'), 'Geral', 5, 5, 5);
INSERT INTO pacote (codigo, peso, dataPostagem, categoria, codigoRemetente, codigoLogistica, codigoEntrega) VALUES (6, 3.7, TO_DATE('11-11-2024', 'DD-MM-YYYY'), 'Fr�gil', 5, 5, 6);


INSERT INTO funcionarioEntrega (codigo, nome, codigoEntrega) VALUES (1, 'Ricardo Lima', 1);
INSERT INTO funcionarioEntrega (codigo, nome, codigoEntrega) VALUES (2, 'Fernanda Alves', 2);
INSERT INTO funcionarioEntrega (codigo, nome, codigoEntrega) VALUES (3, 'Roberto Nunes', 3);
INSERT INTO funcionarioEntrega (codigo, nome, codigoEntrega) VALUES (4, 'Marina Rocha', 4);
INSERT INTO funcionarioEntrega (codigo, nome, codigoEntrega) VALUES (5, 'Carlos Soares', 5);
INSERT INTO funcionarioEntrega (codigo, nome, codigoEntrega) VALUES (6, 'Carlos Soares', 6);


INSERT INTO entregaFeita (codigoEntrega, codigoDestinatario, codigoFuncionarioEntrega) VALUES (1, 1, 1);
INSERT INTO entregaFeita (codigoEntrega, codigoDestinatario, codigoFuncionarioEntrega) VALUES (2, 2, 2);
INSERT INTO entregaFeita (codigoEntrega, codigoDestinatario, codigoFuncionarioEntrega) VALUES (3, 3, 3);
INSERT INTO entregaFeita (codigoEntrega, codigoDestinatario, codigoFuncionarioEntrega) VALUES (4, 4, 4);
INSERT INTO entregaFeita (codigoEntrega, codigoDestinatario, codigoFuncionarioEntrega) VALUES (5, 5, 5);
INSERT INTO entregaFeita (codigoEntrega, codigoDestinatario, codigoFuncionarioEntrega) VALUES (6, 5, 5);


/* VIEWS */

/* VIEW para visualizar os gerentes e os centros em que eles s�o respons�veis, fornecendo uma vis�o clara dos gerentes
e o setor de log�stica que est�o sob sua responsabilidade, sendo �til para acompanhar suas �reas de atua��o*/
CREATE OR REPLACE VIEW gerentes_responsaveis AS
SELECT
    g.codigo AS codigo_Gerente, p.nome AS nome_Gerente, l.centroDistribuicao
FROM gerente g
         JOIN pessoa p ON g.codigo = p.codigo
         JOIN logistica l ON g.codigo = l.codigoGerente;

SELECT * FROM gerentes_responsaveis;

/* VIEW para visualizar as entregas associadas ao destinatario, permite ver facilmente as entregas associadas,
promovendo maior clareza sem exibir informa��es desnecess�rias */
CREATE OR REPLACE VIEW entregas_por_destinatario AS
SELECT
    d.codigo AS codigo_Destinatario, p.nome AS nome_Destinatario, e.codigo AS codigo_Entrega,
    e.dataEnvio AS data_Envio, e.dataEntrega AS data_Entrega, e.status
FROM destinatario d
         JOIN pessoa p ON d.codigo = p.codigo
         JOIN entregaFeita ef ON d.codigo = ef.codigoDestinatario
         JOIN entrega e ON ef.codigoEntrega = e.codigo;

SELECT * FROM entregas_por_destinatario;

/* VIEW para visualizar as informa��es de cada entrega, exibe detalhes sobre por onde o pacote est�,
sendo essencial para a log�stica e ger�ncia, promovendo a supervis�o dos pacotes e suas entregas */
CREATE OR REPLACE VIEW rastrear_entregas AS
SELECT
    p.codigo AS codigo_Pacote, p.peso AS peso_kg, p.dataPostagem AS data_Postagem,
    p.categoria, e.dataEnvio AS data_Envio, e.dataEntrega AS data_Entrega,
    e.localizacao, e.status, r.endereco AS endereco_Remetente, d.endereco AS endereco_Destinatario
FROM pacote p
         JOIN entrega e ON e.codigo = p.codigoEntrega
         JOIN remetente r ON r.codigo = p.codigoRemetente
         JOIN destinatario d ON d.codigo = e.codigo;

SELECT * FROM rastrear_entregas;

/* VIEW para visualizar as entregas e seu funcion�rio respons�vel pela entrega, identificando os funcion�rios e facilitando
o gerenciamento e promovendo a supervis�o pelo setor da log�stica */
CREATE OR REPLACE VIEW entregas_por_funcionario AS
SELECT
    e.codigo AS codigo_Entrega, e.dataEnvio AS data_Envio, e.dataEntrega AS data_Entrega,
    e.status, f.nome AS funcionario_Responsavel
FROM entrega e
         JOIN funcionarioEntrega f ON e.codigo = f.codigoEntrega;

SELECT * FROM entregas_por_funcionario;

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


/* recupera a quantidade total de entregas realizadas por centro de distribui��o, ordenando os resultados de forma decrescente pelo total de entregas.
   � uma consulta complexa por contar a quantidade de entregas por centro de distribui��o, realizando um join com a tabela entrega para verificar a quantidade, al�m disso � utilizado o agrupamento por centro. */

select l.centroDistribuicao, count(*) as totalEntregas
from logistica l
    inner join entrega e
        on l.codigo = e.codigoLogistica
group by l.centroDistribuicao
order by totalEntregas desc;

/* retorna informa��es detalhadas sobre uma entrega, incluindo remetente, destinat�rio, entregador e o centro de distribui��o associado.
   � uma consulta complexa por possuir multiplas jun��es entre diferentes tabelas, e cada tabela depende da outra. */

select e.codigo as codigoEntrega, e.localizacao, e.status,
    pa.codigo as codigoPacote,
    pe.nome as nomeRemetente,
    r.endereco as enderecoRemetente,
    d.endereco as enderecoDestinatario,
    fe.nome as nomeEntregador,
    l.centroDistribuicao
from entrega e
     inner join pacote pa
         on e.codigo = pa.codigoEntrega
     inner join remetente r
         on pa.codigoRemetente = r.codigo
     inner join pessoa pe
         on r.codigo = pe.codigo
     inner join logistica l
         on e.codigoLogistica = l.codigo
     inner join entregaFeita ef
         on e.codigo = ef.codigoEntrega
     inner join destinatario d
         on ef.codigoDestinatario = d.codigo
     inner join funcionarioEntrega fe
         on fe.codigoEntrega = e.codigo
order by codigoEntrega asc;

/* exibe detalhes de pacotes, incluindo remetente, centro de distribui��o e gerente respons�vel.
   � uma consulta complexa por possuir m�ltiplas jun��es entre diferentes tabelas, para recuperar todas as informa��es, al�m disso, ordena os centros por ordem alfab�tica. */
select p.codigo as codigo_pacote, p.peso, p.categoria, p.dataPostagem,
    r.endereco as endereco_remetente,
    l.centroDistribuicao,
    pe.nome as nome_gerente
from pacote p
    inner join remetente r
        on p.codigoRemetente = r.codigo
    inner join logistica l
        on p.codigoLogistica = l.codigo
    inner join gerente g
        on l.codigoGerente = g.codigo
    inner join pessoa pe
        on g.codigo = pe.codigo
order by centroDistribuicao asc;

/* calcula o tempo m�dio de entrega por categoria de pacote.
   � uma consulta complexa por possuir jun��o entre duas tabelas, para que seja calculado a m�dia de entrega pela categoria do pacote.*/
select p.categoria,
    avg(e.dataEntrega - p.dataPostagem) as tempoMedio
from pacote p
    inner join entrega e ON p.codigoEntrega = e.codigo
group by p.categoria;

/* lista remetentes e o n�mero total de pacotes enviados por eles, ordenando pelos remetentes mais ativos.
   � uma consulta complexa porque o nome do remetente est� na tabela pessoa, sendo assim � necess�rio percorrer v�rias tabelas at� recuperar o nome, al�m disso � agrupado por remetente */
select pe.nome as nomeRemetente,
    count(*) as totalPacotes
from pacote p
    inner join remetente r
        on p.codigoRemetente = r.codigo
    inner join pessoa pe
        on r.codigo = pe.codigo
group by pe.nome
order by totalPacotes desc;


/* a subconsulta � usada dentro da clausula where para retornar todos os pesos de pacotes da categoria 'Fr�gil'
   para que a consulta principal compare o peso de cada pacote com o pacote mais pesado dos pacotes fr�geis */
select codigo, peso, categoria
from pacote
where peso >= all
    (select peso
    from pacote
    where categoria = 'Fr�gil')
and categoria <> 'Fr�gil';

/*  a subconsulta busca o codigoGerente na tabela logistica onde o centroDistribuicao � 'Centro Norte'
    a consulta principal filtra as entregas com base nesse c�digo do gerente. */
select e.codigo, e.dataEnvio, e.dataEntrega, e.localizacao, e.status
from entrega e
where e.codigoGerente =
    (select l.codigoGerente
    from logistica l
    where l.centroDistribuicao = 'Centro Norte');

/* aqui s�o utilizadas duas subconsultas:
   a primeira subconsulta retorna os c�digos dos destinat�rios de entregas feitas por um funcion�rio cujo c�digo de entrega � diferente de 'Fernanda Alves'.
   a segunda subconsulta verifica o c�digo do funcion�rio que tem o nome 'Fernanda Alves' */
select d.codigo, d.endereco
from destinatario d
where d.codigo in
    (select ef.codigoDestinatario
    from entregaFeita ef
    where ef.codigoFuncionarioEntrega <>
        (select fe.codigo
        from funcionarioEntrega fe
        where fe.nome = 'Fernanda Alves')
);