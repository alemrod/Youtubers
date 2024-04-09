-- CREATE TABLE tb_youtubers(
-- 	cod_top_youtubers SERIAL PRIMARY KEY,
-- 	rank INT,
-- 	youtuber VARCHAR(200),
-- 	subscribers INT,
-- 	video_views VARCHAR(200),
-- 	video_count INT,
-- 	category VARCHAR(200),
-- 	started INT
-- );

-- ALTER TABLE tb_youtubers
-- 	ALTER COLUMN video_views
-- 	TYPE BIGINT USING video_views::BIGINT;
	
-- SELECT * FROM tb_youtubers;

-- -- um bloquinho anonimo
-- DO $$
-- DECLARE
-- 	--1. Declaracao do cursor (cursor nao vinculado)
-- 	cur_nomes_youtubers REFCURSOR;
-- 	v_youtuber VARCHAR(200);
	
-- BEGIN
-- 	--2. abertura do cursor
-- 	OPEN cur_nomes_youtubers FOR 
-- 	SELECT youtuber FROM tb_youtubers;

-- --3. recuperacao de dados de interesse
-- 	LOOP
-- 		FETCH cur_nomes_youtubers INTO v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
	
-- --4. fechar o cursor
-- 	CLOSE cur_nomes_youtubers;
-- END;
-- $$

-- --cursor não vinculado(unbound)
-- --cursor om query dinamica, ou seja, uma query representada
-- --como uma string
-- --mais um bloquinho anonimo
-- DO $$
-- DECLARE
-- 	--1. Declaracao
-- 	cur_nomes_a_partir_de REFCURSOR;
-- 	v_youtuber VARCHAR(200);
-- 	v_ano INT := 2000;
-- 	v_nome_tabela VARCHAR(200) := 'tb_youtubers';
	

-- BEGIN
-- 	--2. Abertura do cursor
-- 	OPEN cur_nomes_a_partir_de FOR EXECUTE
-- 	format(
-- 		'
-- 			SELECT
-- 				youtuber
-- 			FROM %s
-- 			WHERE started >= $1
-- 		', v_nome_tabela
-- 	)USING v_ano;
-- 	LOOP
-- 		--3. Recuperacao de dados
-- 		FETCH cur_nomes_a_partir_de INTO v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	--4. Fechamento do cursor
-- 	CLOSE cur_nomes_a_partir_de;
-- END;
-- $$

-- DO $$

-- DECLARE
-- 	v_nome VARCHAR(200) := 'Ana';
-- 	v_saudacao VARCHAR(200) := 'tudo bem?';
-- 	v_resultado VARCHAR(200);
-- BEGIN
-- 	--Oi, Ana
-- 	v_resultado := format('Oi, %s. %s', v_nome, v_saudacao);
-- 	RAISE NOTICE '%', v_resultado;
-- 	--python: red = f'Oi, {v_nome}. {v_saudacao}.';
-- END;
-- $$
-- --cursor vinculado (bound)
-- --exibir nome do canal concatenado a seu numero de inscritos
-- --mais um bloquinho anonimo
-- DO $$
-- 	DECLARE
-- 		-- cursor bound (vinculado)
-- 		--1. Declaracao (ainda não esta aberto)
-- 		cur_nomes_e_inscritos CURSOR FOR
-- 		SELECT youtuber, subscribers FROM tb_youtubers;
-- 		tupla RECORD;
-- 		--tupla.youtuber me da o youtuber
-- 		--tupla.subscribers me da o numero de subscribers
-- 		resultado TEXT DEFAULT '';
-- 	BEGIN
-- 		--2. Abertura do cursor
-- 		OPEN cur_nomes_e_inscritos;
-- 		--vamos usar um loop WHILE
-- 		--3. Recuperacao de dados
-- 		FETCH cur_nomes_e_inscritos INTO tupla;
-- 		WHILE FOUND LOOP
-- 			--concatenacao, operado ||
-- 			resultado := resultado ||':'|| tupla.youtuber ||':'|| tupla.subscribers || ',';
-- 			FETCH cur_nomes_e_inscritos INTO tupla;
-- 		END LOOP;
-- 		--4. Fechamento
-- 		CLOSE cur_nomes_e_inscritos;
-- 		RAISE NOTICE '%', resultado;
-- 	END;
-- $$


--cursor com parametro nomeado e por ordem
--exibir nomes dos youtubers que comecaram a partir de 2010
--e que tem, pelo menos, 60m inscritos
-- mais um bloquinho anonimo
DO $$
	DECLARE
		v_ano INT := 2010;
		v_inscritos INT := 60000000;
		--1. Declaracao do cursor
		cur_ano_inscritos CURSOR(ano INT, inscritos INT) FOR
		SELECT youtuber FROM tb_youtubers WHERE started >=ano AND subscribers >= inscritos;
		v_youtuber VARCHAR(200);
	BEGIN
		--2. Abertura do cursor
		--essa, passando argumentos pela ordem
		--OPEN cur_ano_inscritos(v_ano, v_inscritos);
		--ou essa, passando argumentos pelo nome, invertendo a ordem
		--OPEN cur_ano_inscritos(inscritos := v_inscritos, ano := v_ano);
		--ou essa, passando argumentos pelo nome, mantendo a ordem
		OPEN cur_ano_inscritos(ano := v_ano, inscritos := v_inscritos);
		LOOP
		--buscar o nome
		--3. Recuperação
		FETCH cur_ano_inscritos INTO v_youtuber;
		--sair, se for o caso
		EXIT WHEN NOT FOUND;
		--exibir, se puder
		RAISE NOTICE '%', v_youtuber;
		END LOOP;
		--4. Fechamento
		CLOSE cur_ano_inscritos;
	END;
$$