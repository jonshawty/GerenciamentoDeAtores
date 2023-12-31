﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="atuacao.aspx.cs" Inherits="AtoresFilmes.atuacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <header runat="server">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" integrity="sha384-Tv8cU9tDQK9OhqdJ97JWAUp0mLAvhMl5+5tbs1t4tkQTK6ug+Puy0azeg6cYydF7" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <link rel="stylesheet" href="Estilos.css" />
    </header>

    <div class="container mt-4">
        <h2>Associar Ator a Filme</h2>
        <div class="mb-4">
            <div class="mb-3">
                <label for="ddlAtor" class="form-label">Ator:</label>
                <asp:DropDownList ID="ddlAtor" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                    <asp:ListItem Text="-- Selecione --" Value="" />
                </asp:DropDownList>
            </div>
            <div class="mb-3">
                <label for="ddlFilme" class="form-label">Filme:</label>
                <asp:DropDownList ID="ddlFilme" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                    <asp:ListItem Text="-- Selecione --" Value="" />
                </asp:DropDownList>
            </div>
            <br />
            <asp:Button ID="btnAssociar" runat="server" Text="Associar" CssClass="btn btn-primary" OnClick="btnAssociar_Click" />
            <asp:Label ID="lblMsgErroAssociacao" runat="server" Text="Erro! A associação já existe." Visible="False" CssClass="text-danger"></asp:Label>
        </div>

        <div class="mb-4">
            <h3>Pesquisar Associações de Ator e Filme</h3>
            <div class="mb-3">
                <label for="txtAtorPesquisa" class="form-label">Ator:</label>
                <asp:TextBox ID="txtAtorPesquisa" runat="server" CssClass="form-control" Placeholder="Digite um Ator ou Filme"></asp:TextBox>
            </div>
        </div>
        <br />
        <asp:Button ID="btnPesquisarAssociacoes" runat="server" Text="Pesquisar" CssClass="btn btn-primary" OnClick="btnPesquisarAssociacoes_Click" />
        <br />
        <br />
    </div>
    <asp:GridView ID="gvAssociacoes" runat="server"
        AutoGenerateColumns="False"
        AutoGenerateDeleteButton="True"
        AllowPaging="true"
        PageSize="5"
        OnPageIndexChanging="gvAssociacoes_PageIndexChanging"
        OnRowDeleting="gvAssociacoes_RowDeleting"
        CssClass="table table-bordered pt-2">
        <Columns>
            <asp:BoundField DataField="AtorFilmeID" HeaderText="ID" SortExpression="ID" />
            <asp:BoundField DataField="NomeCompleto" HeaderText="Nome do Ator" SortExpression="Nome do Ator" />
            <asp:BoundField DataField="filme_titulo" HeaderText="Filme" SortExpression="Filme" />
        </Columns>
    </asp:GridView>
</asp:Content>