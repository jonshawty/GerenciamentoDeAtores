﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="filme.aspx.cs" Inherits="AtoresFilmes.filme" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <header runat="server">
        <!-- Adicione as referências ao Bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" integrity="sha384-Tv8cU9tDQK9OhqdJ97JWAUp0mLAvhMl5+5tbs1t4tkQTK6ug+Puy0azeg6cYydF7" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <!-- Sua folha de estilo personalizada, se houver -->
        <link rel="stylesheet" href="Estilos.css" />

        <!-- Restante do cabeçalho... -->
    </header>

    <div class="container mt-4">
        <h2>Inserir/ Pesquisar Filme</h2>

        <!-- Seção de Inserção -->
        <div class="mb-4">
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="txtTitulo" class="form-label">Título:</label>
                        <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" placeholder="Insira o título"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="txtDescricao" class="form-label">Descrição:</label>
                        <asp:TextBox ID="txtDescricao" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Insira a descrição"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="txtAnoLancamento" class="form-label">Ano de Lançamento:</label>
                        <asp:TextBox ID="txtAnoLancamento" runat="server" CssClass="form-control" placeholder="Insira o ano de lançamento"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="ddlIdioma" class="form-label">Idioma:</label>
                        <asp:DropDownList ID="ddlIdioma" runat="server" CssClass="form-control" AppendDataBoundItems="true" placeholder="-- Selecione --">
                            <asp:ListItem Text="-- Selecione --" Value="" />
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="txtCategoria" class="form-label">Categoria:</label>
                        <asp:TextBox ID="txtCategoria" runat="server" CssClass="form-control" placeholder="Insira a categoria"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="txtClassificacao" class="form-label">Classificação Indicativa:</label>
                        <asp:TextBox ID="txtClassificacao" runat="server" CssClass="form-control" placeholder="Insira a classificação indicativa"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <br />
                    <asp:Button ID="btnInserirFilme" runat="server" Text="Inserir" CssClass="btn btn-primary" OnClick="btnInserirFilme_Click" />
                    <asp:Button ID="btnAtualizarFilme" runat="server" Text="Atualizar" CssClass="btn btn-primary" OnClick="btnAtualizaFilme_Click" />
                    <asp:Label ID="lblMsgErroFilme" runat="server" Text="Erro! O filme inserido já existe." Visible="False" CssClass="text-danger"></asp:Label>
                    <asp:TextBox ID="guardaId" runat="server"></asp:TextBox>
                </div>
            </div>
        </div>

        <!-- Seção de Pesquisa -->
        <div class="flex-column">
            <h3>Pesquisar Filme</h3>
            <div class="mb-3">
                <label for="txtTituloFilme" class="form-label">Título:</label>
                <asp:TextBox ID="txtTituloFilme" runat="server" CssClass="form-control" placeholder="Insira o título"></asp:TextBox>
            </div>
            <br />
            <asp:Button ID="btnPesquisarFilme" runat="server" Text="Pesquisar" CssClass="btn btn-primary" OnClick="btnPesquisarFilme_Click" />
            <br />
            <br />
            <asp:GridView ID="gvFilme" runat="server"
                AutoGenerateEditButton="True"
                AutoGenerateDeleteButton="True"
                AutoGenerateColumns="False"
                AllowPaging="true"
                PageSize="5"
                OnRowEditing="gvFilme_RowEditing"
                OnRowCancelingEdit="gvFilme_RowCancelingEdit"
                OnRowUpdating="gvFilme_RowUpdating"
                OnRowDeleting="gvFilme_RowDeleting"
                CssClass="table table-bordered pt-2">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="ID" SortExpression="id" ReadOnly="True" />
                    <asp:BoundField DataField="titulo" HeaderText="Título" SortExpression="titulo" />
                    <asp:BoundField DataField="descricao" HeaderText="Descrição" SortExpression="descricao" />
                    <asp:BoundField DataField="ano_lancamento" HeaderText="Ano de Lançamento" SortExpression="ano_lancamento" />
                    <asp:BoundField DataField="categoria" HeaderText="Categoria" SortExpression="categoria" />
                    <asp:BoundField DataField="classificacao_indicativa" HeaderText="Classificação Indicativa" SortExpression="classificacao_indicativa" />
                    <asp:BoundField DataField="idioma" HeaderText="idioma" SortExpression="idioma" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>