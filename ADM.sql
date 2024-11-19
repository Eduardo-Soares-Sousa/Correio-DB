/* Avaliação P1 */
/* Eduardo Soares de Sousa*/
/* Vinicius Fazolaro Silva */

CONNECT SYS AS SYSDBA;
/* Usuario administrador MAIL */
DROP USER MAIL CASCADE;

CREATE USER MAIL IDENTIFIED BY mailpass;
ALTER USER MAIL DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;
ALTER USER MAIL TEMPORARY TABLESPACE TEMP;

GRANT CONNECT TO MAIL;

GRANT CREATE SESSION, CREATE VIEW, CREATE TABLE, ALTER SESSION, CREATE SEQUENCE TO MAIL;
GRANT CREATE SYNONYM, CREATE DATABASE LINK, RESOURCE, UNLIMITED TABLESPACE TO MAIL;

/* Usuario REMETENTE*/
DROP USER REMETENTE CASCADE;

CREATE USER REMETENTE IDENTIFIED BY remetentepass;
ALTER USER REMETENTE DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;
ALTER USER REMETENTE TEMPORARY TABLESPACE TEMP;
GRANT CREATE SESSION TO REMETENTE;

/* Usuario DESTINATARIO */
DROP USER DESTINATARIO CASCADE;

CREATE USER DESTINATARIO IDENTIFIED BY destinatariopass;
ALTER USER DESTINATARIO DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;
ALTER USER DESTINATARIO TEMPORARY TABLESPACE TEMP;
GRANT CREATE SESSION TO DESTINATARIO;

/* Usuario LOGISTICA */
DROP USER LOGISTICA CASCADE;

CREATE USER LOGISTICA IDENTIFIED BY logisticapass;
ALTER USER LOGISTICA DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;
ALTER USER LOGISTICA TEMPORARY TABLESPACE TEMP;
GRANT CREATE SESSION TO LOGISTICA;

/* Usuario GERENTE */
DROP USER GERENTE CASCADE;

CREATE USER GERENTE IDENTIFIED BY gerentepass;
ALTER USER GERENTE DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;
ALTER USER GERENTE TEMPORARY TABLESPACE TEMP;
GRANT CREATE SESSION TO GERENTE;

/* Usuario FUNCIONARIOENTREGA */
DROP USER FUNCIONARIOENTREGA CASCADE;

CREATE USER FUNCIONARIOENTREGA IDENTIFIED BY funcionarioentregapass;
ALTER USER FUNCIONARIOENTREGA DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;
ALTER USER FUNCIONARIOENTREGA TEMPORARY TABLESPACE TEMP;
GRANT CREATE SESSION TO  FUNCIONARIOENTREGA;

/* Criação de ROLES & Privilégios aos Usuarios */

/* ROLES */
DROP ROLE role_remetente;
DROP ROLE role_destinatario;
DROP ROLE role_logistica;
DROP ROLE role_gerente;
DROP ROLE role_funcionarioEntrega;

/* Permite que o usuário remetente tenha privilégios de inserir e atualizar dados do objeto pacote,
isso define o papel do remetente no sistema em que ele pode inserir ou modificar pacotes que serão 
enviados aos destinatarios. */
CREATE ROLE role_remetente;

/* Concede ao destinatario visualizar as entregas destinadas a ele, tendo o priilégio SELECT em
MAIL.entregas_por_destinatarios. */
CREATE ROLE role_destinatario;

/* Permite a logística atualizar informações dos pacotes e entregas, além de poder supervisionar
os funcionários responsáveis por cada entrega, sendo esse fundamental para o gerenciamento logístico. */
CREATE ROLE role_logistica;

/* Este usuario possui seus privégios de visualizar, inserir e atualizar dados sobre a logística e a entrega,
sendo o gerente responsável pelo setor logística, torna-se melhor a separação de responsabilidades.  */
CREATE ROLE role_gerente;

/* Permite aos entregadores realizar a consulta das entregas direcionadas aos destinatátarios, isso por meio
do de privilégio do SELECT e por meio da visão MAIL.entregas_por_destinatario, mantendo a restição dos entregadores,
pois torna claro sua função apenas de realizar a entrega sendo controlado pelo setor da logística e o gerente. */
CREATE ROLE role_funcionarioEntrega;

/* Atribuição de privilégios */
GRANT SELECT, INSERT, UPDATE ON MAIL.pacote TO role_remetente;

GRANT SELECT ON MAIL.entregas_por_destinatario TO role_destinatario;

GRANT SELECT, UPDATE ON MAIL.pacote TO role_logistica;
GRANT SELECT, UPDATE ON MAIL.entrega TO role_logistica;
GRANT SELECT ON MAIL.entregas_por_funcionario TO role_logistica;
GRANT SELECT ON MAIL.rastrear_entregas TO role_logistica;

GRANT SELECT, INSERT, UPDATE ON MAIL.logistica TO role_gerente;
GRANT SELECT, INSERT, UPDATE ON MAIL.entrega TO role_gerente;
GRANT SELECT ON MAIL.gerentes_responsaveis TO role_gerente;
GRANT SELECT ON MAIL.rastrear_entregas TO role_gerente;

GRANT SELECT ON MAIL.destinatario TO role_funcionarioEntrega;
GRANT SELECT ON MAIL.entrega TO role_funcionarioEntrega;
GRANT SELECT ON MAIL.entregas_por_destinatario TO role_funcionarioEntrega;

GRANT role_remetente TO remetente;
GRANT role_destinatario TO destinatario;
GRANT role_logistica TO logistica;
GRANT role_gerente TO gerente;
GRANT role_funcionarioEntrega TO funcionarioEntrega;

SELECT * FROM DBA_TS_QUOTAS;
SELECT * FROM DBA_USERS;



















