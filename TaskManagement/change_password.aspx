<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="change_password.aspx.cs" Inherits="TaskManagement.change_password" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change Password</title>
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
                    <h1 class="display-3 d-flex justify-content-center">Change Password</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-6 col-sm-4">
                    <div class="d-flex justify-content-center">
                           <asp:Table runat="server" CssClass="table table-borderless RegisterTable">
                             <asp:TableRow>
                                 <asp:TableCell>
                                   <asp:Label ID="lblOldPassword" runat="server" Text="Old Password"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" placeholder="Enter Old Password"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvfOldPassword" runat="server" ValidationGroup="ChangePwd" ErrorMessage="Old Password is required, cannot be blank" Text="*" ControlToValidate="txtOldPassword" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexOldPassword" runat="server" ValidationGroup="ChangePwd" ControlToValidate="txtOldPassword"  ErrorMessage=" Old Password should be minimum of 8 and maximum of 16 characters long and should contain at least one number, atleast one lowercase letter , atleast one uppercase letter" Text="*" Display="Dynamic" ValidationExpression="(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{8,16})$" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                 <asp:TableCell>
                                   <asp:Label ID="lblNewPassword" runat="server" Text="New Password"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="Enter New Password"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvfNewPassword" runat="server" ValidationGroup="ChangePwd" ErrorMessage="New Password is required, cannot be blank" Text="*" ControlToValidate="txtNewPassword" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexNewPassword" runat="server" ValidationGroup="ChangePwd" ControlToValidate="txtNewPassword"  ErrorMessage="New Password should be minimum of 8 and maximum of 16 characters long and should contain at least one number, atleast one lowercase letter , atleast one uppercase letter" Text="*" Display="Dynamic" ValidationExpression="(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{8,16})$" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                             <asp:TableRow>
                                 <asp:TableCell>
                                   <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Enter Confirm Password"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvftxtConfirmPassword" runat="server" ValidationGroup="ChangePwd" ErrorMessage=" Veify Password is required, cannot be blank" Text="*" ControlToValidate="txtConfirmPassword" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regextxtConfirmPassword" runat="server" ValidationGroup="ChangePwd" ControlToValidate="txtConfirmPassword"  ErrorMessage="Confirm Password should be minimum of 8 and maximum of 16 characters long and should contain at least one number, atleast one lowercase letter , atleast one uppercase letter" Text="*" Display="Dynamic" ValidationExpression="(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{8,16})$" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                     <asp:CompareValidator ID="passwordCompareValidator" runat="server" ErrorMessage="Confirm Password does not match" ValidationGroup="ChangePwd" ControlToValidate="txtNewPassword" ControlToCompare="txtConfirmPassword" ForeColor="Red" Text="*" SetFocusOnError="true" Display="Dynamic"></asp:CompareValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell ColumnSpan="2">
                                    <asp:Button ID="btnChangePassword" runat="server" Text="Change" CssClass="btn btn-success" ValidationGroup="ChangePwd" OnClick="btnChangePwd_Click" />&nbsp;
                                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-primary" OnClick="btnReset_Click" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="d-flex justify-content-center">
                        <asp:ValidationSummary ID="vsRegister" runat="server"  ValidationGroup="ChangePwd" ForeColor="Red" CssClass="alert alert-danger RegisterValidation" />
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
