<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="TaskManagement.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
     <form id="form1" runat="server">
         <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <h1 class="display-3 d-flex justify-content-center">Login</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-6 col-sm-4">
                    <div class="d-flex justify-content-center">
                           <asp:Table runat="server" CssClass="table table-borderless LoginTable">
                            <asp:TableRow>
                               <asp:TableCell>
                                   <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                   <asp:TextBox ID="txtEmail" ClientIDMode="Static" runat="server" placeholder="Enter Email Address"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="reqEmailValidator" runat="server" ValidationGroup="ForgetPwd" ErrorMessage="Email is required, can't be blank" ControlToValidate="txtEmail" ForeColor="Red" Text="*" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ErrorMessage="Email is not valid or Should be less than or equal to 38 Characters" ValidationGroup="ForgetPwd" ValidationExpression="^[a-zA-Z]{1}[a-zA-Z0-9.]{1,20}[@]{1}[a-zA-Z]{2,10}[.]{1}[a-zA-Z]{2,5}$" ControlToValidate="txtEmail" ForeColor="Red" Text="*" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                 <asp:TableCell>
                                   <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter Password"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvfPassword" runat="server" ValidationGroup="Login" ErrorMessage="Password is required, cannot be blank" Text="*" ControlToValidate="txtPassword" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexPassword" runat="server" ValidationGroup="Login" ControlToValidate="txtPassword"  ErrorMessage="Password should be minimum of 8 and maximum of 16 characters long and should contain at least one number, atleast one lowercase letter , atleast one uppercase letter" Text="*" ValidationExpression="(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{8,16})$" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell ColumnSpan="2">
                                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-success" ValidationGroup="Login" OnClick="btnLogin_Click" />&nbsp;
                                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-primary" OnClick="btnReset_Click" />&nbsp;
                                     <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-secondary" OnClick="btnRegister_Click" />&nbsp;
                                    <asp:Button ID="btnForgetPassword" runat="server" CssClass="btn btn-primary" OnClick="btnForget_Click" Text="Forget Password"/>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="d-flex justify-content-center">
                        <asp:ValidationSummary ID="vsLogin" runat="server"  ValidationGroup="Login" ForeColor="Red" CssClass="alert alert-danger LoginValidation" />
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
