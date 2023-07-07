using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WAPIEstatus.Models.Context;
using WAPIEstatus.Models.Entities;

namespace WAPIEstatus.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EstatusController : ControllerBase
    {
        private readonly DemosContext _context;

        public EstatusController(DemosContext context)
        {
            _context = context;
        }

        // GET: api/Estatus
        [HttpGet]
        public async Task<ActionResult<IEnumerable<EstatusAlumno>>> GetEstatusAlumnos()
        {
          if (_context.EstatusAlumnos == null)
          {
              return NotFound();
          }
            return await _context.EstatusAlumnos.ToListAsync();
        }

        // GET: api/Estatus/5
        [HttpGet("{id}")]
        public async Task<ActionResult<EstatusAlumno>> GetEstatusAlumno(short id)
        {
          if (_context.EstatusAlumnos == null)
          {
              return NotFound();
          }
            var estatusAlumno = await _context.EstatusAlumnos.FindAsync(id);

            if (estatusAlumno == null)
            {
                return NotFound();
            }

            return estatusAlumno;
        }

        // PUT: api/Estatus/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutEstatusAlumno(short id, EstatusAlumno estatusAlumno)
        {
            if (id != estatusAlumno.Id)
            {
                return BadRequest();
            }

            _context.Entry(estatusAlumno).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!EstatusAlumnoExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Estatus
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<EstatusAlumno>> PostEstatusAlumno(EstatusAlumno estatusAlumno)
        {
          if (_context.EstatusAlumnos == null)
          {
              return Problem("Entity set 'DemosContext.EstatusAlumnos'  is null.");
          }
            _context.EstatusAlumnos.Add(estatusAlumno);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetEstatusAlumno", new { id = estatusAlumno.Id }, estatusAlumno);
        }

        // DELETE: api/Estatus/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEstatusAlumno(short id)
        {
            if (_context.EstatusAlumnos == null)
            {
                return NotFound();
            }
            var estatusAlumno = await _context.EstatusAlumnos.FindAsync(id);
            if (estatusAlumno == null)
            {
                return NotFound();
            }

            _context.EstatusAlumnos.Remove(estatusAlumno);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool EstatusAlumnoExists(short id)
        {
            return (_context.EstatusAlumnos?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
