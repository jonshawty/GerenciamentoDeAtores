﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="idioma.aspx.cs" Inherits="AtoresFilmes.idioma" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <header runat="server">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" integrity="sha384-Tv8cU9tDQK9OhqdJ97JWAUp0mLAvhMl5+5tbs1t4tkQTK6ug+Puy0azeg6cYydF7" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <link rel="stylesheet" href="Content/Estilos.css" />
    </header>

    <div class="container mt-4">
        <h2>Inserir/ Pesquisar Idioma</h2>

        <!-- Seção de Inserção -->
        <div class="mb-4">
            <div class="mb-3">
                <label for="txtDescricaoIdioma" class="form-label">Descrição:</label>
                <asp:TextBox ID="txtDescricaoIdioma" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <br />
            <asp:Button ID="btnInserirIdioma" runat="server" Text="Inserir" CssClass="btn btn-primary" OnClick="btnInserirIdioma_Click" />
            <asp:Button ID="btnAtualizarIdioma" runat="server" Text="Atualizar" CssClass="btn btn-primary" OnClick="btnAtualizaIdioma_Click" />
            <asp:Label ID="lblMsgErroIdioma" runat="server" Text="Erro! O idioma inserido já existe." Visible="False" CssClass="text-danger"></asp:Label>
            <asp:TextBox ID="guardaId" runat="server"></asp:TextBox>
        </div>

        <!-- Seção de Pesquisa -->
        <div class="flex-column">
            <h3>Pesquisar Idioma</h3>
            <div class="mb-3">
                <label for="txtDescricaoIdiomaPesquisa" class="form-label">Descrição:</label>
                <asp:TextBox ID="txtDescricaoIdiomaPesquisa" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <br />
            <asp:Button ID="btnPesquisar" runat="server" Text="Pesquisar" CssClass="btn btn-primary" OnClick="btnPesquisar_Click" />
            <br />
            <br />
            <asp:GridView ID="gvIdioma" runat="server"
                AutoGenerateEditButton="True"
                AutoGenerateDeleteButton="True"
                AutoGenerateColumns="False"
                AllowPaging="true"
                PageSize="5"
                OnPageIndexChanging="gvIdioma_PageIndexChanging"
                OnRowEditing="gvIdioma_RowEditing"
                OnRowUpdating="gvIdioma_RowUpdating"
                OnRowCancelingEdit="gvIdioma_RowCancelingEdit"
                OnRowDeleting="gvIdioma_RowDeleting"
                CssClass="table table-bordered pt-2"
                RowStyle-CssClass="custom-normal-row-style"
                EditRowStyle-CssClass="custom-edit-row-style">

                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" />
                    <asp:BoundField DataField="descricao" HeaderText="Descrição" SortExpression="Descrição" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>