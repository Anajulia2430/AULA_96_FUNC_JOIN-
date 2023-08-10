-- Criação do Banco de dados 
create database ibge;

-- Ativação do Banco de dados 
use ibge;

-- Criação da tabela unidades federativas
create table unidades_federativas (
cod_uf int,
uf CHAR(2),
nome_uf VARCHAR(30),
primary key (cod_uf)
);

-- Criação da tabela municipios 
CREATE TABLE municipios (
cod_municipio INT,
cod_uf INT,
nome_municipio VARCHAR(40),
populacao int,
primary key (cod_municipio),
FOREIGN KEY (cod_uf) references unidades_federativas(cod_uf)
);

DROP TABLE unidades_federativas;

DROP TABLE municipios;

-- Listar todos os municipios e suas unidades federativas
select m.nome_municipio, u.nome_uf from municipios m INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf;

-- Listar os municipios e suas unidades federativas, ordenando pelo nome do municipio
select m.nome_municipio, m.populacao, u.uf from municipios m INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf;

-- Listar os municipios que possuem uma população superior a 100.000 habitantes, juntamente com a sigla da unidade federativa
SELECT m.nome_municipio, u.nome_uf
FROM municipios
JOIN unidades_federativas ON municipios.cod_uf = unidades_federativas.cod_uf
WHERE municipios.nome_municipio = unidades_federativas.nome_uf;

--
SELECT m.nome_municipio, u.nome_uf 
FROM municipios m INNER
JOIN unidades_federativas u ON m.cod_uf = u.cod_uf
ORDER BY m.nome_municipio;

-- Listar os munícipios que possuem uma populção superior a 100.000 habitantes, juntamente com a sigla da unidade federativa
SELECT m.nome_municipio, u.uf
FROM municipios m
JOIN unidades_federativas u ON m.cod_uf = u.cod_uf
WHERE m.populacao > 100000;


-- Listar os municipios que têm o mesmo nome que sua respectiva unidade federativa
SELECT m.nome_municipio, u.uf
FROM municipios m INNER
JOIN unidades_federativas u ON m.cod_uf = u.cod_uf
WHERE m.nome_municipio = u.nome_uf;

-- Calcular a média de população dos municipios para cada unidade federativa 
SELECT u.nome_uf, AVG(m.populacao) as media_populacao 
FROM municipios m 
INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf
group by u.uf; 

-- Listar os municipios que tem uma população maior que a média da populacao de todos os municipios 
SELECT *
FROM municipios m 
WHERE populacao > (SELECT AVG(m.populacao) as media_populacao
FROM municipios m);

-- Desafio
SELECT u.nome_uf, count(*) as quantidade_municipios 
FROM municipios m
INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf
group by u.uf;








