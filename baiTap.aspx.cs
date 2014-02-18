using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QuanLy_baiTap : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Quyen"].ToString().Trim() == "1")
        {
            Clear_lbl();
            if (!IsPostBack)
            {
                Load_BoDeChuaLam();
                Load_dll_Lop();
                Load_BoDe();
            }
        }
        else
        {
            Response.Redirect("../dangNhap.aspx");
        }
    }
    private void Clear_lbl()
    {
        lblV1_1.Visible = lblV1_2.Visible = lblV1_3.Visible = lblV1_4.Visible = false;
        lblMsg.Text = lblChuY.Text = "";
    }
    private void Clear_Text()
    {
        txtMaBD.Text = txtTenBD.Text = txtSoLuong.Text = "";
    }
    private void Load_BoDe()
    {
        gvwBoDe.DataKeyNames = new string[] { "MABODE" };
        string lenh = "Select MABODE,TENBODE,SOLUONG,MALOP,NGAYTAO From BODE Order by NGAYTAO desc";
        gvwBoDe.DataSource = XLDL.DocBang(lenh);
        gvwBoDe.DataBind();
    }
    protected void gvwBoDe_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwBoDe.PageIndex = e.NewPageIndex;
        Load_BoDe();
    }
    private void Load_dll_Lop()
    {
        ddlMaLop.DataValueField = "MALOP";
        ddlMaLop.DataTextField = "TENLOP";
        string lenh = "Select * From LOP";
        ddlMaLop.DataSource = XLDL.DocBang(lenh);
        ddlMaLop.DataBind();
    }
    protected void btnBD_Click(object sender, EventArgs e)
    {
        if (txtMaBD.Text == "")
        { lblV1_1.Visible = true; lblMsg.Text = "Mã Bộ Đề không được để trống!"; }
        else if (txtTenBD.Text == "")
        { lblV1_2.Visible = true; lblMsg.Text = "Tên Bộ Đề không được để trống!"; }
        else if (txtSoLuong.Text == "")
        { lblV1_3.Visible = true; lblMsg.Text = "Số lượng câu không được để trống!"; }
        else if (ddlMaLop.SelectedIndex == 0)
        { lblV1_4.Visible = true; lblMsg.Text = "Xin chọn lớp!"; }
        else
        {
            string lenh = String.Format("Insert into BODE (MABODE,TENBODE,SOLUONG,MALOP,NGAYTAO) Values ('{0}',N'{1}','{2}','{3}',CAST(SYSDATETIME() as smalldatetime))"
                , txtMaBD.Text, txtTenBD.Text, txtSoLuong.Text, ddlMaLop.SelectedValue);
            if (XLDL.ThucHienLenh(lenh) > -1)
            {
                Load_BoDe();
                Clear_Text();
                lblMsg.Text = "Đã thêm thành công! Tiếp tục Bước 2!";
                MultiView1.ActiveViewIndex = 1;
                Load_BoDeChuaLam();
                btnLuu.Enabled = true;
            }
            else
            {
                lblMsg.Text = "Mã Đề này đã có!";
            }
        }
    }
    private void Load_BoDeChuaLam()
    {
        ddlBoDeChuaLam.DataValueField = "MABODE";
        ddlBoDeChuaLam.DataTextField = "TENBODE";
        string lenh = "Select * From BODE Where MABODE not in (Select MABODE From BODE_PHAN)";
        if (XLDL.DocBang(lenh).Rows.Count > 0)
        {
            ddlBoDeChuaLam.DataSource = XLDL.DocBang(lenh);
            ddlBoDeChuaLam.DataBind();
            btnBD.Enabled = false;
            lblMsgV1.Text = "Bạn đang có 1 Bộ Đề chưa nhập câu hỏi. Xin chọn Button(Tiếp tục nhưng không Tạo Mới)";
        }
        else
        {
            ddlBoDeChuaLam.DataSource = XLDL.DocBang(lenh);
            ddlBoDeChuaLam.DataBind();
            btnBD.Enabled = true;
            lblMsgV1.Text = "";
        }
    }
    protected void btnView2_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        Clear_Text();
        Load_BoDeChuaLam();
        if (ddlBoDeChuaLam.SelectedValue == null || ddlBoDeChuaLam.SelectedValue == "") { lblChuY.Text = "Chú ý: Xin tạo mới Bộ Đề trước khi nhập Câu Hỏi!"; btnLuu.Enabled = false; }
    }
    protected void btnView1_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }
    
    protected void btnLuu_Click(object sender, EventArgs e)
    {
        string p1 = txtP1.Text;
        string p2 = txtP2.Text;
        string p3 = txtP3.Text;
        if (p1 == "" || p2 == "" || p3 == "")
        { lblMsg.Text = "Bộ Đề tối thiểu 3 phần. Xin nhập đầy đủ Tiêu Đề 3 phần đầu."; }
        else
        {
            string lenh1 = String.Format("Insert into BODE_PHAN (MAPHAN,TENPHAN,MABODE) Values ('{0}',N'{1}','{2}')", ddlBoDeChuaLam.SelectedValue.ToString().Trim() + "-1", txtP1.Text, ddlBoDeChuaLam.SelectedValue.ToString().Trim());
            string lenh2 = String.Format("Insert into BODE_PHAN (MAPHAN,TENPHAN,MABODE) Values ('{0}',N'{1}','{2}')", ddlBoDeChuaLam.SelectedValue.ToString().Trim() + "-2", txtP2.Text, ddlBoDeChuaLam.SelectedValue.ToString().Trim());
            string lenh3 = String.Format("Insert into BODE_PHAN (MAPHAN,TENPHAN,MABODE) Values ('{0}',N'{1}','{2}')", ddlBoDeChuaLam.SelectedValue.ToString().Trim() + "-3", txtP3.Text, ddlBoDeChuaLam.SelectedValue.ToString().Trim());
            if (XLDL.ThucHienLenh(lenh1) > -1 && XLDL.ThucHienLenh(lenh2) > -1 && XLDL.ThucHienLenh(lenh3) > -1)
            {
                lblMsg.Text = "Đã lưu thành công! Tiếp tục bước 3!";
                MultiView1.ActiveViewIndex = 2;
                Load_BD();
                Load_CH();
            }
            else
            {
                lblMsg.Text = "Dữ liệu đã tồn tại! ";
            }
        }
    }

    /*----------------View3-------------------*/
    protected void btnView3_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 2;
        Load_BD();
        Load_CH();
    }
    private void Load_BD()
    {
        ddlBoDe.DataValueField = "MABODE";
        ddlBoDe.DataTextField = "TENBODE";
        string lenh = "Select * From BODE Order by NGAYTAO desc";
        ddlBoDe.DataSource = XLDL.DocBang(lenh);
        ddlBoDe.DataBind();
    }
    private void Load_P1(string P1)
    {
        gvwP1.DataKeyNames = new string[] { "CAUHOI" };//Dùng cái này để Update
        string lenh = String.Format("Select * From BODE_CAUHOI Where MAPHAN='{0}'", P1);
        gvwP1.DataSource = XLDL.DocBang(lenh);
        gvwP1.DataBind();
    }
    private void Load_P2(string P2)
    {
        gvwP2.DataKeyNames = new string[] { "CAUHOI" };
        string lenh = String.Format("Select * From BODE_CAUHOI Where MAPHAN='{0}'", P2);
        gvwP2.DataSource = XLDL.DocBang(lenh);
        gvwP2.DataBind();
    }
    private void Load_P3(string P3)
    {
        gvwP3.DataKeyNames = new string[] { "CAUHOI" };
        string lenh = String.Format("Select * From BODE_CAUHOI Where MAPHAN='{0}'", P3);
        gvwP3.DataSource = XLDL.DocBang(lenh);
        gvwP3.DataBind();
    }
    static public string MaPhan_1;
    static public string MaPhan_2;
    static public string MaPhan_3;
    private void Load_CH()
    {
        string lenh = String.Format("Select CAUHOI From BODE_PHAN p,BODE_CAUHOI ch Where p.MAPHAN=ch.MAPHAN and p.MABODE = '{0}'", ddlBoDe.SelectedValue.ToString().Trim());
        string lenh1 = String.Format("Select SOLUONG From BODE Where MABODE='{0}'", ddlBoDe.SelectedValue.ToString().Trim());
        string lenh2 = String.Format("Select * From BODE_PHAN Where MABODE='{0}'", ddlBoDe.SelectedValue.ToString().Trim());
        lblDem_CH.Text = XLDL.DocBang(lenh).Rows.Count.ToString();
        lblTong_CH.Text = XLDL.DocBang(lenh1).Rows[0][0].ToString();
        if (XLDL.DocBang(lenh2).Rows.Count > 0)
        {
            lblP_V1.Text = lblMain_P1.Text = XLDL.DocBang(lenh2).Rows[0][1].ToString();
            lblP_V2.Text = lblMain_P2.Text = XLDL.DocBang(lenh2).Rows[1][1].ToString();
            lblP_V3.Text = lblMain_P3.Text = XLDL.DocBang(lenh2).Rows[2][1].ToString();
            lblMain_BD.Text = ddlBoDe.SelectedItem.ToString().Trim();
            MaPhan_1 = XLDL.DocBang(lenh2).Rows[0][0].ToString().Trim();
            MaPhan_2 = XLDL.DocBang(lenh2).Rows[1][0].ToString().Trim();
            MaPhan_3 = XLDL.DocBang(lenh2).Rows[2][0].ToString().Trim();
            Load_P1(MaPhan_1);
            Load_P2(MaPhan_2);
            Load_P3(MaPhan_3);
        }
        else { MultiView1.ActiveViewIndex = 1; lblMsg.Text = "Có 1 Bộ Đề chưa nhập tiêu đề các phần!"; }
        //Chuyển Đếm/Tổng thành int
        int soCau = Convert.ToInt32(lblDem_CH.Text);
        int tongCau = Convert.ToInt32(lblTong_CH.Text);
        if (soCau >= tongCau)
        {
            btnGhiP1.Enabled = btnGhiP2.Enabled = btnGhiP3.Enabled = false;
        }
        else { btnGhiP1.Enabled = btnGhiP2.Enabled = btnGhiP3.Enabled = true; }
    }

    protected void ddlBoDe_SelectedIndexChanged(object sender, EventArgs e)
    {
        Load_CH();
    }
    /*---------------Load-GridView-P1---------------*/
    protected void gvwP1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwP1.PageIndex = e.NewPageIndex;
        Load_CH();
    }
    protected void gvwP1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvwP1.EditIndex = e.NewEditIndex;
        Load_CH();
    }
    protected void gvwP1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvwP1.EditIndex = -1;
        Load_CH();
    }
    protected void gvwP1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int i = e.RowIndex;
        string id = (string)gvwP1.DataKeys[i].Value.ToString();
        TextBox txtND = (TextBox)gvwP1.Rows[i].FindControl("txtND");
        TextBox txtA = (TextBox)gvwP1.Rows[i].FindControl("txtA");
        TextBox txtB = (TextBox)gvwP1.Rows[i].FindControl("txtB");
        TextBox txtC = (TextBox)gvwP1.Rows[i].FindControl("txtC");
        TextBox txtD = (TextBox)gvwP1.Rows[i].FindControl("txtD");
        TextBox txtDapAn = (TextBox)gvwP1.Rows[i].FindControl("txtDapAn");
        string lenh = String.Format("Update BODE_CAUHOI Set NOIDUNG=N'{0}', A=N'{1}', B=N'{2}', C=N'{3}', D=N'{4}', DAPAN=N'{5}' Where MAPHAN='{6}' and CAUHOI='{7}'"
            , txtND.Text, txtA.Text, txtB.Text, txtC.Text, txtD.Text, txtDapAn.Text, MaPhan_1, id);
        if (XLDL.ThucHienLenh(lenh) > -1)
        {
            gvwP1.EditIndex = -1;
            Load_CH();
            ClientScript.RegisterStartupScript(this.GetType(), "Thông báo", "alert('Cập nhật dữ liệu thành công!');", true);
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Thông báo", "alert('Cập nhật dữ liệu thất bại!');", true);
        }
    }
    /*---------------Load-GridView-P2---------------*/
    protected void gvwP2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwP2.PageIndex = e.NewPageIndex;
        Load_CH();
    }
    protected void gvwP2_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvwP2.EditIndex = e.NewEditIndex;
        Load_CH();
    }
    protected void gvwP2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvwP2.EditIndex = -1;
        Load_CH();
    }
    protected void gvwP2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int i = e.RowIndex;
        string id = (string)gvwP2.DataKeys[i].Value.ToString();
        TextBox txtND = (TextBox)gvwP2.Rows[i].FindControl("txtND");
        TextBox txtA = (TextBox)gvwP2.Rows[i].FindControl("txtA");
        TextBox txtB = (TextBox)gvwP2.Rows[i].FindControl("txtB");
        TextBox txtC = (TextBox)gvwP2.Rows[i].FindControl("txtC");
        TextBox txtD = (TextBox)gvwP2.Rows[i].FindControl("txtD");
        TextBox txtDapAn = (TextBox)gvwP2.Rows[i].FindControl("txtDapAn");
        string lenh = String.Format("Update BODE_CAUHOI Set NOIDUNG=N'{0}', A=N'{1}', B=N'{2}', C=N'{3}', D=N'{4}', DAPAN=N'{5}' Where MAPHAN='{6}' and CAUHOI='{7}'"
            , txtND.Text, txtA.Text, txtB.Text, txtC.Text, txtD.Text, txtDapAn.Text, MaPhan_2, id);
        if (XLDL.ThucHienLenh(lenh) > -1)
        {
            gvwP2.EditIndex = -1;
            Load_CH();
            ClientScript.RegisterStartupScript(this.GetType(), "Thông báo", "alert('Cập nhật dữ liệu thành công!');", true);
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Thông báo", "alert('Cập nhật dữ liệu thất bại!');", true);
        }
    }
    /*---------------Load-GridView-P3---------------*/
    protected void gvwP3_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvwP3.PageIndex = e.NewPageIndex;
        Load_CH();
    }
    protected void gvwP3_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvwP3.EditIndex = e.NewEditIndex;
        Load_CH();
    }
    protected void gvwP3_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvwP3.EditIndex = -1;
        Load_CH();
    }
    protected void gvwP3_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int i = e.RowIndex;
        string id = (string)gvwP3.DataKeys[i].Value.ToString();
        TextBox txtND = (TextBox)gvwP3.Rows[i].FindControl("txtND");
        TextBox txtA = (TextBox)gvwP3.Rows[i].FindControl("txtA");
        TextBox txtB = (TextBox)gvwP3.Rows[i].FindControl("txtB");
        TextBox txtC = (TextBox)gvwP3.Rows[i].FindControl("txtC");
        TextBox txtD = (TextBox)gvwP3.Rows[i].FindControl("txtD");
        TextBox txtDapAn = (TextBox)gvwP3.Rows[i].FindControl("txtDapAn");
        string lenh = String.Format("Update BODE_CAUHOI Set NOIDUNG=N'{0}', A=N'{1}', B=N'{2}', C=N'{3}', D=N'{4}', DAPAN=N'{5}' Where MAPHAN='{6}' and CAUHOI='{7}'"
            , txtND.Text, txtA.Text, txtB.Text, txtC.Text, txtD.Text, txtDapAn.Text, MaPhan_3, id);
        if (XLDL.ThucHienLenh(lenh) > -1)
        {
            gvwP3.EditIndex = -1;
            Load_CH();
            ClientScript.RegisterStartupScript(this.GetType(), "Thông báo", "alert('Cập nhật dữ liệu thành công!');", true);
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Thông báo", "alert('Cập nhật dữ liệu thất bại!');", true);
        }
    }
    /*----------Thực Hiện Add CH từng phần---------*/
    protected void btnGhiP1_Click(object sender, EventArgs e)
    {
        if (txtAdd_A1.Text == "" || txtAdd_B1.Text == "" || txtAdd_C1.Text == "" || txtAdd_D1.Text == "")
        {
            lblMsg.Text = "Xin nhập đầy đủ 4 câu trả lời!";
        }
        else
        {
            int soCau = Convert.ToInt32(lblDem_CH.Text);
            string lenh = String.Format("Insert into BODE_CAUHOI (MAPHAN,CAUHOI,NOIDUNG,A,B,C,D,DAPAN) Values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}')"
                ,MaPhan_1,soCau+1,txtAdd_CH1.Text,txtAdd_A1.Text,txtAdd_B1.Text,txtAdd_C1.Text,txtAdd_D1.Text,ddlDA_1.SelectedItem.ToString());
            if (XLDL.ThucHienLenh(lenh) > -1)
            {
                lblMsg.Text = "Đã thêm thành công!";
                Load_CH();
            }
            else
            {
                lblMsg.Text = "Thất bại! Xin xem lại dữ liệu!";
            }
        }
    }
    protected void btnGhiP2_Click(object sender, EventArgs e)
    {
        if (txtAdd_A2.Text == "" || txtAdd_B2.Text == "" || txtAdd_C2.Text == "" || txtAdd_D2.Text == "")
        {
            lblMsg.Text = "Xin nhập đầy đủ 4 câu trả lời!";
        }
        else
        {
            int soCau = Convert.ToInt32(lblDem_CH.Text);
            string lenh = String.Format("Insert into BODE_CAUHOI (MAPHAN,CAUHOI,NOIDUNG,A,B,C,D,DAPAN) Values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}')"
                , MaPhan_2, soCau + 1, txtAdd_CH2.Text, txtAdd_A2.Text, txtAdd_B2.Text, txtAdd_C2.Text, txtAdd_D2.Text, ddlDA_2.SelectedItem.ToString());
            if (XLDL.ThucHienLenh(lenh) > -1)
            {
                lblMsg.Text = "Đã thêm thành công!";
                Load_CH();
            }
            else
            {
                lblMsg.Text = "Thất bại! Xin xem lại dữ liệu!";
            }
        }
    }
    protected void btnGhiP3_Click(object sender, EventArgs e)
    {
        if (txtAdd_A3.Text == "" || txtAdd_B3.Text == "" || txtAdd_C3.Text == "" || txtAdd_D3.Text == "")
        {
            lblMsg.Text = "Xin nhập đầy đủ 4 câu trả lời!";
        }
        else
        {
            int soCau = Convert.ToInt32(lblDem_CH.Text);
            string lenh = String.Format("Insert into BODE_CAUHOI (MAPHAN,CAUHOI,NOIDUNG,A,B,C,D,DAPAN) Values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}')"
                , MaPhan_3, soCau + 1, txtAdd_CH3.Text, txtAdd_A3.Text, txtAdd_B3.Text, txtAdd_C3.Text, txtAdd_D3.Text, ddlDA_3.SelectedItem.ToString());
            if (XLDL.ThucHienLenh(lenh) > -1)
            {
                lblMsg.Text = "Đã thêm thành công!";
                Load_CH();
            }
            else
            {
                lblMsg.Text = "Thất bại! Xin xem lại dữ liệu!";
            }
        }
    }

    protected void btnHomeQL_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        Load_BoDe();
    }
    //------------Xóa tòan bộ 1 Bộ Đề
    protected void gvwBoDe_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow &&
            (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate))
        {
            var btnXoa = (Button)e.Row.Cells[0].Controls[0];
            btnXoa.OnClientClick = "if(!confirm('Bạn có muốn xóa toàn bộ Bộ Đề này kể cả các Phần và Câu Hỏi?')) return false;";
        }
    }
    protected void gvwBoDe_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int i = e.RowIndex;
        string MaPhan_1 = "", MaPhan_2 = ""; MaPhan_3 = "";
        string id = (string)gvwBoDe.DataKeys[i].Value;
        string lenh = String.Format("Select MAPHAN From BODE_PHAN Where MABODE='{0}'",id);
        if (XLDL.DocBang(lenh).Rows.Count > 0)
        {
            MaPhan_1 = XLDL.DocBang(lenh).Rows[0][0].ToString().Trim();
            MaPhan_2 = XLDL.DocBang(lenh).Rows[1][0].ToString().Trim();
            MaPhan_3 = XLDL.DocBang(lenh).Rows[2][0].ToString().Trim();
        }
        string lenhXoa = String.Format("Exec Delete_Bode N'{0}',N'{1}',N'{2}',N'{3}'", id, MaPhan_1, MaPhan_2, MaPhan_3);
        if (XLDL.ThucHienLenh(lenhXoa) > -1)
        {
            Load_BoDe();
            Clear_Text();
            lblMsg.Text = "Đã Xóa Bộ Đề thành công!";
        }
        else { lblMsg.Text = "Lỗi hệ thống!"; }
    }
}