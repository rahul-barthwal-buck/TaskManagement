<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reset_password.aspx.cs" Inherits="TaskManagement.reset_password" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset Password</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <h1 class="display-3 d-flex justify-content-center">Reset Password</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-6 col-sm-4">
                    <div class="d-flex justify-content-center">
                           <asp:Table runat="server" CssClass="table table-borderless RegisterTable">
                            <asp:TableRow>
                                 <asp:TableCell>
                                   <asp:Label ID="lblNewPassword" runat="server" Text="New Password"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="Enter New Password"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvfNewPassword" runat="server" ValidationGroup="Register" ErrorMessage="Password is required, cannot be blank" Text="*" ControlToValidate="txtNewPassword" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexNewPassword" runat="server" ValidationGroup="Register" ControlToValidate="txtNewPassword"  ErrorMessage="Password should be minimum of 8 and maximum of 16 characters long and should contain at least one number, atleast one lowercase letter , atleast one uppercase letter" Text="*" Display="Dynamic" ValidationExpression="(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{8,16})$" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                             <asp:TableRow>
                                 <asp:TableCell>
                                   <asp:Label ID="lblVerifyPassword" runat="server" Text="Verify Password"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtVerifyPassword" runat="server" TextMode="Password" placeholder="Enter New Password"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvfVerifyPassword" runat="server" ValidationGroup="Register" ErrorMessage=" Veify Password is required, cannot be blank" Text="*" ControlToValidate="txtVerifyPassword" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexVerifyPassword" runat="server" ValidationGroup="Register" ControlToValidate="txtVerifyPassword"  ErrorMessage=" Verify Password should be minimum of 8 and maximum of 16 characters long and should contain at least one number, atleast one lowercase letter , atleast one uppercase letter" Text="*" Display="Dynamic" ValidationExpression="(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{8,16})$" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                     <asp:CompareValidator ID="passwordCompareValidator" runat="server" ErrorMessage="Confirm Password does not match" ValidationGroup="Register" ControlToValidate="txtNewPassword" ControlToCompare="txtVerifyPassword" ForeColor="Red" Text="*" SetFocusOnError="true" Display="Dynamic"></asp:CompareValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell ColumnSpan="2">
                                    <asp:Button ID="btnResetPassword" runat="server" Text="Reset" CssClass="btn btn-success" ValidationGroup="Register" OnClick="btnResetPwd_Click" />&nbsp;
                                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-primary" OnClick="btnReset_Click" />&nbsp;
                                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-secondary" OnClick="btnLogin_Click" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="d-flex justify-content-center">
                        <asp:ValidationSummary ID="vsRegister" runat="server"  ValidationGroup="Register" ForeColor="Red" CssClass="alert alert-danger RegisterValidation" />
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
