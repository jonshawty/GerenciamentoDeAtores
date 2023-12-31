﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ator.aspx.cs" Inherits="AtoresFilmes.ator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <header runat="server">
        <!-- Adicione as referências ao Bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" integrity="sha384-Tv8cU9tDQK9OhqdJ97JWAUp0mLAvhMl5+5tbs1t4tkQTK6ug+Puy0azeg6cYydF7" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <link rel="stylesheet" href="Estilos.css" />
    </header>

    <div class="container mt-4">

        <h2>Inserir/ Pesquisar Ator</h2>

        <div class="mb-4">
            <div class="mb-3">
                <label for="txtNome" class="form-label">Nome:</label>
                <asp:TextBox ID="txtNome" runat="server" CssClass="form-control" placeholder="Insira o nome"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label for="txtSobrenome" class="form-label">Sobrenome:</label>
                <asp:TextBox ID="txtSobrenome" runat="server" CssClass="form-control" placeholder="Insira o sobrenome"></asp:TextBox>
            </div>
            <br />
            <asp:Button ID="btnInsereAtor" runat="server" Text="Inserir" CssClass="btn btn-primary" OnClick="btnInsereAtor_Click" />
            <asp:Button ID="btnAtualizarAtor" runat="server" Text="Atualizar" CssClass="btn btn-primary" OnClick="btnAtualizaAtor_Click" />
            <asp:Label ID="lblMsgErro" runat="server" Text="Erro! O ator inserido já existe." Visible="False" CssClass="text-danger"></asp:Label>
            <asp:TextBox ID="guardaId" runat="server"></asp:TextBox>
        </div>

        <div>
            <h3>Pesquisar Ator</h3>
            <div class="mb-3">
                <label for="txtNomeAtor" class="form-label">Nome:</label>
                <asp:TextBox ID="txtNomeAtor" runat="server" CssClass="form-control" placeholder="Insira o nome"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label for="txtSobreNomeAtor" class="form-label">Sobrenome:</label>
                <asp:TextBox ID="txtSobreNomeAtor" runat="server" CssClass="form-control" placeholder="Insira o sobrenome"></asp:TextBox>
            </div>
            <br />
            <asp:Button ID="btnPesquisar" runat="server" Text="Pesquisar" CssClass="btn btn-primary" OnClick="btnPesquisar_Click" />
            <br />
            <br />

            <asp:GridView ID="gvAtor" runat="server"
                AutoGenerateEditButton="True"
                AutoGenerateDeleteButton="True"
                AutoGenerateColumns="False"
                AllowPaging="true"
                PageSize="5"
                OnRowEditing="gvAtor_RowEditing"
                OnRowCancelingEdit="gvAtor_RowCancelingEdit"
                OnRowDeleting="gvAtor_RowDeleting"
                onRowUpdating="gvAtor_RowUpdating"
                OnPageIndexChanging="gvAtor_PageIndexChanging"
                CssClass="table table-bordered pt-2">

                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" ReadOnly="True" />
                    <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" />
                    <asp:BoundField DataField="Sobrenome" HeaderText="Sobrenome" SortExpression="Sobrenome" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
