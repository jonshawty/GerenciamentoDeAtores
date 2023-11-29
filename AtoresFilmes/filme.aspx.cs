using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AtoresFilmes
{
    public partial class filme : System.Web.UI.Page
    {
        // Evento que ocorre ao carregar a página.
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Carrega os filmes ao carregar a página pela primeira vez.
                CarregaFilme("", "", -1, "", -1, "");
                // Atualiza a GridView de filmes.
                gvFilme.DataBind();
                // Oculta o elemento de guardaId e os botões de atualização ao carregar a página.
                guardaId.Visible = false;
                btnAtualizarFilme.Visible = false;
            }
        }

        // Método que carrega os idiomas na DropDownList.
        private void CarregaIdiomas()
        {
            try
            {
                DSimdbTableAdapters.IdiomaTableAdapter idiomaAdapter = new DSimdbTableAdapters.IdiomaTableAdapter();
                DSimdb.IdiomaDataTable dtIdiomas = idiomaAdapter.GetIdioma("");

                ddlIdioma.DataSource = dtIdiomas;
                ddlIdioma.DataTextField = "descricao";
                ddlIdioma.DataValueField = "id";
                ddlIdioma.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        // Método que carrega os filmes com base nos parâmetros fornecidos.
        private void CarregaFilme(string titulo, string descricao, int ano_lancamento, string categoria, int idioma_id, string classificacao_indicativa)
        {
            DSimdbTableAdapters.FilmeTableAdapter ta = new DSimdbTableAdapters.FilmeTableAdapter();
            DSimdb.FilmeDataTable dt = ta.GetFilme(titulo);

            // Se não for um postback, carrega os idiomas na DropDownList.
            if (!IsPostBack)
            {
                CarregaIdiomas();
            }

            gvFilme.DataSource = dt;
            gvFilme.DataBind();
        }

        // Evento acionado ao clicar no botão para inserir um novo filme.
        protected void btnInserirFilme_Click(object sender, EventArgs e)
        {
            // Obtém os valores dos campos do novo filme.
            string titulo = txtTitulo.Text;
            string descricao = txtDescricao.Text;
            int anoLancamento = Convert.ToInt32(txtAnoLancamento.Text);
            string categoria = txtCategoria.Text;
            int idiomaId = Convert.ToInt32(ddlIdioma.SelectedValue);
            string classificacaoIndicativa = txtClassificacao.Text;
            int? retorno = null;

            // Utiliza o TableAdapter para inserir o novo filme no banco de dados.
            DSimdbTableAdapters.FilmeTableAdapter ta = new DSimdbTableAdapters.FilmeTableAdapter();

            ta.insertFilme(titulo, descricao, anoLancamento, categoria, idiomaId, classificacaoIndicativa, ref retorno);

            // Verifica se houve algum erro durante a inserção.
            if (retorno == -1)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErroIdioma", "alert('Erro! O filme inserido já existe.');", true);
            }
            else
            {
                // Redireciona para a página de filmes após a inserção bem-sucedida.
                Response.Redirect("filme.aspx");
            }
        }

        // Evento acionado ao clicar no botão de pesquisa de filmes.
        protected void btnPesquisarFilme_Click(object sender, EventArgs e)
        {
            // Obtém o título do filme para pesquisa.
            string titulo = txtTituloFilme.Text;
            // Carrega os filmes com base no título fornecido.
            CarregaFilme(titulo, "", -1, "", -1, "");
        }

        // Evento acionado ao editar uma linha na GridView de filmes.
        protected void gvFilme_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // Oculta o botão de inserção e exibe o botão de atualização ao editar uma linha.
            btnInserirFilme.Visible = false;
            btnAtualizarFilme.Visible = true;
            // Define o índice de edição na GridView.
            gvFilme.EditIndex = e.NewEditIndex;
            // Carrega os dados do filme para edição.
            CarregaDadosFilme(e.NewEditIndex);
        }

        protected void gvFilme_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            AtualizaDadosFilme(gvFilme.EditIndex);
        }

        // Evento acionado ao cancelar a edição de uma linha na GridView de filmes.
        protected void gvFilme_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // Exibe o botão de inserção e oculta o botão de atualização ao cancelar a edição.
            btnInserirFilme.Visible = true;
            btnAtualizarFilme.Visible = false;
            // Limpa o índice de edição na GridView.
            gvFilme.EditIndex = -1;
        }

        // Método que carrega os dados do filme para edição com base no índice da GridView.
        private void CarregaDadosFilme(int rowIndex)
        {
            if (rowIndex >= 0 && rowIndex < gvFilme.Rows.Count)
            {
                // Obtém os valores das células da linha selecionada na GridView.
                string guardaid = HttpUtility.HtmlDecode(gvFilme.Rows[rowIndex].Cells[1].Text);
                string titulo = HttpUtility.HtmlDecode(gvFilme.Rows[rowIndex].Cells[2].Text);
                string descricao = HttpUtility.HtmlDecode(gvFilme.Rows[rowIndex].Cells[3].Text);
                string anoLancamento = HttpUtility.HtmlDecode(gvFilme.Rows[rowIndex].Cells[4].Text);
                string categoria = HttpUtility.HtmlDecode(gvFilme.Rows[rowIndex].Cells[5].Text);
                string classificacao = HttpUtility.HtmlDecode(gvFilme.Rows[rowIndex].Cells[6].Text);
                string idioma = HttpUtility.HtmlDecode(gvFilme.Rows[rowIndex].Cells[7].Text);

                // Preenche os campos de edição com os valores obtidos.
                txtTitulo.Text = titulo;
                txtDescricao.Text = descricao;
                txtAnoLancamento.Text = anoLancamento;
                txtCategoria.Text = categoria;
                txtClassificacao.Text = classificacao;

                // Seleciona o idioma correspondente na DropDownList.
                ListItem item = ddlIdioma.Items.Cast<ListItem>()
                    .FirstOrDefault(i => string.Equals(i.Text, idioma, StringComparison.OrdinalIgnoreCase));

                if (item != null)
                {
                    ddlIdioma.ClearSelection(); // Limpa seleções anteriores.
                    item.Selected = true;
                }

                // Armazena o ID do filme em um elemento oculto.
                guardaId.Text = guardaid;
            }
        }

        // Método que atualiza os dados de um filme após a edição.
        private void AtualizaDadosFilme(int rowIndex)
        {
            try
            {
                if (rowIndex >= 0 && rowIndex < gvFilme.Rows.Count)
                {
                    // Obtém os valores atualizados dos campos de edição.
                    string filmeID = guardaId.Text;
                    string novoTitulo = txtTitulo.Text;
                    string novaDescricao = txtDescricao.Text;
                    string novoAnoLancamento = txtAnoLancamento.Text;
                    string novaCategoria = txtCategoria.Text;
                    string novaClassificacao = txtClassificacao.Text;
                    string idiomaId = ddlIdioma.SelectedValue;

                    // Utiliza o TableAdapter para atualizar os dados do filme no banco de dados.
                    DSimdbTableAdapters.FilmeTableAdapter ta = new DSimdbTableAdapters.FilmeTableAdapter();
                    ta.updateFilme(Convert.ToInt32(filmeID), novoTitulo, novaDescricao, Convert.ToInt32(novoAnoLancamento), novaCategoria, Convert.ToInt32(idiomaId), novaClassificacao);

                    // Atualiza a GridView de filmes.
                    gvFilme.DataBind();

                    // Exibe o botão de inserção e oculta o botão de atualização.
                    btnInserirFilme.Visible = true;
                    btnAtualizarFilme.Visible = false;
                    // Recarrega a lista de filmes.
                    CarregaFilme("", "", -1, "", -1, "");
                    // Exibe uma mensagem de sucesso e atualiza a página.
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErroAtualizacao", "alert('Dados atualizados com sucesso!'); window.location.href = '" + Request.RawUrl + "';", true);
                }
            }
            catch (Exception ex)
            {
                // Em caso de erro, exibe uma mensagem de alerta.
                string mensagemErro = $"Erro ao atualizar: {ex.Message}";
                ScriptManager.RegisterStartupScript(this, GetType(), "ErroAtualizacao", $"alert('{mensagemErro}');", true);
            }
        }

        // Evento acionado ao excluir uma linha na GridView de filmes.
        protected void gvFilme_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Chama o método para remover o filme.
            RemoverFilme(e.RowIndex);
        }

        // Método que remove um filme.
        private void RemoverFilme(int rowIndex)
        {
            if (rowIndex >= 0 && rowIndex < gvFilme.Rows.Count)
            {
                try
                {
                    // Obtém o ID do filme a ser removido.
                    string filmeID = gvFilme.Rows[rowIndex].Cells[1].Text;

                    if (IsAtorVinculadoAtor(Convert.ToInt32(filmeID)))
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "ErroExclusaoAtor", "alert('Não é possível excluir o Filme porque está vinculado a pelo menos um Ator.');", true);
                    }
                    else
                    {
                        // Utiliza o TableAdapter para excluir o filme do banco de dados.
                        DSimdbTableAdapters.FilmeTableAdapter ta = new DSimdbTableAdapters.FilmeTableAdapter();
                        ta.deleteFilme(Convert.ToInt32(filmeID));

                        // Recarrega a lista de filmes após a remoção.
                        CarregaFilme("", "", -1, "", -1, "");
                        ScriptManager.RegisterStartupScript(this, GetType(), "ErroAtualizacao", $"alert('Dados removidos com sucesso!.');", true);
                    }
                }
                catch (Exception ex)
                {
                    // Em caso de erro, exibe uma mensagem de alerta.
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErroExclusao", $"alert('Erro ao excluir: {ex.Message}');", true);
                }
            }
        }

        private bool IsAtorVinculadoAtor(int filmeID)
        {
            try
            {
                DSimdbTableAdapters.FilmeTableAdapter FilmeAdapter = new DSimdbTableAdapters.FilmeTableAdapter();
                int? retorno = null;

                FilmeAdapter.VerificaVinculoFilme(filmeID, ref retorno);
                return retorno == 1;
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErroExclusaoIdioma", $"alert('Erro ao excluir: {ex.Message}');", true);
                return false;
            }
        }

        // Evento acionado ao clicar no botão de atualização de filme.
        protected void btnAtualizaFilme_Click(object sender, EventArgs e)
        {
            // Chama o método para atualizar os dados do filme.
            AtualizaDadosFilme(gvFilme.EditIndex);
        }
    }
}