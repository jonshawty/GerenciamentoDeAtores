using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AtoresFilmes
{
    public partial class idioma : System.Web.UI.Page
    {
        // Método que carrega os idiomas na grade com base na descrição fornecida.
        private void CarregaIdioma(string descricao)
        {
            DSimdbTableAdapters.IdiomaTableAdapter ta = new DSimdbTableAdapters.IdiomaTableAdapter();
            DSimdb.IdiomaDataTable dt = ta.GetIdioma(descricao);

            gvIdioma.DataSource = dt;
            gvIdioma.DataBind();
        }

        // Evento que ocorre ao carregar a página.
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Carrega os idiomas ao carregar a página pela primeira vez.
                CarregaIdioma("");
                gvIdioma.DataBind();
                guardaId.Visible = false;
                btnAtualizarIdioma.Visible = false;
                // Adiciona o manipulador de eventos para a mudança de página na grade.
                gvIdioma.PageIndexChanging += gvIdioma_PageIndexChanging;
            }
        }

        // Manipulador de eventos para a mudança de página na grade.
        protected void gvIdioma_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvIdioma.PageIndex = e.NewPageIndex;
            // Carrega os idiomas novamente após a mudança de página.
            CarregaIdioma("");
        }

        // Evento acionado ao clicar no botão de pesquisa.
        protected void btnPesquisar_Click(object sender, EventArgs e)
        {
            string descricao = txtDescricaoIdiomaPesquisa.Text;
            // Carrega os idiomas com base na descrição fornecida.
            CarregaIdioma(descricao);
        }

        // Evento acionado ao clicar no botão de inserção de um novo idioma.
        protected void btnInserirIdioma_Click(object sender, EventArgs e)
        {
            string descricao = txtDescricaoIdioma.Text;
            int? retorno = null;

            DSimdbTableAdapters.IdiomaTableAdapter ta = new DSimdbTableAdapters.IdiomaTableAdapter();

            // Insere um novo idioma no banco de dados.
            ta.insertIdioma(descricao, ref retorno);

            if (retorno == -1)
            {
                // Exibe uma mensagem de erro se o idioma já existe.
                ScriptManager.RegisterStartupScript(this, GetType(), "ErroIdioma", "alert('Erro! O idioma inserido já existe.');", true);
            }
            else
            {
                // Limpa o campo de descrição após a inserção.
                txtDescricaoIdioma.Text = "";
                // Carrega os idiomas novamente após a inserção.
                CarregaIdioma("");
            }
        }

        // Evento acionado ao editar uma linha na grade de idiomas.
        protected void gvIdioma_RowEditing(object sender, GridViewEditEventArgs e)
        {
            btnInserirIdioma.Visible = false;
            btnAtualizarIdioma.Visible = true;
            gvIdioma.EditIndex = e.NewEditIndex;
            // Carrega os dados do idioma a ser editado.
            CarregaDadosIdioma(e.NewEditIndex);
            CarregaIdioma("");
        }

        // Evento acionado ao cancelar a edição de uma linha na grade de idiomas.
        protected void gvIdioma_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            btnInserirIdioma.Visible = true;
            btnAtualizarIdioma.Visible = false;
            gvIdioma.EditIndex = -1;
            gvIdioma.DataBind();
        }

        // Método que carrega os dados do idioma para edição.
        private void CarregaDadosIdioma(int rowIndex)
        {
            if (rowIndex >= 0 && rowIndex < gvIdioma.Rows.Count)
            {
                string guardaid = gvIdioma.Rows[rowIndex].Cells[1].Text;
                string descricao = HttpUtility.HtmlDecode(gvIdioma.Rows[rowIndex].Cells[2].Text);

                txtDescricaoIdioma.Text = descricao;
                guardaId.Text = guardaid;
            }
        }

        // Método que atualiza os dados do idioma após a edição.
        private void AtualizaDadosIdioma(int rowIndex)
        {
            try
            {
                if (rowIndex >= 0 && rowIndex < gvIdioma.Rows.Count)
                {
                    string idiomaID = guardaId.Text;

                    string novaDescricao = txtDescricaoIdioma.Text;

                    DSimdbTableAdapters.IdiomaTableAdapter ta = new DSimdbTableAdapters.IdiomaTableAdapter();
                    // Atualiza os dados do idioma no banco de dados.
                    ta.updateIdioma(Convert.ToInt32(idiomaID), novaDescricao);

                    gvIdioma.EditIndex = -1;

                    gvIdioma.DataBind();

                    btnInserirIdioma.Visible = true;
                    // Carrega os idiomas novamente após a atualização.
                    CarregaIdioma("");
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErroAtualizacaoIdioma", "alert('Dados atualizados com sucesso!'); window.location.href = '" + Request.RawUrl + "';", true);
                }
            }
            catch (Exception ex)
            {
                string mensagemErro = $"Erro ao atualizar: {ex.Message}";
                ScriptManager.RegisterStartupScript(this, GetType(), "ErroAtualizacaoIdioma", $"alert('{mensagemErro}');", true);
            }
        }

        // Evento acionado ao excluir uma linha na grade de idiomas.
        protected void gvIdioma_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            RemoverIdioma(e.RowIndex);
        }


        protected void gvIdioma_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
                AtualizaDadosIdioma(gvIdioma.EditIndex);
        }

        // Método que remove um idioma.
        private void RemoverIdioma(int rowIndex)
        {
            Console.WriteLine("chegou aqui");
            if (rowIndex >= 0 && rowIndex < gvIdioma.Rows.Count)
            {
                try
                {
                    string idiomaID = gvIdioma.Rows[rowIndex].Cells[1].Text;

                    if (IsIdiomaVinculadoAFilme(Convert.ToInt32(idiomaID)))
                    {
                        // Exibe uma mensagem de erro se o idioma está vinculado a pelo menos um filme.
                        ScriptManager.RegisterStartupScript(this, GetType(), "ErroExclusaoIdioma", "alert('Não é possível excluir o idioma porque está vinculado a pelo menos um filme.');", true);
                    }
                    else
                    {
                        DSimdbTableAdapters.IdiomaTableAdapter ta = new DSimdbTableAdapters.IdiomaTableAdapter();
                        // Remove o idioma do banco de dados.
                        ta.deleteIdioma(Convert.ToInt32(idiomaID));

                        // Carrega os idiomas novamente após a exclusão.
                        CarregaIdioma("");
                        ScriptManager.RegisterStartupScript(this, GetType(), "SucessoExclusaoIdioma", "alert('Dados removidos com sucesso!.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErroExclusaoIdioma", $"alert('Erro ao excluir: {ex.Message}');", true);
                }
            }
        }

        // Método que verifica se um idioma está vinculado a pelo menos um filme.
        private bool IsIdiomaVinculadoAFilme(int idiomaID)
        {
            try
            {
                DSimdbTableAdapters.FilmeTableAdapter filmeAdapter = new DSimdbTableAdapters.FilmeTableAdapter();
                int? retorno = null;

                filmeAdapter.VerificaIdiomasPorFilme(idiomaID, ref retorno);

                return retorno == 1;
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErroExclusaoIdioma", $"alert('Erro ao excluir: {ex.Message}');", true);
                return false;
            }
        }

        // Evento acionado ao clicar no botão de atualização após edição.
        protected void btnAtualizaIdioma_Click(object sender, EventArgs e)
        {
            // Chama o método para atualizar os dados do idioma.
            AtualizaDadosIdioma(gvIdioma.EditIndex);
        }
    }
}