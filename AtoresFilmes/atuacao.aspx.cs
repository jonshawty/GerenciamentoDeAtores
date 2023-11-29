using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AtoresFilmes
{
    public partial class atuacao : System.Web.UI.Page
    {
        // Evento que ocorre ao carregar a página.
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Carrega as atuações ao carregar a página pela primeira vez.
                CarregarAtuacao("");
                // Preenche as dropdownlists de atores e filmes.
                PreencherDropDownListAtor();
                PreencherDropDownListFilme();
                gvAssociacoes.DataBind();
                // Adiciona o manipulador de eventos para a mudança de página na grade.
                gvAssociacoes.PageIndexChanging += gvAssociacoes_PageIndexChanging;
            }
        }

        // Manipulador de eventos para a mudança de página na grade.
        protected void gvAssociacoes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAssociacoes.PageIndex = e.NewPageIndex;
            // Carrega as atuações novamente após a mudança de página.
            CarregarAtuacao("");
        }

        // Método que carrega as atuações com base no nome do ator fornecido.
        private void CarregarAtuacao(string atorNome)
        {
            DSimdbTableAdapters.AtuacaoTableAdapter ta = new DSimdbTableAdapters.AtuacaoTableAdapter();
            DSimdb.AtuacaoDataTable dt = ta.GetAtuacao1(atorNome);

            // Adiciona uma coluna calculada que contém a concatenação de Nome e Sobrenome.
            dt.Columns.Add("NomeCompleto", typeof(string), "ator_nome + ' ' + ator_sobrenome");

            gvAssociacoes.DataSource = dt;
            gvAssociacoes.DataBind();
        }

        // Método que preenche a DropDownList de atores.
        private void PreencherDropDownListAtor()
        {
            try
            {
                DSimdbTableAdapters.AtorTableAdapter AtorAdapter = new DSimdbTableAdapters.AtorTableAdapter();
                DSimdb.AtorDataTable dtAtor = AtorAdapter.getAtor("", "");

                // Adiciona uma que contém a concatenação de Nome e Sobrenome.
                dtAtor.Columns.Add("NomeCompleto", typeof(string), "Nome + ' ' + Sobrenome");

                ddlAtor.DataSource = dtAtor;
                ddlAtor.DataTextField = "NomeCompleto"; // Usa o nome da coluna
                ddlAtor.DataValueField = "id";
                ddlAtor.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        // Método que preenche a DropDownList de filmes.
        private void PreencherDropDownListFilme()
        {
            try
            {
                DSimdbTableAdapters.FilmeTableAdapter ta = new DSimdbTableAdapters.FilmeTableAdapter();
                DSimdb.FilmeDataTable dtFilme = ta.GetFilme("");

                // Adiciona uma coluna que contém a concatenação de Título e Ano de Lançamento.
                dtFilme.Columns.Add("TituloAno", typeof(string), "titulo + ' ' +  '('+ano_lancamento+')'");

                ddlFilme.DataSource = dtFilme;
                ddlFilme.DataTextField = "TituloAno";
                ddlFilme.DataValueField = "id";
                ddlFilme.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        // Evento acionado ao clicar no botão para associar um ator a um filme.
        protected void btnAssociar_Click(object sender, EventArgs e)
        {
            try
            {
                int filmeId = Convert.ToInt32(ddlFilme.SelectedValue);
                int atorId = Convert.ToInt32(ddlAtor.SelectedValue);

                // Verifica se o ator está associado ao filme.
                if (!IsAtorAssociadoAFilme(atorId, filmeId))
                {
                    // O ator não está associado ao filme, então realiza a associação.
                    DSimdbTableAdapters.AtuacaoTableAdapter ta = new DSimdbTableAdapters.AtuacaoTableAdapter();
                    int? retorno = null;

                    ta.InsertAtorFilme(atorId, filmeId, ref retorno);

                    // Recarrega a grade após a associação.
                    CarregarAtuacao("");
                    ScriptManager.RegisterStartupScript(this, GetType(), "AtorAssociado", "alert('Associação feita com sucesso!.');", true);
                }
                else
                {
                    // O ator já está associado ao filme, exibe uma mensagem.
                    ScriptManager.RegisterStartupScript(this, GetType(), "AtorAssociado", "alert('Este ator já está associado a este filme.');", true);
                }
            }
            catch (Exception ex)
            {
                // Trata exceções, se necessário.
                ScriptManager.RegisterStartupScript(this, GetType(), "ErroAssociacaoAtorFilme", $"alert('Erro ao associar ator ao filme: {ex.Message}');", true);
            }
        }


        // Método que verifica se um ator está associado a um filme.
        private bool IsAtorAssociadoAFilme(int atorID, int filmeID)
        {
            try
            {
                DSimdbTableAdapters.AtuacaoTableAdapter atuacaoAdapter = new DSimdbTableAdapters.AtuacaoTableAdapter();
                int? retorno = null;

                // Chama a stored procedure para verificar a associação entre ator e filme.
                atuacaoAdapter.VerificaAtorFilme(atorID, filmeID, ref retorno);

                // Se o retorno for 1, indica que o ator está associado ao filme.
                return retorno == 1;
            }
            catch (Exception ex)
            {
                // Trata exceções, se necessário.
                ScriptManager.RegisterStartupScript(this, GetType(), "ErroVerificacaoAtorFilme", $"alert('Erro na verificação: {ex.Message}');", true);
                return false;
            }
        }

        // Evento acionado ao excluir uma linha na grade de atuações.
        protected void gvAssociacoes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            RemoverAtuacao(e.RowIndex);
        }

        // Método que remove uma atuação.
        private void RemoverAtuacao(int rowIndex)
        {
            if (rowIndex >= 0 && rowIndex < gvAssociacoes.Rows.Count)
            {
                try
                {
                    string atuacaoId = gvAssociacoes.Rows[rowIndex].Cells[1].Text;

                    DSimdbTableAdapters.AtuacaoTableAdapter ta = new DSimdbTableAdapters.AtuacaoTableAdapter();
                    ta.deleteAtuacao(Convert.ToInt32(atuacaoId));

                    // Recarrega as atuações após a remoção.
                    CarregarAtuacao("");
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErroAtualizacao", $"alert('Dados removidos com sucesso!.');", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErroExclusao", $"alert('Erro ao excluir: {ex.Message}');", true);
                }
            }
        }

        // Evento acionado ao clicar no botão de pesquisa de atuações.
        protected void btnPesquisarAssociacoes_Click(object sender, EventArgs e)
        {
            string descricao = txtAtorPesquisa.Text;
            // Carrega as atuações com base no nome do ator fornecido.
            CarregarAtuacao(descricao);
        }
    }
}