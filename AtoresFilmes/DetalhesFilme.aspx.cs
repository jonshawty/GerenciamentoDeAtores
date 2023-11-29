using AtoresFilmes.DSimdbTableAdapters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AtoresFilmes
{
    public partial class DetalhesFilme : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Verifica se é a primeira vez que a página está sendo carregada após o postback.
            if (!IsPostBack)
            {
                // Verifica se o parâmetro "filmeId" está presente na URL.
                if (Request.QueryString["filmeId"] != null)
                {
                    // Converte o parâmetro "filmeId" para um inteiro.
                    int filmeId = Convert.ToInt32(Request.QueryString["filmeId"]);

                    // Chama a função para carregar os detalhes do filme.
                    CarregarDetalhesFilme(filmeId);

                    // Chama a função para carregar os atores que atuaram no filme.
                    carregaAtoresAtuando(filmeId);
                }
                else
                {
                    // Redireciona para a página padrão se o parâmetro "filmeId" não estiver presente.
                    Response.Redirect("Default.aspx");
                }
            }
        }

        // Esta função carrega os detalhes de um filme com base no seu ID.
        private void CarregarDetalhesFilme(int filmeId)
        {
            // Cria uma instância do adaptador de tabela Filme.
            DSimdbTableAdapters.FilmeTableAdapter ta = new DSimdbTableAdapters.FilmeTableAdapter();

            // Obtém os detalhes do filme em formato de string.
            string dt = Convert.ToString(ta.GetDetalhesFilme(filmeId));

            // Chama a função para carregar os filmes com base na string de detalhes.
            CarregaFilmes(dt);
        }

        // Esta função carrega os detalhes de um filme a partir de uma string.
        private void CarregaFilmes(string titulo)
        {
            // Cria uma instância do adaptador de tabela Filme.
            DSimdbTableAdapters.FilmeTableAdapter ta = new DSimdbTableAdapters.FilmeTableAdapter();

            // Obtém um DataTable com os detalhes do filme usando o título como parâmetro.
            DSimdb.FilmeDataTable dt = ta.GetFilme(titulo);

            // Verifica se há pelo menos uma linha no DataTable.
            if (dt.Rows.Count > 0)
            {
                // Obtém a primeira linha do DataTable.
                DataRow row = dt.Rows[0];

                // Preenche as labels com os detalhes do filme.
                lblTitulo.Text = row["titulo"].ToString();
                lblDescricao.Text = row["descricao"].ToString();
                lblAnoLancamento.Text = row["ano_lancamento"].ToString();
                lblIdioma.Text = row["idioma"].ToString();
                lblCategoria.Text = row["categoria"].ToString();
                lblClassificacaoIndicativa.Text = row["classificacao_indicativa"].ToString();
            }
        }

        // Esta função carrega os atores que atuaram em um filme com base no seu ID.
        private void carregaAtoresAtuando(int filmeId)
        {
            try
            {
                // Cria uma instância do adaptador de tabela Ator.
                DSimdbTableAdapters.AtorTableAdapter atuacaoAdapter = new DSimdbTableAdapters.AtorTableAdapter();

                // Obtém um DataTable com os atores que atuaram no filme usando o ID do filme como parâmetro.
                DSimdb.AtorDataTable dt = atuacaoAdapter.GetAtoresPorFilme(filmeId);

                // Verifica se o DataTable é nulo ou não contém linhas.
                if (dt != null && dt.Rows.Count > 0)
                {
                    // Existem atores, carrega o ListView normalmente.
                    lvAtores.DataSource = dt;
                }
                else
                {
                    // Não há atores cadastrados, exibe a mensagem de erro.
                    string mensagem = "Não existem atores cadastrados para este filme.";
                    lvAtores.DataSource = new string[] { mensagem };
                }

                // Atualiza o ListView.
                lvAtores.DataBind();
            }
            catch (Exception ex)
            {
                // Trate exceções, se necessário.
                string erro = "Ocorreu um erro ao carregar os atores: " + ex.Message;
                lvAtores.DataSource = new string[] { erro };
            }
        }

    }
}