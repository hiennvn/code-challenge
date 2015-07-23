using CodeChallenges.Models;
using System;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CodeChallenges.Controllers
{
    [Authorize( Roles = "Administrator" )]
    public class ProblemController : Controller
    {
        private Entities db = new Entities();

        //
        // GET: /Problem/

        public ActionResult Index()
        {
            var problems = db.Problems.Include( p => p.Challenge );
            return View( problems.ToList() );
        }

        //
        // GET: /Problem/Details/5

        public ActionResult Details( int id = 0 )
        {
            Problem problem = db.Problems.Find( id );
            if ( problem == null )
            {
                return HttpNotFound();
            }
            return View( problem );
        }

        //
        // GET: /Problem/Create

        public ActionResult Create()
        {
            ViewBag.ChallengeId = new SelectList( db.Challenges, "Id", "Name" );
            return View();
        }

        //
        // POST: /Problem/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create( Problem problem )
        {
            if ( ModelState.IsValid )
            {
                problem.CreateDate = DateTime.UtcNow;
                problem.Description = HttpUtility.HtmlDecode( problem.Description );
                problem.Content = HttpUtility.HtmlDecode( problem.Content );

                db.Problems.Add( problem );
                db.SaveChanges();
                return RedirectToAction( "Index" );
            }

            ViewBag.ChallengeId = new SelectList( db.Challenges, "Id", "Name", problem.ChallengeId );
            return View( problem );
        }

        //
        // GET: /Problem/Edit/5

        public ActionResult Edit( int id = 0 )
        {
            Problem problem = db.Problems.Find( id );
            if ( problem == null )
            {
                return HttpNotFound();
            }
            ViewBag.ChallengeId = new SelectList( db.Challenges, "Id", "Name", problem.ChallengeId );
            return View( problem );
        }

        //
        // POST: /Problem/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit( Problem problem )
        {
            if ( ModelState.IsValid )
            {
                problem.Description = HttpUtility.HtmlDecode( problem.Description );
                problem.Content = HttpUtility.HtmlDecode( problem.Content );

                db.Entry( problem ).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction( "Index" );
            }
            ViewBag.ChallengeId = new SelectList( db.Challenges, "Id", "Name", problem.ChallengeId );
            return View( problem );
        }

        //
        // GET: /Problem/Delete/5

        public ActionResult Delete( int id = 0 )
        {
            Problem problem = db.Problems.Find( id );
            if ( problem == null )
            {
                return HttpNotFound();
            }
            return View( problem );
        }

        //
        // POST: /Problem/Delete/5

        [HttpPost, ActionName( "Delete" )]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed( int id )
        {
            Problem problem = db.Problems.Find( id );
            db.Problems.Remove( problem );
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