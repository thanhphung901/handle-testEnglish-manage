<%@ Page Title="" Language="C#" MasterPageFile="~/Design/Site.master" AutoEventWireup="true"
    CodeFile="baiTap.aspx.cs" Inherits="QuanLy_baiTap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link type="text/css" rel="Stylesheet" href="../Styles/Style_QL.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
    &nbsp;<asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <div class="title">Bước 1: TẠO BỘ ĐỀ</div>
            <table class="tbAdd" cellspacing="0">
        <tr>
            <td class="t1">Mã Bộ Đề</td>
            <td class="t2"><asp:TextBox runat="server" ID="txtMaBD"></asp:TextBox>
                <asp:Label ID="lblV1_1" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
            </td>
            <td class="t1">Tên Bộ Đề</td>
            <td class="t2"><asp:TextBox runat="server" ID="txtTenBD"></asp:TextBox>
                <asp:Label ID="lblV1_2" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="t1">Số lượng câu</td>
            <td class="t2"><asp:TextBox runat="server" ID="txtSoLuong" MaxLength="3" ></asp:TextBox>
                <asp:Label ID="lblV1_3" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
            </td>
            <td class="t1">Bài tập của Lớp</td>
            <td class="t2"><asp:DropDownList runat="server" ID="ddlMaLop"></asp:DropDownList>
                <asp:Label ID="lblV1_4" runat="server" ForeColor="Red" Text="*" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align:center">
                Lưu ý: Trước khi tạo Bộ Đề mới. Xin xem lại Bộ Đề nào có các Phần và Câu Hỏi 
                chưa nhập không?</td>
            <tr>
                <td colspan="4" style="text-align:center">
                    <asp:Button ID="btnBD" runat="server" onclick="btnBD_Click" 
                        Text="Tạo Bộ Đề Mới" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnView2" runat="server" onclick="btnView2_Click" 
                        Text="Xem các Phần của Bộ Đề" />
                    <br />
                    <asp:Label ID="lblMsgV1" runat="server" ForeColor="Blue"></asp:Label>
                </td>
            </tr>
        </tr>
        </table>
            <asp:GridView ID="gvwBoDe" runat="server" Style="margin: auto;" AllowPaging="True"
                OnPageIndexChanging="gvwBoDe_PageIndexChanging" 
                onrowcreated="gvwBoDe_RowCreated" onrowdeleting="gvwBoDe_RowDeleting">
                <Columns>
                    <asp:CommandField ButtonType="Button" DeleteText="Xóa" 
                        ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <div class="title">Bước 2: TẠO CÁC PHẦN CÂU HỎI</div>
            <marquee align="center" direction="left" height="30" scrollamount="3" width="100%" style="color:Red;">
               Bạn phải làm ít nhất 3 Phần trong 1 Bộ Đề. Và tối đa 5 phần!
            </marquee>
            <table style="margin: auto; width: 800px; border: 1px solid black; padding: 5px;">
                <tr>
                    <td colspan="2" style="text-align:center;">
                        <asp:DropDownList ID="ddlBoDeChuaLam" runat="server" Height="16px">
                        </asp:DropDownList>
                        <br />
                        <asp:Label ID="lblChuY" runat="server" ForeColor="Red"></asp:Label>
                        <br />
                        <hr style="width:400px; border:1px solid gray;"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:10%;">Phần 1:</td>
                    <td>
                        <asp:TextBox ID="txtP1" runat="server" Rows="1" TextMode="MultiLine" 
                            Width="600px" placeholder="Xin nhập nội dung ở đây!"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width:10%;"></td>
                    <td>
                        1) &lt;Tiêu đề câu hỏi 1 (Nếu có)&gt;<br /> &nbsp;&nbsp;&nbsp; a.&lt;Đáp án a&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b.&lt;Đáp án b&gt;<br /> 
                        &nbsp;&nbsp;&nbsp; c.&lt;Đáp án c&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d.&lt;Đáp án d&gt;<br /> 2)<br /> 3)<br /> ....</td>
                </tr>
                <tr>
                    <td style="width:10%;">Phần 2:</td>
                    <td>
                        <asp:TextBox ID="txtP2" runat="server" Rows="1" TextMode="MultiLine" 
                            Width="600px" placeholder="Xin nhập nội dung ở đây!"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width:10%;"></td>
                    <td>.....<br /></td>
                </tr>
                <tr>
                    <td style="width:10%;">Phần 3:</td>
                    <td>
                        <asp:TextBox ID="txtP3" runat="server" Rows="1" TextMode="MultiLine" 
                            Width="600px" placeholder="Xin nhập nội dung ở đây!"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width:10%;"></td>
                    <td>.....<br /></td>
                </tr>
                <tr><td colspan="2" style="text-align:center;">
                    <asp:Button ID="btnView1" runat="server" onclick="btnView1_Click" 
                        Text="Quay về bước 1" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnLuu" runat="server" onclick="btnLuu_Click" 
                        Text="Ghi vào Bộ Đề" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnView3" runat="server" onclick="btnView3_Click" 
                        Text="Tiếp tục bước 3" />
                    </td></tr>
            </table>
        </asp:View>
        <asp:View ID="View3" runat="server">
            <asp:Button ID="btnHomeQL" runat="server" Text="Quay về" 
                onclick="btnHomeQL_Click" />
            <div class="title">Bước 3: TẠO CÁC CÂU HỎI</div>
            <table style="margin: auto; width: 800px; border: 1px solid black; padding: 5px;">
                <tr>
                    <td colspan="2" style="text-align:center;">
                        <asp:DropDownList ID="ddlBoDe" runat="server" Height="16px" AutoPostBack="True" 
                            onselectedindexchanged="ddlBoDe_SelectedIndexChanged">
                        </asp:DropDownList>
                        <br />
                        Số câu đã nhập :<asp:Label ID="lblDem_CH" runat="server" Font-Bold="True" 
                            ForeColor="Blue"></asp:Label>
                        &nbsp;/ Tổng số câu:
                        <asp:Label ID="lblTong_CH" runat="server" Font-Bold="True" ForeColor="Blue"></asp:Label>
                        <br />
                        <hr style="width:400px; border:1px solid gray;"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:10%;">Phần 1:</td>
                    <td>
                        <asp:Label ID="lblP_V1" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width:10%;"></td>
                    <td>
                        <div>
                            <div style="float:left;width:60%;">
                                Câu hỏi (nếu có):
                                <asp:TextBox ID="txtAdd_CH1" runat="server" Width="200px"></asp:TextBox>
                                <br />
                                A.
                                <asp:TextBox ID="txtAdd_A1" runat="server"></asp:TextBox>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B.
                                <asp:TextBox ID="txtAdd_B1" runat="server"></asp:TextBox>
                                <br />
                                C.
                                <asp:TextBox ID="txtAdd_C1" runat="server"></asp:TextBox>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D.
                                <asp:TextBox ID="txtAdd_D1" runat="server"></asp:TextBox>
                                <br />
                                &nbsp;&nbsp;&nbsp;&nbsp; Đáp án
                                <asp:DropDownList ID="ddlDA_1" runat="server">
                                    <asp:ListItem>A</asp:ListItem>
                                    <asp:ListItem>B</asp:ListItem>
                                    <asp:ListItem>C</asp:ListItem>
                                    <asp:ListItem>D</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div style="float:right;width:39%;"><br /><br />
                                <asp:Button runat="server" 
                                    Text="Ghi vào Bộ Đề" ID="btnGhiP1" onclick="btnGhiP1_Click"></asp:Button></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="width:10%;">Phần 2:</td>
                    <td>
                        <asp:Label ID="lblP_V2" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width:10%;"></td>
                    <td>
                        <div>
                            <div style="float:left;width:60%;">
                                Câu hỏi (nếu có):
                                <asp:TextBox ID="txtAdd_CH2" runat="server" Width="200px"></asp:TextBox>
                                <br />
                                A.
                                <asp:TextBox ID="txtAdd_A2" runat="server"></asp:TextBox>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B.
                                <asp:TextBox ID="txtAdd_B2" runat="server"></asp:TextBox>
                                <br />
                                C.
                                <asp:TextBox ID="txtAdd_C2" runat="server"></asp:TextBox>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D.
                                <asp:TextBox ID="txtAdd_D2" runat="server"></asp:TextBox>
                                <br />
                                &nbsp;&nbsp;&nbsp;&nbsp; Đáp án
                                <asp:DropDownList ID="ddlDA_2" runat="server">
                                    <asp:ListItem>A</asp:ListItem>
                                    <asp:ListItem>B</asp:ListItem>
                                    <asp:ListItem>C</asp:ListItem>
                                    <asp:ListItem>D</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div style="float:right;width:39%;"><br /><br />
                                <asp:Button runat="server" 
                                    Text="Ghi vào Bộ Đề" ID="btnGhiP2" onclick="btnGhiP2_Click"></asp:Button></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="width:10%;">Phần 3:</td>
                    <td>
                        <asp:Label ID="lblP_V3" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width:10%;"></td>
                    <td>
                        <div>
                            <div style="float:left;width:60%;">
                                Câu hỏi (nếu có):
                                <asp:TextBox ID="txtAdd_CH3" runat="server" Width="200px"></asp:TextBox>
                                <br />
                                A.
                                <asp:TextBox ID="txtAdd_A3" runat="server"></asp:TextBox>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B.
                                <asp:TextBox ID="txtAdd_B3" runat="server"></asp:TextBox>
                                <br />
                                C.
                                <asp:TextBox ID="txtAdd_C3" runat="server"></asp:TextBox>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D.
                                <asp:TextBox ID="txtAdd_D3" runat="server"></asp:TextBox>
                                <br />
                                &nbsp;&nbsp;&nbsp;&nbsp; Đáp án
                                <asp:DropDownList ID="ddlDA_3" runat="server">
                                    <asp:ListItem>A</asp:ListItem>
                                    <asp:ListItem>B</asp:ListItem>
                                    <asp:ListItem>C</asp:ListItem>
                                    <asp:ListItem>D</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div style="float:right;width:39%;"><br /><br />
                                <asp:Button runat="server" 
                                    Text="Ghi vào Bộ Đề" ID="btnGhiP3" onclick="btnGhiP3_Click"></asp:Button></div>
                        </div>
                    </td>
                </tr>
    </table>
    <br />
        <table style="margin: auto; width: 1000px; border: 1px solid black; padding: 5px;border-radius:7px;-webkit-border-radius:7px;-o-border-radius:7px;;-moz-border-radius:7px;">
        <tr><td colspan="2" style="text-align:center;">
            <asp:Label ID="lblMain_BD" runat="server" Font-Bold="True" Font-Size="1.1em"></asp:Label>
            </td></tr>
            <tr>
                <td colspan="2"><asp:Label runat="server" ID="lblMain_P1" Font-Bold="True"></asp:Label></td>
            </tr>
            <tr>
                <td style="width:5%;"></td>
                <td>
                    <asp:GridView ID="gvwP1" runat="server" AutoGenerateColumns="False" 
                        Width="100%" onpageindexchanging="gvwP1_PageIndexChanging" 
                        onrowcancelingedit="gvwP1_RowCancelingEdit" 
                        onrowediting="gvwP1_RowEditing" onrowupdating="gvwP1_RowUpdating">
                        <Columns>
                            <asp:TemplateField HeaderText="Câu">
                                <ItemTemplate>
                                    <asp:Label ID="lblCH" runat="server" Text='<%# Bind("CAUHOI") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tên câu hỏi">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtND" runat="server" Text='<%# Bind("NOIDUNG") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblND" runat="server" Text='<%# Bind("NOIDUNG") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-A">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtA" runat="server" Text='<%# Bind("A") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblA" runat="server" Text='<%# Bind("A") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-B">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtB" runat="server" Text='<%# Bind("B") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblB" runat="server" Text='<%# Bind("B") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-C">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtC" runat="server" Text='<%# Bind("C") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblC" runat="server" Text='<%# Bind("C") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-D">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtD" runat="server" Text='<%# Bind("D") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblD" runat="server" Text='<%# Bind("D") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Đúng">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDapAn" runat="server" Text='<%# Bind("DAPAN") %>' 
                                        Width="30px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblDAPAN" runat="server" Text='<%# Bind("DAPAN") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="40px" ForeColor="Blue" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" EditText="Chỉnh sửa" 
                                ShowEditButton="True">
                            <ItemStyle Width="60px" />
                            </asp:CommandField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="2"><asp:Label runat="server" ID="lblMain_P2" Font-Bold="True"></asp:Label></td>
            </tr>
            <tr>
                <td style="width:5%;"></td>
                <td>
                    <asp:GridView ID="gvwP2" runat="server" AutoGenerateColumns="False" 
                        Width="100%" onpageindexchanging="gvwP2_PageIndexChanging" 
                        onrowcancelingedit="gvwP2_RowCancelingEdit" onrowediting="gvwP2_RowEditing" 
                        onrowupdating="gvwP2_RowUpdating">
                        <Columns>
                            <asp:TemplateField HeaderText="Câu">
                                <ItemTemplate>
                                    <asp:Label ID="lblCH0" runat="server" Text='<%# Bind("CAUHOI") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tên câu hỏi">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtND" runat="server" Text='<%# Bind("NOIDUNG") %>' 
                                        Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblND0" runat="server" Text='<%# Bind("NOIDUNG") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-A">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtA" runat="server" Text='<%# Bind("A") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblA0" runat="server" Text='<%# Bind("A") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-B">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtB" runat="server" Text='<%# Bind("B") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblB0" runat="server" Text='<%# Bind("B") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-C">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtC" runat="server" Text='<%# Bind("C") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblC0" runat="server" Text='<%# Bind("C") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-D">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtD" runat="server" Text='<%# Bind("D") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblD0" runat="server" Text='<%# Bind("D") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Đúng">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDapAn" runat="server" Text='<%# Bind("DAPAN") %>' 
                                        Width="30px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblDAPAN0" runat="server" Text='<%# Bind("DAPAN") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle ForeColor="Blue" HorizontalAlign="Center" Width="40px" />
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" EditText="Chỉnh sửa" 
                                ShowEditButton="True">
                            <ItemStyle Width="60px" />
                            </asp:CommandField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="2"><asp:Label runat="server" ID="lblMain_P3" Font-Bold="True"></asp:Label></td>
            </tr>
            <tr>
                <td style="width:5%;"></td>
                <td>
                    <asp:GridView ID="gvwP3" runat="server" AutoGenerateColumns="False" 
                        Width="100%" onpageindexchanging="gvwP3_PageIndexChanging" 
                        onrowcancelingedit="gvwP3_RowCancelingEdit" onrowediting="gvwP3_RowEditing" 
                        onrowupdating="gvwP3_RowUpdating">
                        <Columns>
                            <asp:TemplateField HeaderText="Câu">
                                <ItemTemplate>
                                    <asp:Label ID="lblCH0" runat="server" Text='<%# Bind("CAUHOI") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tên câu hỏi">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtND" runat="server" Text='<%# Bind("NOIDUNG") %>' 
                                        Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblND0" runat="server" Text='<%# Bind("NOIDUNG") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-A">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtA" runat="server" Text='<%# Bind("A") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblA0" runat="server" Text='<%# Bind("A") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-B">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtB" runat="server" Text='<%# Bind("B") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblB0" runat="server" Text='<%# Bind("B") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-C">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtC" runat="server" Text='<%# Bind("C") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblC0" runat="server" Text='<%# Bind("C") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ĐA-D">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtD" runat="server" Text='<%# Bind("D") %>' Width="97%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblD0" runat="server" Text='<%# Bind("D") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Đúng">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDapAn" runat="server" Text='<%# Bind("DAPAN") %>' 
                                        Width="30px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblDAPAN0" runat="server" Text='<%# Bind("DAPAN") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle ForeColor="Blue" HorizontalAlign="Center" Width="40px" />
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" EditText="Chỉnh sửa" 
                                ShowEditButton="True">
                            <ItemStyle Width="60px" />
                            </asp:CommandField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
        </asp:View>
    </asp:MultiView>
</asp:Content>
