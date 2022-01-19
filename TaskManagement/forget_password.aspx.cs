using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaskManagement
{
    public partial class foregt_password : System.Web.UI.Page
    {
        private string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TaskManagementConnectionString"].ConnectionString;
        private SqlCommand sqlCommand;
        private string myGUID;
        private int Uid;
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
        protected void btnSendLink_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    //First checking whether the Email exist or not
                    CreateConnection();
                    OpenConnection();

                    //Storing the values coming from form into the User object
                    User user = new User();
                    user.EmailAddress = txtEmail.Text.Trim();
                    //Here First check whether the Email entered is exist or not
                    //if not exist then print message to the user
                    sqlCommand.CommandText = "sp_ForgetPassword";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@Event", "CheckEmail");
                    sqlCommand.Parameters.AddWithValue("@Email", user.EmailAddress);
                    sqlCommand.Parameters.AddWithValue("@NewPassword", null);
                    sqlCommand.Parameters.AddWithValue("@UserId", 0);
                    SqlDataAdapter sda = new SqlDataAdapter(sqlCommand);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    if (dt.Rows.Count != 0)
                    {
                        //If mail exists then
                        //Generating a unique Id by GuId for unique request 
                        myGUID = Guid.NewGuid().ToString();
                        //When checking email we need user id to for which forget password request is generated
                        Uid = Convert.ToInt32(dt.Rows[0][0]);
                        CloseConnection();

                        //Storing the forget password request
                        CreateConnection();
                        OpenConnection();
                        sqlCommand.CommandText = "sp_ForgetPassRequests";
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@Event", "InsertForgetPassRequest");
                        sqlCommand.Parameters.AddWithValue("@MyGUID", myGUID);
                        sqlCommand.Parameters.AddWithValue("@UserId", Uid);
                        int resultForgetPassRequest = Convert.ToInt32(sqlCommand.ExecuteNonQuery());
                        if (resultForgetPassRequest > 0)
                        {
                            //If request stored then sending Reset link to user email address
                            try
                            {
                                //Stored the fetched Email and UserName of the particular user
                                String toEmailAddress = dt.Rows[0][5].ToString();
                                String userName = dt.Rows[0][1].ToString() + " "+dt.Rows[0][2].ToString()+ " "+ dt.Rows[0][3].ToString();

                                //Setting mail body with reset password link which contain unique GUId which is then fetched in the ResetPassword page
                                String mailBody = "Hi " + userName + ",<br/>Click the link below to reset your password<br/><br/> https://localhost:44308/reset_password.aspx?Uid=" + myGUID;

                                //MailMessage is a class which provide functionality of message that we need to send through SMTPClient.
                                MailMessage mailMessage = new MailMessage("rahulbarthwal442@gmail.com", toEmailAddress);

                                //It get or set the mail body
                                mailMessage.Body = mailBody;

                                //isBodyHtml sets whether the mail body is html or not
                                mailMessage.IsBodyHtml = true;

                                //It get or sets the subject line of the email
                                mailMessage.Subject = "Task Management Reset Password";

                                //It get or sets the priority of the Email
                                //There are three priority types:
                                //1.High
                                //2.Low
                                //3.Normal (by defualt)
                                mailMessage.Priority = MailPriority.High;

                                //SMTPClient allows us to send email using Simple Mail Transfer Protocol(smtp)
                                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);

                                //It tells how the sended mail will be handled
                                //There are threee delivery methods
                                //1. Network
                                //2. PickupDirectoryFromIis
                                //3. SpecifiedPickupDirectory
                                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;

                                smtp.UseDefaultCredentials = false;
                                //it authenticate the credentials used by sender
                                smtp.Credentials = new NetworkCredential()
                                {
                                    UserName = "rahulbarthwal442@gmail.com",
                                    Password = "bajkduuwbdlumuik"
                                };

                                //Enabling Secure socket layer true
                                smtp.EnableSsl = true;
                                smtp.Send(mailMessage);
                                lblMessage.Text = "Reset link send...Check your email.";
                                lblMessage.ForeColor = System.Drawing.Color.Green;
                                txtEmail.Text = "";
                            }
                            catch (Exception ex)
                            {
                                throw ex;
                            }
                        }
                        else
                        {
                            Response.Write("<script>alert('Forget pass request not inserted');</script>");
                            // lblMessage.Text = "Forget pass request not inserted...";
                            // lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('Email not registered!');</script>");
                        // lblMessage.Text = "Email not registered!";
                        // lblMessage.ForeColor = System.Drawing.Color.Red;
                    }

                    CloseConnection();
                    DisposeConnection();
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
    }
}