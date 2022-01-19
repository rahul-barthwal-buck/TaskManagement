using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaskManagement
{
    public partial class login : System.Web.UI.Page
    {
        private string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TaskManagementConnectionString"].ConnectionString;
        private SqlCommand sqlCommand;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        //Create Connection
        private void CreateConnection()
        {
            SqlConnection sqlConnection = new SqlConnection(strConnectionString);
            sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnection;

        }

        //Open Connection
        private void OpenConnection()
        {
            sqlCommand.Connection.Open();
        }
        //Close Connection
        private void CloseConnection()
        {
            sqlCommand.Connection.Close();
        }
        //Dispose Connection
        private void DisposeConnection()
        {
            sqlCommand.Connection.Dispose();
        }

        //This event handler works when user clicks on Login button
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    //First checking whether the UserName exist or not
                    CreateConnection();
                    OpenConnection();

                    //Strong values of coming from form into user object
                    User user = new User();
                    user.EmailAddress = txtEmail.Text.Trim();
                    user.Password = txtPassword.Text.Trim();

                    sqlCommand.CommandText = "sp_LoginUser";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@Event", "CheckEmail");
                    sqlCommand.Parameters.AddWithValue("@Email", user.EmailAddress);
                    sqlCommand.Parameters.AddWithValue("@Password", null);
                    int result = Convert.ToInt32(sqlCommand.ExecuteScalar().ToString());
                    if (result == 1)
                    {
                        CloseConnection();

                        //If Email exists then Checking the password associated with Email is correct or not
                        CreateConnection();
                        OpenConnection();
                        sqlCommand.CommandText = "sp_LoginUser";
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@Event", "CheckPassword");
                        sqlCommand.Parameters.AddWithValue("@Email", user.EmailAddress);
                        sqlCommand.Parameters.AddWithValue("@Password", user.Password);
                        SqlDataAdapter sda = new SqlDataAdapter(sqlCommand);
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        if (dt.Rows.Count != 0)
                        {
                            //If Password associated with Email is correct then stores the DataTable object in the Session
                            //and then redirect it to Dashboard Page
                            Session["dt"] = dt;
                            CloseConnection();
                            DisposeConnection();
                            ClearControls();
                            Response.Redirect("dashboard.aspx");
                        }
                        else
                        {
                            Response.Write("<script>alert('Password is incorrect');</script>");
                            CloseConnection();
                            DisposeConnection();
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('Email Address does not exist!');</script>");
                    }
                    DisposeConnection();
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }


        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            ClearControls();
        }
        public void ClearControls()
        {
            txtEmail.Text = "";
            txtPassword.Text = "";
        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("register.aspx");
        }
        protected void btnForget_Click(object sender, EventArgs e)
        {
            Response.Redirect("forget_password.aspx");

        }
    }
}