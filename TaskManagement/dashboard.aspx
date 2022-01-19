<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="TaskManagement.dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                   <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                  <div class="container-fluid">
                    <a class="navbar-brand" href="#">Task Management</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
                      <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarScroll">
                      <ul class="navbar-nav navbar-nav-scroll NavElement" >
                         <li class="nav-item">
                             <asp:Image ID="ProfileImg" runat="server" Width="50" Height="50" />
                        </li>
                        <li class="nav-item">
                             <asp:Label ID="lblUserName" runat="server" CssClass="nav-link"></asp:Label>
                        </li>
                         <li class="nav-item">
                             <a href="dashboard.aspx" class="nav-link">Home</a>
                        </li>
                        <li class="nav-item dropdown">
                          <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Settings
                          </a>
                          <ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
                            <li><a class="dropdown-item" href="update_profile.aspx">Update Profile</a></li>
                            <li><a class="dropdown-item" href="change_password.aspx">Change Password</a></li>
                          </ul>
                        </li>
                        <li class="nav-item">
                            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-danger" OnClick="btnLogout_Click" ToolTip="Click here to Logout" />
                        </li>
                      </ul>
     
                    </div>
                  </div>
                </nav>
                </div>
            </div>
            <div class="row">
           <div class="col-lg-4 col-md-4 col-sm-4">
               <div class="row">
                   <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:Table runat="server" CssClass="table table-borderless InsertUpdate">
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="lblTaskName" runat="server" Text="Task Name"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>
                                     <asp:TextBox ID="txtTaskName" runat="server" placeholder="Enter the Task Name"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="rvfTaskName" runat="server" ValidationGroup="InsertUpdate" ErrorMessage="Task Name is required, cannot be blank" Text="*" ControlToValidate="txtTaskName" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexTaskName" runat="server" ValidationGroup="InsertUpdate" ErrorMessage="Task Name Should Contain Characters and Numbers only or should be greater than 3 and less than or equal 30 Characters" Text="*" ControlToValidate="txtTaskName" ValidationExpression="(?!^[0-9]*$)^([a-zA-Z\s]{3,100})$" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="2">
                                <asp:Button CssClass="btn btn-success" ID="btnInsert" runat="server" Text="Insert" OnClick="btnInsert_Click" ValidationGroup="InsertUpdate" ToolTip="Click here to Insert the record" />
                                <asp:Button CssClass="btn btn-success" ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" ValidationGroup="InsertUpdate" ToolTip="Click here to Update the record" />
                                &nbsp;&nbsp;
                                <asp:Button CssClass="btn btn-primary" ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" ToolTip="Click here to reset changes" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                   </div>
               </div>
               <div class="row">
                    <div class="col-lg-12 col-md-6 col-sm-6">
                        <asp:ValidationSummary CssClass="alert alert-danger" ID="ValidationSummary2" runat="server" ValidationGroup="InsertUpdate" ForeColor="Red" />
                   </div>
               </div>
           </div>
         <div class="col-lg-8 col-md-8 col-md-8">
               <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                          <h3 class="h4">Search</h3>
                          <asp:TextBox ID="txtSearch" runat="server" placeholder="Search Task" TextMode="Search"></asp:TextBox>
                          <asp:Button CssClass="btn btn-info" ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" ToolTip="Click here to search the task" />
                    </div>
                </div>
             <br />
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:GridView CssClass="table table-hover table-bordered table-light" ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="5" CellSpacing="5"
                        PageSize="5" OnRowEditing="grid_EditRow"  OnRowDeleting="grid_DeleteRow" OnPageIndexChanging="grid_PageIndexChanging" OnSorting="grid_Sorting" EmptyDataText="No Record found"> <%--OnRowCancelingEdit="grid_EditCancelRow"--%>
                            <Columns>
                                <asp:TemplateField HeaderText="Task Id" HeaderStyle-CssClass="hiddenId" ItemStyle-CssClass="hiddenId">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTaskId" runat="server" Text='<%# Eval("TaskId") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Task" SortExpression="Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTaskName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <asp:LinkButton CssClass="btn btn-success" ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" ToolTip="Click here to edit this record"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:LinkButton CssClass="btn btn-danger" ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" ToolTip="Click here to delete this record" OnClientClick="return confirm('Once deleted cannot be returned. Are you sure to delete?');"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                  </div>
                </div>
              
            </div>
       </div>
     
     </div>
    </form>
</body>
</html>
