<%@ Page Title="Detalhes do Filme" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetalhesFilme.aspx.cs" Inherits="AtoresFilmes.DetalhesFilme" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <header runat="server">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" integrity="sha384-Tv8cU9tDQK9OhqdJ97JWAUp0mLAvhMl5+5tbs1t4tkQTK6ug+Puy0azeg6cYydF7" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <link rel="stylesheet" href="Estilos.css" />
    </header>

    <div class="container">
        <h2>Detalhes do Filme</h2>

        <div class="row">
            <div class="col-md-6">
                <label>Título:</label>
                <asp:Label ID="lblTitulo" runat="server" Text=""></asp:Label>
            </div>
            <div class="col-md-6">
                <label>Ano de Lançamento:</label>
                <asp:Label ID="lblAnoLancamento" runat="server" Text=""></asp:Label>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <label>Descrição:</label>
                <asp:Label ID="lblDescricao" runat="server" Text=""></asp:Label>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <label>Idioma:</label>
                <asp:Label ID="lblIdioma" runat="server" Text=""></asp:Label>
            </div>
            <div class="col-md-6">
                <label>Categoria:</label>
                <asp:Label ID="lblCategoria" runat="server" Text=""></asp:Label>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <label>Classificação Indicativa: +</label>
                <asp:Label ID="lblClassificacaoIndicativa" runat="server" Text=""></asp:Label>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h3>Atores do Filme</h3>
                <asp:ListView ID="lvAtores" runat="server" DataKeyNames="ator_id">
                    <LayoutTemplate>
                        <table class="table table-bordered">
                            <tbody>
                                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <p><%# Eval("ator_nome") %> <%# Eval("ator_sobrenome") %></p>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>
</asp:Content>