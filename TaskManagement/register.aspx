<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="TaskManagement.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css" />
    <script type="text/javascript">
        function ImgPrev(input) {
            if (input.files[0]) {
                var uploadImage = new FileReader();
                uploadImage.onload = function (displaying) {
                    $("#ImgPreview").attr('src', displaying.target.result);
                }
                uploadImage.readAsDataURL(input.files[0]);
            }
        }
    </script>
</head>
<body>
   <form id="form1" runat="server">
        <div class="container">
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
                                   <asp:Label ID="Label3" runat="server" Text="Profile Image"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:FileUpload ID="ProfileUpload" ClientIDMode="Static" runat="server" OnChange="ImgPrev(this)" />&nbsp;&nbsp;
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                               <asp:TableCell>
                                   <asp:Label ID="lbFirstName" runat="server" Text="First Name"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtFirstName" runat="server" placeholder="Enter First Name"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvfFirstName" runat="server" ValidationGroup="Register" ErrorMessage="First Name is required, cannot be blank" Text="*" ControlToValidate="txtFirstName" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexFirstName" runat="server" ValidationGroup="Register" ErrorMessage="First Name Should Contain alphabtes only or should be greater than 3 and less than or equal 30 Characters" Text="*" ControlToValidate="txtFirstName" ValidationExpression="(?!^[0-9]*$)^([a-zA-Z]{3,30})$" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                             <asp:TableRow>
                               <asp:TableCell>
                                   <asp:Label ID="lblMiddleName" runat="server" Text="Middle Name"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtMiddleName" runat="server" placeholder="Enter Middle Name"></asp:TextBox>&nbsp;
                                    <asp:RegularExpressionValidator ID="regexMiddleName" runat="server" ValidationGroup="Register" ErrorMessage="Middle Name Should Contain alphabtes only or should be greater than 3 and less than or equal 30 Characters" Text="*" ControlToValidate="txtMiddleName" ValidationExpression="(?!^[0-9]*$)^([a-zA-Z]{3,30})$" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                             <asp:TableRow>
                              <asp:TableCell>
                                   <asp:Label ID="lblLastName" runat="server" Text="Last Name"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtLastName" runat="server" placeholder="Enter Last Name"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvfLastName" runat="server" ValidationGroup="Register" ErrorMessage="Last Name is required, cannot be blank" Text="*" ControlToValidate="txtLastName" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexLastName" runat="server" ValidationGroup="Register" ErrorMessage="Last Name Should Contain alphabtes only or should be greater than 3 and less than or equal 30 Characters" Text="*" ControlToValidate="txtLastName" ValidationExpression="(?!^[0-9]*$)^([a-zA-Z]{3,30})$" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>

                            <asp:TableRow>
                                <asp:TableCell><asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label></asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtEmail" ClientIDMode="Static" runat="server" placeholder="Enter Email"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="reqEmailValidator" runat="server" ValidationGroup="Register" ErrorMessage="Email is required, can't be blank" ControlToValidate="txtEmail" ForeColor="Red" Text="*" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ErrorMessage="Email is not valid or Should be less than or equal to 38 Characters" ValidationGroup="Register" ValidationExpression="^[a-zA-Z]{1}[a-zA-Z0-9.]{1,20}[@]{1}[a-zA-Z]{2,10}[.]{1}[a-zA-Z]{2,5}$" ControlToValidate="txtEmail" ForeColor="Red" Text="*" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                 <asp:TableCell>
                                   <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter Password"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvfPassword" runat="server" ValidationGroup="Register" ErrorMessage="Password is required, cannot be blank" Text="*" ControlToValidate="txtPassword" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexPassword" runat="server" ValidationGroup="Register" ControlToValidate="txtPassword"  ErrorMessage="Password should be minimum of 8 and maximum of 16 characters long and should contain at least one number, atleast one lowercase letter , atleast one uppercase letter" Text="*" Display="Dynamic" ValidationExpression="(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{8,16})$" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                             <asp:TableRow>
                                 <asp:TableCell>
                                   <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password"></asp:Label>
                               </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Enter New Password"></asp:TextBox>&nbsp;
                                     <asp:RequiredFieldValidator ID="rvfVerifyPassword" runat="server" ValidationGroup="Register" ErrorMessage="Confirm Password is required, cannot be blank" Text="*" ControlToValidate="txtConfirmPassword" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="regexVerifyPassword" runat="server" ValidationGroup="Register" ControlToValidate="txtConfirmPassword"  ErrorMessage=" Confirm Password should be minimum of 8 and maximum of 16 characters long and should contain at least one number, atleast one lowercase letter , atleast one uppercase letter" Text="*" Display="Dynamic" ValidationExpression="(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{8,16})$" ForeColor="Red" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                     <asp:CompareValidator ID="passwordCompareValidator" runat="server" ErrorMessage="Confirm Password does not match" ValidationGroup="Register" ControlToValidate="txtPassword" ControlToCompare="txtConfirmPassword" ForeColor="Red" Text="*" SetFocusOnError="true" Display="Dynamic"></asp:CompareValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell ColumnSpan="2">
                                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-success" ValidationGroup="Register" OnClick="btnRegister_Click" />&nbsp;
                                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-primary" OnClick="btnReset_Click" />&nbsp;
                                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-secondary" OnClick="btnLogin_Click" />&nbsp;
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
