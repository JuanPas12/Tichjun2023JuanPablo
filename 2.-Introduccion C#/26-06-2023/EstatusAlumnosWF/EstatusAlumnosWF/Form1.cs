using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace EstatusAlumnosWF
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        ADOEstatus ado = new ADOEstatus();

        private void Form1_Load(object sender, EventArgs e)
        {
            cmbEstatus.DataSource = ado.Consultar();
            cmbEstatus.DisplayMember = "nombre";
            cmbEstatus.ValueMember = "id";
            dgvEstatus.DataSource = ado.Consultar();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            pnlAccion.Visible = true;
            btnAgregar.Enabled = false;
            btnActualizar.Enabled = false;
            btnEliminar.Enabled = false;
            btnCRUD.Text = "Grabar";
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            int id = (int)cmbEstatus.SelectedValue;
            pnlAccion.Visible = true;
            btnAgregar.Enabled = false;
            btnActualizar.Enabled = false;
            btnEliminar.Enabled = false;
            btnCRUD.Text = "Guardar";
            txtNombre.Text = ado.Consultar(id).nombre;
            txtClave.Text = ado.Consultar(id).clave;
        }
        private void btnEliminar_Click(object sender, EventArgs e)
        {
            int id = (int)cmbEstatus.SelectedValue;
            pnlAccion.Visible = true;
            btnAgregar.Enabled = false;
            btnActualizar.Enabled = false;
            btnEliminar.Enabled = false;
            btnCRUD.Text = "Eliminar";
            txtNombre.Text = ado.Consultar(id).nombre;
            txtClave.Text = ado.Consultar(id).clave;
            txtNombre.Enabled = false;
            txtClave.Enabled = false;
        }

        private void btnCRUD_Click(object sender, EventArgs e)
        {
            int id = (int)cmbEstatus.SelectedValue;
            if (btnCRUD.Text == "Grabar")
            {
                Estatus eAgregar = new Estatus();
                eAgregar.clave = txtClave.Text;
                eAgregar.nombre = txtNombre.Text;
                ado.Agregar(eAgregar);
            }else if(btnCRUD.Text == "Guardar")
            {
                Estatus estatusU = new Estatus();
                estatusU.id = id;
                estatusU.nombre = txtNombre.Text;
                estatusU.clave = txtClave.Text;
                ado.Actualizar(estatusU);
            }else if(btnCRUD.Text == "Eliminar")
            {
                ado.Eliminar(id);
            }
            
            cmbEstatus.DataSource = ado.Consultar();
            cmbEstatus.DisplayMember = "nombre";
            cmbEstatus.ValueMember = "id";
            dgvEstatus.DataSource = ado.Consultar();
            pnlAccion.Visible = false;
            btnAgregar.Enabled = true;
            btnActualizar.Enabled = true;
            btnEliminar.Enabled = true;
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            txtNombre.Text = string.Empty;
            txtClave.Text = string.Empty;
            pnlAccion.Visible = false;
            btnAgregar.Enabled = true;
            btnActualizar.Enabled = true;
            btnEliminar.Enabled = true;
        }

        
    }
}
