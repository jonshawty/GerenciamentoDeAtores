USE [master]
GO
/****** Object:  Database [imbd]    Script Date: 26/11/2023 12:01:25 ******/
CREATE DATABASE [imbd]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'imbd', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\imbd.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'imbd_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\imbd_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [imbd] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [imbd].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [imbd] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [imbd] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [imbd] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [imbd] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [imbd] SET ARITHABORT OFF 
GO
ALTER DATABASE [imbd] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [imbd] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [imbd] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [imbd] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [imbd] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [imbd] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [imbd] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [imbd] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [imbd] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [imbd] SET  ENABLE_BROKER 
GO
ALTER DATABASE [imbd] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [imbd] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [imbd] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [imbd] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [imbd] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [imbd] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [imbd] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [imbd] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [imbd] SET  MULTI_USER 
GO
ALTER DATABASE [imbd] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [imbd] SET DB_CHAINING OFF 
GO
ALTER DATABASE [imbd] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [imbd] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [imbd] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [imbd] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [imbd] SET QUERY_STORE = OFF
GO
USE [imbd]
GO
/****** Object:  Table [dbo].[Ator]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ator](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](255) NULL,
	[sobrenome] [varchar](255) NULL,
	[ret] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AtorFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AtorFilme](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ator_id] [int] NOT NULL,
	[filme_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ator_id] ASC,
	[filme_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Filme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Filme](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](255) NULL,
	[descricao] [varchar](max) NULL,
	[ano_lancamento] [int] NULL,
	[categoria] [varchar](255) NULL,
	[idioma_id] [int] NULL,
	[classificacao_indicativa] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Idioma]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idioma](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[descricao] [varchar](255) NULL,
	[retorno] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AtorFilme]  WITH CHECK ADD FOREIGN KEY([ator_id])
REFERENCES [dbo].[Ator] ([id])
GO
ALTER TABLE [dbo].[AtorFilme]  WITH CHECK ADD FOREIGN KEY([filme_id])
REFERENCES [dbo].[Filme] ([id])
GO
ALTER TABLE [dbo].[Filme]  WITH CHECK ADD  CONSTRAINT [FK_Filme_Idioma] FOREIGN KEY([idioma_id])
REFERENCES [dbo].[Idioma] ([id])
GO
ALTER TABLE [dbo].[Filme] CHECK CONSTRAINT [FK_Filme_Idioma]
GO
/****** Object:  StoredProcedure [dbo].[deleteAtor]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[deleteAtor]
(
	@atorID INT,
	@ret INT OUTPUT
)
AS
BEGIN
	-- Verifique se o ator existe
	IF NOT EXISTS (SELECT 1 FROM ator WHERE id = @atorID)
	BEGIN
		SET @ret = -1
		RETURN
	END

	-- Exclua o ator
	DELETE FROM ator WHERE id = @atorID

	SET @ret = 1
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteAtorFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteAtorFilme]
    @atorFilmeId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verifica se o registro existe
    IF EXISTS (SELECT 1 FROM AtorFilme WHERE id = @atorFilmeId)
    BEGIN
        -- Deleta o registro da tabela AtorFilme
        DELETE FROM AtorFilme WHERE id = @atorFilmeId;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteFilme]
    @filmeId INT
AS
BEGIN
    DELETE FROM Filme
    WHERE id = @filmeId;
END
GO
/****** Object:  StoredProcedure [dbo].[deleteIdioma]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteIdioma]
    @idiomaId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Exclui o idioma
    DELETE FROM Idioma WHERE id = @idiomaId;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetAtoresPorFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAtoresPorFilme]
    @filmeId INT
AS
BEGIN
    SELECT A.id AS ator_id, A.nome AS ator_nome, A.sobrenome AS ator_sobrenome
    FROM AtorFilme AF
    INNER JOIN Ator A ON AF.ator_id = A.id
    WHERE AF.filme_id = @filmeId;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetDetalhesFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDetalhesFilme]
    @filmeId INT
AS
BEGIN
    SELECT
        titulo
    FROM
        Filme
    WHERE
        id = @filmeId;
END;
GO
/****** Object:  StoredProcedure [dbo].[insertAtor]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insertAtor]
(
	@nome varchar(255),
	@sobrenome varchar(255),
	@ret int output
)
AS
begin
if exists(select * from ator where nome = @nome and sobrenome=@sobrenome)
	set @ret = -1
else
	INSERT into ator (nome,sobrenome) values (@nome,@sobrenome)
end
GO
/****** Object:  StoredProcedure [dbo].[InsertAtorFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAtorFilme]
    @atorId INT,
    @filmeId INT,
    @ret INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verifica se a associação já existe
    IF EXISTS (SELECT 1 FROM AtorFilme WHERE ator_id = @atorId AND filme_id = @filmeId)
    BEGIN
        -- Define o código de retorno para indicar que a associação já existe
        SET @ret = -1;
    END
    ELSE
    BEGIN
        -- Insere a associação na tabela AtorFilme
        INSERT INTO AtorFilme (ator_id, filme_id) VALUES (@atorId, @filmeId);

        -- Define o código de retorno para indicar sucesso
        SET @ret = 1;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[insertFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[insertFilme]
(
    @titulo VARCHAR(255),
    @descricao TEXT,
    @ano_lancamento INT,
    @categoria VARCHAR(255),
    @idioma_id INT,
    @classificacao_indicativa VARCHAR(10),
    @ret INT OUTPUT
)
AS
BEGIN
    -- Verificar se o filme já existe pelo título
    IF EXISTS (SELECT * FROM Filme WHERE titulo = @titulo)
    BEGIN
        SET @ret = -1
    END
    ELSE
    BEGIN
        -- Inserir o filme na tabela
        INSERT INTO Filme (titulo, descricao, ano_lancamento, categoria, idioma_id, classificacao_indicativa)
        VALUES (@titulo, @descricao, @ano_lancamento, @categoria, @idioma_id, @classificacao_indicativa)

        SET @ret = SCOPE_IDENTITY() -- Retorna o ID do filme recém-inserido
    END
END
GO
/****** Object:  StoredProcedure [dbo].[insertIdioma]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insertIdioma]
    @descricao VARCHAR(255),
    @ret INT OUTPUT
AS
BEGIN
    -- Verifique se o idioma já existe
    IF EXISTS (SELECT 1 FROM Idioma WHERE descricao = @descricao)
    BEGIN
        SET @ret = -1;
    END
    ELSE
    BEGIN
        -- Insira o idioma se não existir
        INSERT INTO Idioma (descricao) VALUES (@descricao);
        SET @ret = SCOPE_IDENTITY(); -- Retorna o ID do idioma recém-inserido
    END
END
GO
/****** Object:  StoredProcedure [dbo].[selectAtor]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[selectAtor] 
	@nome varchar(255) = '',@sobrenome varchar(255) = ''
AS
BEGIN
	select * 
	from ator
	where nome like '%' + @nome + '%' AND 
		sobrenome like '%' + @sobrenome + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAtoresPorFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAtoresPorFilme]
    @filmeId INT
AS
BEGIN
    SELECT A.id, A.nome, A.sobrenome
    FROM AtorFilme AF
    INNER JOIN Ator A ON AF.ator_id = A.id
    WHERE AF.filme_id = @filmeId;
END;
GO
/****** Object:  StoredProcedure [dbo].[SelectAtorFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAtorFilme]
    @termoBusca NVARCHAR(255) = ''
AS
BEGIN
    SELECT AF.id AS AtorFilmeID, A.nome AS ator_nome, A.sobrenome AS ator_sobrenome, F.titulo AS filme_titulo
    FROM AtorFilme AF
    INNER JOIN Ator A ON AF.ator_id = A.id
    INNER JOIN Filme F ON AF.filme_id = F.id
    WHERE A.nome LIKE '%' + @termoBusca + '%'
        OR A.sobrenome LIKE '%' + @termoBusca + '%'
        OR F.titulo LIKE '%' + @termoBusca + '%'
END;
GO
/****** Object:  StoredProcedure [dbo].[selectFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[selectFilme]
    @titulo VARCHAR(255) = ''
AS
BEGIN
    SELECT 
        Filme.id, 
        Filme.titulo, 
        Filme.descricao, 
        Filme.ano_lancamento, 
        Filme.categoria, 
        Idioma.descricao AS idioma, 
        Filme.classificacao_indicativa
    FROM Filme
    INNER JOIN Idioma ON Filme.idioma_id = Idioma.id
    WHERE 
        (Filme.titulo LIKE '%' + @titulo + '%')
        
END
GO
/****** Object:  StoredProcedure [dbo].[selectIdioma]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[selectIdioma]
    @descricao varchar(255) = ''
AS
BEGIN
    SELECT *
    FROM Idioma
    WHERE descricao LIKE '%' + @descricao + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[updateAtor]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateAtor]
(
	@atorID INT,
	@novoNome varchar(255),
	@novoSobrenome varchar(255),
	@ret int output
)
AS
BEGIN
	-- Verifique se o novo nome já existe para outro ator
	IF EXISTS (SELECT * FROM ator WHERE nome = @novoNome AND sobrenome = @novoSobrenome AND id <> @atorID)
	BEGIN
		SET @ret = -1
		RETURN
	END

	-- Atualize o ator
	UPDATE ator 
	SET 
		nome = @novoNome,
		sobrenome = @novoSobrenome
	WHERE 
		id = @atorID

	SET @ret = 1
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateFilme]
    @filmeId INT,
    @titulo VARCHAR(255),
    @descricao TEXT,
    @anoLancamento INT,
    @categoria VARCHAR(255),
    @idiomaId INT,
    @classificacaoIndicativa VARCHAR(10)
AS
BEGIN
    UPDATE Filme
    SET
        titulo = @titulo,
        descricao = @descricao,
        ano_lancamento = @anoLancamento,
        categoria = @categoria,
        idioma_id = @idiomaId,
        classificacao_indicativa = @classificacaoIndicativa
    WHERE
        id = @filmeId;
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateIdioma]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateIdioma]
    @idiomaId INT,
    @novaDescricao NVARCHAR(MAX)
AS
BEGIN
    UPDATE Idioma
    SET Descricao = @novaDescricao
    WHERE id = @idiomaId;
END;
GO
/****** Object:  StoredProcedure [dbo].[VerificaAtorPorFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VerificaAtorPorFilme]
    @AtorID INT,
    @Retorno INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Inicializa o valor de retorno
    SET @Retorno = 0;

    -- Verifica se existem associações de ator a filmes
    IF EXISTS (SELECT 1 FROM AtorFilme WHERE ator_id = @AtorID)
    BEGIN
        -- Se existir, define o valor de retorno para indicar que há filmes associados
        SET @Retorno = 1;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[VerificaFilmePorAtor]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VerificaFilmePorAtor]
    @FilmeID INT,
    @Retorno INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Inicializa o valor de retorno
    SET @Retorno = 0;

    -- Verifica se existem associações de ator ao filme
    IF EXISTS (SELECT 1 FROM AtorFilme WHERE filme_id = @FilmeID)
    BEGIN
        -- Se existir, define o valor de retorno para indicar que há atores associados
        SET @Retorno = 1;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[VerificaIdiomaPorFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VerificaIdiomaPorFilme]
    @IdiomaID INT,
    @Retorno INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Inicializa o valor de retorno
    SET @Retorno = 0;

    -- Verifica se existem filmes vinculados ao idioma
    IF EXISTS (SELECT 1 FROM Filme WHERE idioma_id = @IdiomaID)
    BEGIN
        -- Se existir, define o valor de retorno para indicar que há filmes vinculados
        SET @Retorno = 1;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[VerificarAssociacaoAtorFilme]    Script Date: 26/11/2023 12:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VerificarAssociacaoAtorFilme]
    @atorId INT,
    @filmeId INT,
    @ret INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verifica se a associação já existe
    IF EXISTS (SELECT 1 FROM AtorFilme WHERE ator_id = @atorId AND filme_id = @filmeId)
    BEGIN
        -- Define o código de retorno para indicar que a associação já existe
        SET @ret = 1;
    END
    ELSE
    BEGIN
        -- Define o código de retorno para indicar que a associação não existe
        SET @ret = 0;
    END
END;
GO
USE [master]
GO
ALTER DATABASE [imbd] SET  READ_WRITE 
GO
