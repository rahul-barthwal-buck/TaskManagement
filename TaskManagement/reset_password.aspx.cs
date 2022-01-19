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
    public partial class reset_password : System.Web.UI.Page
    {
        private string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TaskManagementConnectionString"].ConnectionString;
        private SqlCommand sqlCommand;
        private int Uid;
        private string GUId;
        protected void Page_Load(object sender, EventArgs e)
        {
            CheckGUID();
        }
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
        private void CheckGUID()
        {
            CreateConnection();
            OpenConnection();
            //Checking the unique Id which is generated at ForgetPassword page is null or not
            GUId = Request.QueryString["Uid"];
            if (GUId != null)
            {
                //If link is not null then fetching the forget password request of that particular user
                sqlCommand.CommandText = "sp_ForgetPassRequests";
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@Event", "CheckForgetPassRequestId");
                sqlCommand.Parameters.AddWithValue("@MyGUID", GUId);
                sqlCommand.Parameters.AddWithValue("@UserId", 0);
                SqlDataAdapter sda = new SqlDataAdapter(sqlCommand);
                DataTable dataTable = new DataTable();
                sda.Fill(dataTable);
                if (dataTable.Rows.Count != 0)
                {
                    //when value fetched then storing the user id of that particular forget request into the variable
                    Uid = Convert.ToInt32(dataTable.Rows[0][1]);
                }
                else
                {
                    //If null then whether the link is expired or invalid
                    lblMessage.Text = "Your password link is Invalid or Expired!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                Response.Redirect("forget_password.aspx");
            }
            CloseConnection();
            DisposeConnection();

        }
        protected void btnResetPwd_Click(object sender, EventArgs e)
        {

            try
            {
                if (Page.IsValid)
                {
                    //Changing the password of user 
                    //Here Uid is used whose value is set in CheckGUID method by this we get user Id 
                    CreateConnection();
                    OpenConnection();

                    //Storing the values coming from form into the User object
                    User user = new User();
                    user.Password = txtNewPassword.Text.Trim();
                    //Here Reseting the User password with new Password
                    sqlCommand.CommandText = "sp_ForgetPassword";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@Event", "ChangePassword");
                    sqlCommand.Parameters.AddWithValue("@NewPassword", user.Password);
                    sqlCommand.Parameters.AddWithValue("@Email", null);
                    sqlCommand.Parameters.AddWithValue("@UserId", Uid);

                    int resultChangePassword = Convert.ToInt32(sqlCommand.ExecuteNonQuery());
                    if (resultChangePassword > 0)
                    {
                        CloseConnection();

                        //When password changes now delete that forget password request
                        CreateConnection();
                        OpenConnection();
                        sqlCommand.CommandText = "sp_ForgetPassRequests";
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@Event", "DeleteForgetPassRequest");
                        sqlCommand.Parameters.AddWithValue("@MyGUID", null);
                        sqlCommand.Parameters.AddWithValue("@UserId", Uid);
                        int resultDeleteForgetRequest = Convert.ToInt32(sqlCommand.ExecuteNonQuery());
                        if (resultDeleteForgetRequest > 0)
                        {
                            lblMessage.Text = "Password Changed Successfully...";
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            ClearControls();
                        }
                        else
                        {
                            lblMessage.Text = "Failed to delete forget password request...";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }

                    }
                    else
                    {
                        CloseConnection();
                        DisposeConnection();
                        lblMessage.Text = "Failed!";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
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
            txtNewPassword.Text = "";
            txtVerifyPassword.Text = "";
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}