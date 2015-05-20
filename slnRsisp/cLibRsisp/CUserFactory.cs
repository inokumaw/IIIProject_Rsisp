using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

public class CUserFactory
{
    List<CUser> users=new List<CUser>();

    public CUserFactory()
    {
        loadData();
    }

    private void loadData()
    {
        SqlDataSource sds = new SqlDataSource();
        sds.ConnectionString = @"Data Source=CR4-10\MSSQLSERVER2013;Initial Catalog=Rsisp;Integrated Security=True";
        sds.SelectCommand = "dbo.getUsers";
        sds.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
        DataView dv = sds.Select(DataSourceSelectArguments.Empty) as DataView;

        if (dv.Count > 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                CUser user = new CUser();
                user.id = dv.Table.Rows[i]["ID_User"].ToString();
                user.name = dv.Table.Rows[i]["UserName"].ToString();
                user.role = dv.Table.Rows[i]["ID_Role"].ToString();
                user.account = dv.Table.Rows[i]["UserAccount"].ToString();
                user.password = dv.Table.Rows[i]["UserPassword"].ToString();
                users.Add(user);
            }
        }
    }

    public CUser[] getAll()
    {
        return users.ToArray();
    }

}

