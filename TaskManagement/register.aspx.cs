using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaskManagement
{
    public partial class register : System.Web.UI.Page
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
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    if(ProfileUpload.HasFile)
                    {
                        string fileExtension = Path.GetExtension(ProfileUpload.FileName);
                        if(fileExtension.ToLower()!= ".jpg" && fileExtension.ToLower()!=".jpeg" && fileExtension.ToLower()!=".png")
                        {
                            lblMessage.Text = "Only file with .jpg or .jpeg or png extension are allowed";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                        else
                        {
                            int fileSize = ProfileUpload.PostedFile.ContentLength;
                            if(fileSize>2097152)
                            {
                                lblMessage.Text = "Maximum file size 2MB exceeded";
                                lblMessage.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                //generating random number and attach it with Image so that every image stored in UserImages folder is unquie
                                Random rnd = new Random();
                                //Console.WriteLine(rnd.Next());
                                string imgNo = Convert.ToString(rnd.Next());
                                string imageFileName = Path.GetFileName(ProfileUpload.PostedFile.FileName);

                                User user = new User();
                                user.FirstName = txtFirstName.Text.Trim();
                                user.MiddleName = txtMiddleName.Text.Trim();
                                user.LastName = txtLastName.Text.Trim();
                                user.ProfileImage = "~/UserImages/"+imgNo+imageFileName;
                                user.EmailAddress = txtEmail.Text.Trim();
                                user.Password = txtPassword.Text.Trim();

                                //Check wthether the Email is already exist or not
                                //If exist the print message to the user
                                CreateConnection();
                                OpenConnection();
                                sqlCommand.CommandText = "sp_CheckEmail";
                                sqlCommand.CommandType = CommandType.StoredProcedure;
                                sqlCommand.Parameters.AddWithValue("@Email", user.EmailAddress);
                                int emailAlreadyExist = Convert.ToInt32(sqlCommand.ExecuteScalar().ToString());
                                if (emailAlreadyExist == 1)
                                {
                                    Response.Write("<script>alert('Email Already exists! Please try other Email');</script>");
                                    CloseConnection();
                                }
                                else
                                {
                                    CloseConnection();

                                    //Check wthether the Password is already exist or not
                                    //If exist the print message to the user
                                    CreateConnection();
                                    OpenConnection();
                                    sqlCommand.CommandText = "sp_CheckPassword";
                                    sqlCommand.CommandType = CommandType.StoredProcedure;
                                    sqlCommand.Parameters.AddWithValue("@Password", user.Password);
                                    int passwordAlreadyExist = Convert.ToInt32(sqlCommand.ExecuteScalar().ToString());
                                    if (passwordAlreadyExist == 1)
                                    {
                                        Response.Write("<script>alert('Password Already exists! Please try other Password');</script>");
                                        CloseConnection();
                                    }
                                    else
                                    {
                                        CloseConnection();
                                        //First checking whether the UserName exist or not
                                        CreateConnection();
                                        OpenConnection();

                                        sqlCommand.CommandText = "sp_RegisterUser";
                                        sqlCommand.CommandType = CommandType.StoredProcedure;
                                        sqlCommand.Parameters.AddWithValue("@FirstName", user.FirstName);
                                        sqlCommand.Parameters.AddWithValue("@MiddleName", user.MiddleName);
                                        sqlCommand.Parameters.AddWithValue("@LastName", user.LastName);
                                        sqlCommand.Parameters.AddWithValue("@ProfileImage", user.ProfileImage);
                                        sqlCommand.Parameters.AddWithValue("@Email", user.EmailAddress);
                                        sqlCommand.Parameters.AddWithValue("@Password", user.Password);
                                        int resultRegisterUser = Convert.ToInt32(sqlCommand.ExecuteNonQuery());
                                        if (resultRegisterUser > 0)
                                        {

                                            ProfileUpload.SaveAs(Server.MapPath("~/UserImages/")+imgNo+imageFileName);

                                            lblMessage.Text = "Registered Successfully...";
                                            lblMessage.ForeColor = System.Drawing.Color.Green;
                                            ClearControls();
                                        }
                                        else
                                        {
                                            lblMessage.Text = "Failed!";
                                            lblMessage.ForeColor = System.Drawing.Color.Red;
                                        }
                                        CloseConnection();
                                        DisposeConnection();
                                    }
                                }

                                CloseConnection();
                                DisposeConnection();
                            }
                        }
                    }
                    
                   
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }


        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            ClearControls();
        }
        public void ClearControls()
        {
            ProfileUpload.Attributes.Clear();
            txtFirstName.Text = "";
            txtMiddleName.Text = "";
            txtLastName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            txtPassword.Text = "";
        }
    }
}