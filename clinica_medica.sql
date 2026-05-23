CREATE DATABASE clinica;

CREATE TABLE especialidade (
    id_especialidade SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor_consulta NUMERIC(10,2) NOT NULL
);

CREATE TABLE paciente (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE medico (
    crm VARCHAR(20) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    id_especialidade INTEGER NOT NULL,
    
    CONSTRAINT fk_medico_especialidade
        FOREIGN KEY (id_especialidade)
        REFERENCES especialidade(id_especialidade)
);

CREATE TABLE consulta (
    codigo SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    cpf_paciente VARCHAR(11) NOT NULL,
    crm_medico VARCHAR(20) NOT NULL,

    CONSTRAINT fk_consulta_paciente
        FOREIGN KEY (cpf_paciente)
        REFERENCES paciente(cpf),

    CONSTRAINT fk_consulta_medico
        FOREIGN KEY (crm_medico)
        REFERENCES medico(crm)
);

CREATE TABLE receita_medica (
    codigo SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    medicamentos TEXT NOT NULL,
    orientacoes TEXT,
    codigo_consulta INTEGER UNIQUE,

    CONSTRAINT fk_receita_consulta
        FOREIGN KEY (codigo_consulta)
        REFERENCES consulta(codigo)
);

INSERT INTO especialidade (nome, valor_consulta)
VALUES
('Ortopedia', 300.00),
('Neurologia', 450.00),
('Ginecologia', 280.00),
('Oftalmologia', 320.00),
('Psiquiatria', 400.00);

SELECT * from clinica.public.especialidade;

INSERT INTO paciente (cpf, nome, data_nascimento, telefone, email)
VALUES
('12345678901', 'Amanda Oliveira Silva', '1998-05-10', '89999990001', 'amanda@gmail.com'),

('98765432100', 'Bruno Henrique Sousa', '1985-09-22', '89999990002', 'bruno@gmail.com'),

('45678912345', 'Carla Beatriz Lima', '2001-12-03', '89999990003', 'carla@gmail.com'),

('32165498700', 'Daniela Martins Costa', '1995-07-18', '89999990004', 'daniela@gmail.com'),

('74185296311', 'Eduardo Alves Rocha', '1992-11-30', '89999990005', 'eduardo@gmail.com');

SELECT * from clinica.public.paciente;

INSERT INTO medico (crm, nome, telefone, id_especialidade)
VALUES
('CRM1001', 'André Luiz Martins', '89999991001', 1),

('CRM1002', 'Beatriz Fernandes', '89999991002', 2),

('CRM1003', 'Carlos Eduardo Rocha', '89999991003', 3),

('CRM1004', 'Fernanda Alves Costa', '89999991004', 4),

('CRM1005', 'Ricardo Mendes Silva', '89999991005', 5);

SELECT * from clinica.public.medico;

INSERT INTO consulta (data, horario, status, cpf_paciente, crm_medico)
VALUES
('2026-05-10', '08:30:00', 'Realizada', '12345678901', 'CRM1001'),

('2026-05-11', '10:00:00', 'Agendada', '98765432100', 'CRM1002'),

('2026-05-12', '14:00:00', 'Cancelada', '45678912345', 'CRM1003'),

('2026-05-13', '09:15:00', 'Realizada', '32165498700', 'CRM1004'),

('2026-05-14', '16:30:00', 'Agendada', '74185296311', 'CRM1005');

SELECT * from clinica.public.consulta;

INSERT INTO receita_medica (data, medicamentos, orientacoes, codigo_consulta)
VALUES
('2026-05-10',
 'Ibuprofeno',
 'Tomar 1 comprimido a cada 8 horas por 3 dias.',
 1),

('2026-05-13',
 'Colírio',
 'Aplicar em cada olho duas vezes ao dia.',
 4);

SELECT * from clinica.public.receita_medica;

SELECT 
    medico.nome AS medico,
    especialidade.nome AS especialidade,
    especialidade.valor_consulta
FROM medico
INNER JOIN especialidade
ON medico.id_especialidade = especialidade.id_especialidade;

SELECT
    consulta.codigo,
    paciente.nome AS paciente,
    medico.nome AS medico,
    consulta.data,
    consulta.horario,
    consulta.status
FROM consulta
INNER JOIN paciente
ON consulta.cpf_paciente = paciente.cpf

INNER JOIN medico
ON consulta.crm_medico = medico.crm;