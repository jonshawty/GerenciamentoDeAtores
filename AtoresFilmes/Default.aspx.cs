using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AtoresFilmes
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CarregaFilmes("");
        }

        // Esta função carrega e popula um listView, a escolha do ListView foi feita por ter a necessidade de ter um componente que somente exibisse uma lista de itens.
        private void CarregaFilmes(string titulo)
        {
            DSimdbTableAdapters.FilmeTableAdapter ta = new DSimdbTableAdapters.FilmeTableAdapter();
            DSimdb.FilmeDataTable dt = ta.GetFilme(titulo);

            lvFilme.DataSource = dt;
            lvFilme.DataBind();
        }
    }
}