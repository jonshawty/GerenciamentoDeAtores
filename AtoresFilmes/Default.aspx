<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AtoresFilmes._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ListView ID="lvFilme" runat="server" DataKeyNames="id">
        <LayoutTemplate>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Lista de Filmes</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                </tbody>
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <a href='<%# Eval("id", "DetalhesFilme.aspx?filmeId={0}") %>'>
                        <%# Eval("titulo") %>
                    </a>
                </td>
            </tr>
        </ItemTemplate>
    </asp:ListView>
</asp:Content>