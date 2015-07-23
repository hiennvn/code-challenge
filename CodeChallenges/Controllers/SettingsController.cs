using CodeChallenges.Models;
using System.Data;
using System.Linq;
using System.Web.Mvc;
using Telerik.Web.Mvc;

namespace CodeChallenges.Controllers
{
    [Authorize( Roles = "Administrator" )]
    public class SettingsController : Controller
    {
        private Entities db = new Entities();

        //
        // GET: /Settings/

        public ActionResult Index()
        {
            return View( db.Settings.ToList() );
        }

        //
        // GET: /Settings/Details/5

        public ActionResult Details( int id = 0 )
        {
            Setting setting = db.Settings.Find( id );
            if ( setting == null )
            {
                return HttpNotFound();
            }
            return View( setting );
        }

        //
        // GET: /Settings/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Settings/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create( Setting setting )
        {
            if ( ModelState.IsValid )
            {
                db.Settings.Add( setting );
                db.SaveChanges();
                return RedirectToAction( "Index" );
            }

            return View( setting );
        }

        //
        // GET: /Settings/Edit/5
        [GridAction]
        public ActionResult Edit( int id = 0 )
        {
            Setting setting = db.Settings.Find( id );
            if ( setting == null )
            {
                return HttpNotFound();
            }
            return View( setting );
        }

        //
        // POST: /Settings/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit( Setting setting )
        {
            if ( ModelState.IsValid )
            {
                db.Entry( setting ).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction( "Index" );
            }
            return View( setting );
        }

        //
        // GET: /Settings/Delete/5
        [GridAction]
        public ActionResult Delete( int id = 0 )
        {
            Setting setting = db.Settings.Find( id );
            if ( setting == null )
            {
                return HttpNotFound();
            }
            return View( setting );
        }

        //
        // POST: /Settings/Delete/5

        [HttpPost, ActionName( "Delete" )]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed( int id )
        {
            Setting setting = db.Settings.Find( id );
            db.Settings.Remove( setting );
            db.SaveChanges();
            return RedirectToAction( "Index" );
        }

        protected override void Dispose( bool disposing )
        {
            db.Dispose();
            base.Dispose( disposing );
        }
    }
}