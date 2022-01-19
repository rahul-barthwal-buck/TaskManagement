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
    public partial class dashboard : System.Web.UI.Page
    {
        //Making Connection and Declaring required variables
        private string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TaskManagementConnectionString"].ConnectionString;
        private SqlCommand sqlCommand;
        private SqlDataAdapter sqlDataAdapter;
        private DataSet dataSet;
        private DataTable dt;
        private int userId;
        protected void Page_Load(object sender, EventArgs e)
        {

           //Checking wthether the Session with key name dt has Datatable object or not
            if(Session["dt"]!=null)
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
                //Binding the GirdView of Task
                BindTaskDetails();
            }
            btnUpdate.Visible = false;
            btnInsert.Visible = true;
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

        //Binding DataTable to GridView
        private void BindTaskDetails()
        {
            GridView1.DataSource = getDataTable();
            GridView1.DataBind();

        }

        //calling Stored procedure to get all data and then filling it with SqlDataAdapter and returning table for binding
        private DataTable getDataTable()
        {
            try
            {
                CreateConnection();
                OpenConnection();
                sqlCommand.CommandText = "sp_TaskDetails";
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@Event", "Select");
                sqlCommand.Parameters.AddWithValue("@UserId ", userId);
                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);
                CloseConnection();
                DisposeConnection();
                return dataSet.Tables[0];
               
            }
            catch (Exception ex)
            {
                throw ex;
            }


        }

        //To handle the Sorting event of GridView below event handler will called
        protected void grid_Sorting(object sender, GridViewSortEventArgs e)
        {

            string sortDirection = string.Empty;

            //SortDirection is actually  enum and this property available in GridViewSortEventArgs and it tell us whether to sort the data in Asc or Desc order
            //Here first we we check the direction from direction object of SortDirection property where we stored the direction in ViewState and then the sort direction
            if (direction == SortDirection.Ascending)
            {
                direction = SortDirection.Descending;
                sortDirection = "Desc";
            }
            else
            {
                direction = SortDirection.Ascending;
                sortDirection = "Asc";
            }
            //DataView provides different views of the data stored in a DataTable and Due to this view of data from DataTable can be customized and DataView can be used to sort, filter, search, insert, update the data in a DataTable.
            //DataView either take no argument in constructor or it will take DataTable table as argument.
            DataView dataView = new DataView(getDataTable());
            //SortExpression is the property available in GridViewSortEventArgs and due to this we can get the SortExpression value of GridView column which is clicked
            //Here I am using sort functionality of DataView for sorting the DataTable.
            dataView.Sort = e.SortExpression + " " + sortDirection;
            //Here storing the dataView as Object in the Session which helps in pagination when sorting applied.
            Session["SortedView"] = dataView;
            GridView1.DataSource = dataView;
            GridView1.DataBind();
        }

        //Below event handler will handle the paging into the GridView
        protected void grid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            //here firstly we check whether the Session SortedDataView is null or not.
            if (Session["SortedDataView"] != null)
            {
                //If not null then we can bind the DataView object present into the Session object into the GridView and according to sorted data pagination will work.
                GridView1.DataSource = Session["SortedDataView"];
                GridView1.DataBind();
            }
            else
            {
                //If null then bind it will the regular DataTable method which is of DataTable type
                GridView1.DataSource = getDataTable();
                GridView1.DataBind();
            }
        }

        //Here creating a property of SortDirection type which stores the direction value in ViewState
        public SortDirection direction
        {
            get
            {
                if (ViewState["dir"] == null)
                {
                    ViewState["dir"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["dir"];
            }
            set
            {
                ViewState["dir"] = value;
            }
        }

        //When user click Insert then this event will run
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    CreateConnection();
                    OpenConnection();

                    //Storing the valuescoming from form into Task object
                    Task task = new Task();
                    task.TaskName = txtTaskName.Text.Trim();

                    //Checking the task is already exist or not 
                    sqlCommand.CommandText = "sp_TaskDetails";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@Event", "CheckTask");
                    sqlCommand.Parameters.AddWithValue("@TaskName", task.TaskName);
                    sqlCommand.Parameters.AddWithValue("@UserId", userId);
                    int result = Convert.ToInt32(sqlCommand.ExecuteScalar().ToString());
                    if (result == 1)
                    {
                        Response.Write("<script>alert('Task Already exist! Enter Some other task');</script>");
                    }
                    else
                    {
                        CloseConnection();
                        //If not the insert the task
                        CreateConnection();
                        OpenConnection();
                        //Here Inserting the Task and then Binding the GridView of Task
                        sqlCommand.CommandText = "sp_TaskDetails";
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@Event", "Add");
                        sqlCommand.Parameters.AddWithValue("@TaskName", task.TaskName);
                        sqlCommand.Parameters.AddWithValue("@UserId", userId);
                        int resultInsert = Convert.ToInt32(sqlCommand.ExecuteNonQuery());
                        if (resultInsert > 0)
                        {
                            Response.Write("<script>alert('Task inserted successfully...');</script>");
                            BindTaskDetails();
                            ClearControls();
                        }
                        else
                        {
                            Response.Write("<script>alert('Failed to insert Task!');</script>");
                        }
                    }

                   
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        //protected void grid_EditCancelRow(object sender, GridViewCancelEditEventArgs e)
        //{
        //    GridView1.EditIndex = -1;
        //    BindProductDetails();
        //}

        //When user clicks Edit button in grid then this event set the values of that row in the form for editing the value
        protected void grid_EditRow(object sender, GridViewEditEventArgs e)
        {
            btnInsert.Visible = false;
            btnUpdate.Visible = true;

            int RowIndex = e.NewEditIndex;
            Label taskId = (Label)GridView1.Rows[RowIndex].FindControl("lblTaskId");
            Session["TaskId"] = taskId.Text;
            txtTaskName.Text = ((Label)GridView1.Rows[RowIndex].FindControl("lblTaskName")).Text.ToString();
           
            btnReset.Text = "Cancel";
            btnReset.CssClass = "btn btn-danger";

        }

        //This will clear all the fields of form and lblMessage
        public void ClearControls()
        {
            txtTaskName.Text = "";
        }

        //When user clicks on Update button then below event will peform and update the fields and then Bind the gridview again.
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    CreateConnection();
                    OpenConnection();

                    //Storing the value coming from form into Task object
                    Task task = new Task();
                    task.TaskName = txtTaskName.Text.Trim();
                    //Here Updating the values of Task and Then Binding the GridView of Task
                    sqlCommand.CommandText = "sp_TaskDetails";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@Event", "Update");
                    sqlCommand.Parameters.AddWithValue("@TaskName", task.TaskName);
                    sqlCommand.Parameters.AddWithValue("@TaskId",Session["TaskId"]);
                    sqlCommand.Parameters.AddWithValue("@UserId", userId);
                    int result = Convert.ToInt32(sqlCommand.ExecuteNonQuery());
                    if (result > 0)
                    {
                        Response.Write("<script>alert('Task updated successfully...');</script>");
                        GridView1.EditIndex = -1;
                        BindTaskDetails();
                        ClearControls();
                        btnReset.CssClass = "btn btn-primary";
                        btnReset.Text = "Reset";

                    }
                    else
                    {
                        Response.Write("<script>alert('Failed to update Task');</script>");
                    }
                    CloseConnection();
                    DisposeConnection();
                }
                else
                {
                    btnUpdate.Visible = true;
                    btnInsert.Visible = false;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //This event will call a function which clear all fields of the form when user clicks on Reset button
        protected void btnReset_Click(object sender, EventArgs e)
        {
            ClearControls();
            btnReset.Text = "Reset";
            btnReset.CssClass = "btn btn-primary";
        }

        //This event will perform when user clicks on Delete link Button of a particular row and checking the DataKeyNames property of Gridview and according to DataKeyNames which is set to Product_Id and delete record of that row and Bind the GridView again.
        protected void grid_DeleteRow(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                CreateConnection();
                OpenConnection();
                //Fetching the Id from lblTaskId which is hidden from user into a label varibale
                Label id = (Label)GridView1.Rows[e.RowIndex].FindControl("lblTaskId");
                sqlCommand.CommandText = "sp_TaskDetails";
                sqlCommand.Parameters.AddWithValue("@Event", "Delete");
                sqlCommand.Parameters.AddWithValue("@TaskId", Convert.ToInt32(id.Text));
                sqlCommand.Parameters.AddWithValue("@UserId", userId);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                int result = Convert.ToInt32(sqlCommand.ExecuteNonQuery());
                if (result > 0)
                {

                    Response.Write("<script>alert('Task deleted successfully...');</script>");
                    GridView1.EditIndex = -1;
                    BindTaskDetails();
                }
                else
                {
                    Response.Write("<script>alert('Failed to delete Task');</script>");
                    BindTaskDetails();
                }
                CloseConnection();
                DisposeConnection();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //This event will peform when user clicks on Search Button and it will find the search result and the Bind the gridview again according to the search result.
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                CreateConnection();
                OpenConnection();

                //Strong the value coming from Search box into the Task object
                Task task = new Task();
                task.TaskName = txtSearch.Text.Trim();
                //Here Searching the Task and The Binding the GridView of Task According to the Search result
                sqlCommand.CommandText = "sp_TaskDetails";
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@Event", "Search");
                sqlCommand.Parameters.AddWithValue("@TaskName", task.TaskName);
                sqlCommand.Parameters.AddWithValue("@UserId", userId);
                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);
                GridView1.DataSource = dataSet;
                GridView1.DataBind();
                CloseConnection();
                DisposeConnection();
                txtSearch.Text = "";
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
                Session["SortedView"] = null;
                Session["TaskId"] = null;
                userId = 0;
                Response.Redirect("login.aspx");
            }
        }

    }
}