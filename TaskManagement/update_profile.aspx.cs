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
    public partial class update_profile : System.Web.UI.Page
    {
        private string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TaskManagementConnectionString"].ConnectionString;
        private SqlCommand sqlCommand;
        private DataTable dt;
        private int userId;
        protected void Page_Load(object sender, EventArgs e)
        {
            //Checking wthether the Session with key dt has Datatable as value or not
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
            if (!Page.IsPostBack)
            {
                //Binding the data and displayed it into the updation form
                BindUserDetails();
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

        private void BindUserDetails()
        {
            CreateConnection();
            OpenConnection();
            //fetching the user details and the returning the table 
            sqlCommand.CommandText = "sp_UserProfile";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@Event", "FetchUserDetails");
            sqlCommand.Parameters.AddWithValue("@UserId", userId);
            SqlDataAdapter sda = new SqlDataAdapter(sqlCommand);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count != 0)
            {
                txtFirstName.Text = (string)dt.Rows[0][0];
                txtMiddleName.Text = (string)dt.Rows[0][1];
                txtLastName.Text = (string)dt.Rows[0][2];
                ImgPreview.ImageUrl = (string)dt.Rows[0][3];

                //Storing the Old File path into the Session for deletion of Image file from the UserImages folder
                Session["oldImageFilePath"] = (string)dt.Rows[0][3];

            }
            else
            {
                Response.Write("<script>alert('Unable to fetch User Data');</script>");
                CloseConnection();
                DisposeConnection();
            }
        }
        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            try
            {
                    if (Page.IsValid)
                    {
                        //HasFile is a boolean property of FileUpload Control which checks whether the FileUpload control has file or not. If HasFile Then return true otherwise return false
                        if (UpdatedProfileUpload.HasFile)
                        {
                            //Path is present in System.IO Class
                            //Its method GetExtension will fetch the Extension of provided file
                            //Here fetching extension fo file from Image so that only Image with specific extension will we saved
                            string fileExtension = Path.GetExtension(UpdatedProfileUpload.FileName);
                            if (fileExtension.ToLower() != ".jpg" && fileExtension.ToLower() != ".jpeg" && fileExtension.ToLower() != ".png")
                            {
                                lblMessage.Text = "Only file with .jpg or .jpeg or png extension are allowed";
                                lblMessage.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                //ContenteLength will return the length of the given file in bytes
                                int fileSize = UpdatedProfileUpload.PostedFile.ContentLength;
                                //Here checking whether the file does not exceed 2 MB
                                if (fileSize > 2097152)
                                {
                                    lblMessage.Text = "Maximum file size 2MB exceeded";
                                    lblMessage.ForeColor = System.Drawing.Color.Red;
                                }
                                else
                                {
                               
                                    CreateConnection();
                                    OpenConnection();

                                    //GetFileName method of File will fetching the Filename from whole file
                                    //Storing the new path of image into the string for stroing purpose
                                    string imageFileName = Path.GetFileName(UpdatedProfileUpload.PostedFile.FileName);

                                    //generating random number and attach it with Image so that every image stored in UserImages folder is unquie
                                    Random rnd = new Random();
                                    //Console.WriteLine(rnd.Next());
                                    string imgNo = Convert.ToString(rnd.Next());
                                    //Storing the values coming from updation profile form into the User object
                                    User user = new User();
                                    user.FirstName = txtFirstName.Text.Trim();
                                    user.MiddleName = txtMiddleName.Text.Trim();
                                    user.LastName = txtLastName.Text.Trim();
                                    user.ProfileImage = "~/UserImages/"+imgNo+imageFileName;

                                    //Here updating the User profile
                                    sqlCommand.CommandText = "sp_UserProfile";
                                    sqlCommand.CommandType = CommandType.StoredProcedure;
                                    sqlCommand.Parameters.AddWithValue("@Event", "UpdateUserDetails");
                                    sqlCommand.Parameters.AddWithValue("@FirstName", user.FirstName);
                                    sqlCommand.Parameters.AddWithValue("@MiddleName", user.MiddleName);
                                    sqlCommand.Parameters.AddWithValue("@LastName", user.LastName);
                                    sqlCommand.Parameters.AddWithValue("@ProfileImage", user.ProfileImage);
                                    sqlCommand.Parameters.AddWithValue("@UserId", userId);
                                    int result = Convert.ToInt32(sqlCommand.ExecuteNonQuery());
                                    if (result > 0)
                                    {
                                        //Server.MapPath will return the physical path for a given virtual path
                                        //If Profile updating into the database table then deleting the Old file by File which present in System.IO
                                        string fileImagePath = Server.MapPath((string)Session["oldImageFilePath"]);
                                        if(File.Exists(fileImagePath))
                                        {
                                            File.Delete(fileImagePath);
                                        }

                                        //SaveAs property of FileUpload control will save the file into the specified path
                                        UpdatedProfileUpload.SaveAs(Server.MapPath("~/UserImages/")+imgNo+imageFileName);
                                        lblMessage.Text = "User Profile Updated Successfully...";
                                        lblMessage.ForeColor = System.Drawing.Color.Green;
                                    }
                                    else
                                    {
                                        lblMessage.Text = "Failed to update profile!";
                                        lblMessage.ForeColor = System.Drawing.Color.Red;
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

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            //First checking whether the Session with Key dt is Null or not
            if (Session["dt"] != null)
            {
                //If not null then null the value in Session with key dt
                //then redirect to login page
                Session["dt"] = null;
                userId = 0;
                Session["oldImageFilePath"] = null;
                Response.Redirect("login.aspx");
            }
        }
    }
}