using CodeChallenges.Models;
using CodeChallenges.Utils;
using System;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CodeChallenges.Controllers
{
    [Authorize( Roles = "Administrator" )]
    public class ChallengeController : Controller
    {
        private Entities db = new Entities();

        //
        // GET: /Challenge/

        public ActionResult Index()
        {
            Challenge[] challenges = db.Challenges.ToArray();

            for ( int i = 0; i < challenges.Count(); i++ )
            {
                challenges[ i ] = (Challenge)TimeZoneUtil.FromUTC( challenges[ i ] );
            }

            return View( challenges.ToList() );
        }

        //
        // GET: /Challenge/Details/5

        public ActionResult Details( int id = 0 )
        {
            Challenge challenge = db.Challenges.Find( id );
            if ( challenge == null )
            {
                return HttpNotFound();
            }

            challenge = (Challenge)TimeZoneUtil.FromUTC( challenge );

            return View( challenge );
        }

        //
        // GET: /Challenge/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Challenge/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create( Challenge challenge )
        {
            if ( ModelState.IsValid )
            {
                challenge = (Challenge)TimeZoneUtil.ToUTC( challenge );
                challenge.CreateDate = DateTime.UtcNow;

                challenge.Description = HttpUtility.HtmlDecode( challenge.Description );

                db.Challenges.Add( challenge );
                db.SaveChanges();
                return RedirectToAction( "Index" );
            }

            return View( challenge );
        }

        //
        // GET: /Challenge/Edit/5

        public ActionResult Edit( int id = 0 )
        {
            Challenge challenge = db.Challenges.Find( id );

            if ( challenge == null )
            {
                return HttpNotFound();
            }

            challenge = (Challenge)TimeZoneUtil.FromUTC( challenge );

            return View( challenge );
        }

        //
        // POST: /Challenge/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit( Challenge challenge )
        {
            if ( ModelState.IsValid )
            {
                challenge = (Challenge)TimeZoneUtil.ToUTC( challenge );
                challenge.Description = HttpUtility.HtmlDecode( challenge.Description );

                db.Entry( challenge ).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction( "Index" );
            }
            return View( challenge );
        }

        //
        // GET: /Challenge/Delete/5

        public ActionResult Delete( int id = 0 )
        {
            Challenge challenge = db.Challenges.Find( id );
            if ( challenge == null )
            {
                return HttpNotFound();
            }

            challenge = (Challenge)TimeZoneUtil.FromUTC( challenge );
            return View( challenge );
        }

        //
        // POST: /Challenge/Delete/5

        [HttpPost, ActionName( "Delete" )]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed( int id )
        {
            Challenge challenge = db.Challenges.Find( id );
            db.Challenges.Remove( challenge );
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