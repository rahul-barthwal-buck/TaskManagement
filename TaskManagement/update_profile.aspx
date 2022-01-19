<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="update_profile.aspx.cs" Inherits="TaskManagement.update_profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <h1 class="display-3 d-flex justify-content-center">Register</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-6 col-sm-4">
                    <div class="d-flex justify-content-center">
                           <asp:Table runat="server" CssClass="table table-borderless RegisterTable">
                            <asp:TableRow>
                                <asp:TableCell ColumnSpan="2">
                                     <asp:Image ID="ImgPreview" CssClass="img-fluid ProfileUpload" ClientIDMode="Static" runat="server" Height="200px" Width="200px" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                               <asp:TableCell>
                                   <asp:Label ID="lblProfileImage" runat="server" Text="Profile Image"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:FileUpload ID="UpdatedProfileUpload" ClientIDMode="Static" runat="server" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                               <asp:TableCell>
                                   <asp:Label ID="lbFirstName" runat="server" Text="First Name"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtFirstName" runat="server" placeholder="Enter First Name"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvfFirstName" runat="server" ValidationGroup="UpdateProfile" ErrorMessage="First Name is required, cannot be blank" Text="*" ControlToValidate="txtFirstName" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexFirstName" runat="server" ValidationGroup="UpdateProfile" ErrorMessage="First Name Should Contain alphabtes only or should be greater than 3 and less than or equal 30 Characters" Text="*" ControlToValidate="txtFirstName" ValidationExpression="(?!^[0-9]*$)^([a-zA-Z]{3,30})$" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                             <asp:TableRow>
                               <asp:TableCell>
                                   <asp:Label ID="lblMiddleName" runat="server" Text="Middle Name"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtMiddleName" runat="server" placeholder="Enter Middle Name"></asp:TextBox>&nbsp;
                                    <asp:RegularExpressionValidator ID="regexMiddleName" runat="server" ValidationGroup="UpdateProfile" ErrorMessage="Middle Name Should Contain alphabtes only or should be greater than 3 and less than or equal 30 Characters" Text="*" ControlToValidate="txtMiddleName" ValidationExpression="(?!^[0-9]*$)^([a-zA-Z]{3,30})$" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                             <asp:TableRow>
                              <asp:TableCell>
                                   <asp:Label ID="lblLastName" runat="server" Text="Last Name"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtLastName" runat="server" placeholder="Enter Last Name"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvfLastName" runat="server" ValidationGroup="UpdateProfile" ErrorMessage="Last Name is required, cannot be blank" Text="*" ControlToValidate="txtLastName" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexLastName" runat="server" ValidationGroup="UpdateProfile" ErrorMessage="Last Name Should Contain alphabtes only or should be greater than 3 and less than or equal 30 Characters" Text="*" ControlToValidate="txtLastName" ValidationExpression="(?!^[0-9]*$)^([a-zA-Z]{3,30})$" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell ColumnSpan="2">
                                    <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" CssClass="btn btn-success" ValidationGroup="UpdateProfile" OnClick="btnUpdateProfile_Click" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="d-flex justify-content-center">
                        <asp:ValidationSummary ID="vsUpdateProfile" runat="server"  ValidationGroup="UpdateProfile" ForeColor="Red" CssClass="alert alert-danger RegisterValidation" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="d-flex justify-content-center">
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
