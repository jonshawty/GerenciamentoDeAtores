using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AtoresFilmes
{
    public partial class ator : System.Web.UI.Page
    {
        private void CarregaAtor(string nome, string sobrenome)
        {
            DSimdbTableAdapters.AtorTableAdapter ta = new DSimdbTableAdapters.AtorTableAdapter();
            DSimdb.AtorDataTable dt = ta.getAtor(nome, sobrenome);
            gvAtor.DataSource = dt;
            gvAtor.DataBind();
            guardaId.Visible = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            btnAtualizarAtor.Visible = false;
            if (!IsPostBack)
            {
                // Atribuir o manipulador de eventos ao evento PageIndexChanging
                gvAtor.PageIndexChanging += gvAtor_PageIndexChanging;

                // Chame o método para carregar os dados iniciais no GridView

                CarregaAtor("", "");
            }
        }

        protected void gvAtor_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAtor.PageIndex = e.NewPageIndex;
            // Chame o método para carregar novamente os dados no GridView
            CarregaAtor("", "");
        }

        protected void btnPesquisar_Click(object sender, EventArgs e)
        {
            string nome = txtNomeAtor.Text;
            string sobrenome = txtSobreNomeAtor.Text;
            CarregaAtor(nome, sobrenome);
        }

        protected void btnInsereAtor_Click(object sender, EventArgs e)
        {
            string nome = txtNome.Text;
            string sobrenome = txtSobrenome.Text;
            int? retorno = null;

            DSimdbTableAdapters.AtorTableAdapter ta = new DSimdbTableAdapters.AtorTableAdapter();

            ta.insertAtor(nome, sobrenome, ref retorno);

            if (retorno == -1)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErroIdioma", "alert('Erro! O ator inserido já existe.');", true);
            }
            else
            {
                Response.Redirect("ator.aspx");
            }
        }

        protected void gvAtor_RowEditing(object sender, GridViewEditEventArgs e)
        {
            btnInsereAtor.Visible = false;
            btnAtualizarAtor.Visible = true;
            gvAtor.EditIndex = e.NewEditIndex;
            CarregaDadosAtor(e.NewEditIndex);
            CarregaAtor("", "");
        }

        protected void gvAtor_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            AtualizaDadosAtor(gvAtor.EditIndex);
        }

        protected void gvAtor_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            btnInsereAtor.Visible = true;
            btnAtualizarAtor.Visible = false;
            gvAtor.EditIndex = -1;
        }

        private void CarregaDadosAtor(int rowIndex)
        {
            if (rowIndex >= 0 && rowIndex < gvAtor.Rows.Count)
            {
                string guardaid = gvAtor.Rows[rowIndex].Cells[1].Text;
                string nome = HttpUtility.HtmlDecode(gvAtor.Rows[rowIndex].Cells[2].Text);
                string sobrenome = HttpUtility.HtmlDecode(gvAtor.Rows[rowIndex].Cells[3].Text);

                txtNome.Text = nome;
                txtSobrenome.Text = sobrenome;
                guardaId.Text = guardaid;
            }
        }

        private void AtualizaDadosAtor(int rowIndex)
        {
            try
            {
                if (rowIndex >= 0 && rowIndex < gvAtor.Rows.Count)
                {
                    string atorID = guardaId.Text;

                    string novoNome = txtNome.Text;
                    string novoSobrenome = txtSobrenome.Text;

                    int? retorno = null;

                    DSimdbTableAdapters.AtorTableAdapter ta = new DSimdbTableAdapters.AtorTableAdapter();
                    ta.updateAtor(Convert.ToInt32(atorID), novoNome, novoSobrenome, ref retorno);

                    gvAtor.EditIndex = -1;

                    gvAtor.DataBind();

                    btnInsereAtor.Visible = true;
                    CarregaAtor("", "");
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErroAtualizacao", "alert('Dados atualizados com sucesso!'); window.location.href = '" + Request.RawUrl + "';", true);
                }
            }
            catch (Exception ex)
            {
                string mensagemErro = $"Erro ao atualizar: {ex.Message}";
                ScriptManager.RegisterStartupScript(this, GetType(), "ErroAtualizacao", $"alert('{mensagemErro}');", true);
            }
        }

        protected void gvAtor_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            RemoverAtor(e.RowIndex);
        }

        private void RemoverAtor(int rowIndex)
        {
            if (rowIndex >= 0 && rowIndex < gvAtor.Rows.Count)
            {
                try
                {
                    string atorID = gvAtor.Rows[rowIndex].Cells[1].Text;

                    if (IsAtorVinculadoAFilme(Convert.ToInt32(atorID)))
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "ErroExclusaoAtor", "alert('Não é possível excluir o idioma porque está vinculado a pelo menos um filme.');", true);
                    }
                    else
                    {
                        int? retorno = null;

                        DSimdbTableAdapters.AtorTableAdapter ta = new DSimdbTableAdapters.AtorTableAdapter();
                        ta.deleteAtor(Convert.ToInt32(atorID), ref retorno);

                        CarregaAtor("", "");
                        ScriptManager.RegisterStartupScript(this, GetType(), "ErroAtualizacao", $"alert('Dados removidos com sucesso!.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErroExclusao", $"alert('Erro ao excluir: {ex.Message}');", true);
                }
            }
        }

        private bool IsAtorVinculadoAFilme(int atorID)
        {
            try
            {
                DSimdbTableAdapters.AtorTableAdapter AtorAdapter = new DSimdbTableAdapters.AtorTableAdapter();
                int? retorno = null;

                AtorAdapter.VerificandoVinculoAtor(atorID, ref retorno);
                return retorno == 1;
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErroExclusaoIdioma", $"alert('Erro ao excluir: {ex.Message}');", true);
                return false;
            }
        }

        protected void btnAtualizaAtor_Click(object sender, EventArgs e)
        {
            AtualizaDadosAtor(gvAtor.EditIndex);
        }
    }
}