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
    public partial class change_password : System.Web.UI.Page
    {
        private string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TaskManagementConnectionString"].ConnectionString;
        private SqlCommand sqlCommand;
        private DataTable dt;
        private int userId;
        protected void Page_Load(object sender, EventArgs e)
        {
            //Checking whether the Session[dt] which stores the Datatable object is empty or not
            if (Session["dt"] != null)
            {
                dt = (DataTable)Session["dt"];
                ProfileImg.ImageUrl = (string)dt.Rows[0][4];
                lblUserName.Text = "Welcome " + dt.Rows[0][5];
                userId = (int)dt.Rows[0][0];

            }
            else
            {
                Response.Redirect("login.aspx");
            }
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
        public void ClearControls()
        {
            txtOldPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
        }
        protected void btnChangePwd_Click(object sender, EventArgs e)
        {
            try
            {
                if(Page.IsValid)
                {
                    CreateConnection();
                    OpenConnection();

                    //Stroing values coming from form into user object
                    User user = new User();
                    user.Password = txtOldPassword.Text.Trim();
                    //Checking the Old password that user entered is correct or not
                    sqlCommand.CommandText = "sp_UserPassword";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@Event", "CheckPassword");
                    sqlCommand.Parameters.AddWithValue("@OldPassword", user.Password);
                    sqlCommand.Parameters.AddWithValue("@NewPassword", null);
                    sqlCommand.Parameters.AddWithValue("@UserId", userId);
                    int resultCheckPassword = Convert.ToInt32(sqlCommand.ExecuteScalar().ToString());
                    if (resultCheckPassword == 1)
                    {
                        CloseConnection();

                        User userObj = new User();
                        userObj.Password = txtNewPassword.Text.Trim();

                        //Check wthether the password is already exist or not
                        //If exist the print message to the user
                        CreateConnection();
                        OpenConnection();
                        sqlCommand.CommandText = "sp_CheckPassword";
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@Password", userObj.Password);
                        int resultAlreadyExist = Convert.ToInt32(sqlCommand.ExecuteScalar().ToString());
                        if (resultAlreadyExist == 1)
                        {
                            Response.Write("<script>alert('Password Already exists! Please try other password');</script>");
                            CloseConnection();
                        }
                        else
                        {
                            CloseConnection();

                            //If old Password is correct and user entered different password which does not exists
                            //then below code will Update the Old password with the New Password
                            CreateConnection();
                            OpenConnection();

                            sqlCommand.CommandText = "sp_UserPassword";
                            sqlCommand.CommandType = CommandType.StoredProcedure;
                            sqlCommand.Parameters.AddWithValue("@Event", "ChangePassword");
                            sqlCommand.Parameters.AddWithValue("@OldPassword", null);
                            sqlCommand.Parameters.AddWithValue("@NewPassword", userObj.Password);
                            sqlCommand.Parameters.AddWithValue("@UserId", userId);
                            int resultChangePwd = Convert.ToInt32(sqlCommand.ExecuteNonQuery());
                            if (resultChangePwd > 0)
                            {
                                Response.Write("<script>alert('Password Changed successfully...');</script>");
                                CloseConnection();
                                DisposeConnection();
                                ClearControls();
                            }
                            else
                            {
                                Response.Write("<script>alert('Failed to Change Password');</script>");
                            }
                        }
                      
                
                    }
                    else
                    {
                        Response.Write("<script>alert('Old Password is not correct');</script>");
                        CloseConnection();
                        DisposeConnection();
                    }
                    CloseConnection();
                    DisposeConnection();
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ClearControls();
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            //First checking whether the Session with Key dt is Null or not
            if (Session["dt"] != null)
            {
                //If not null then null the value in Session with key dt
               //then redirect to login page
                Session["dt"] = null;
                userId = 0;
                Response.Redirect("login.aspx");
            }
        }
    }
}