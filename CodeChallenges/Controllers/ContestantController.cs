using CodeChallenges.Models;
using CodeChallenges.Utils;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;

namespace CodeChallenges.Controllers
{
    [Authorize]
    public class ContestantController : Controller
    {
        private Entities db = new Entities();

        private int UserId
        {
            get
            {
                if ( Session[ Constants.SESSION_USER_ID ] == null )
                {
                    UserProfile user = db.UserProfiles.SingleOrDefault( u => u.UserName.ToLower().Equals( User.Identity.Name.ToLower() ) );
                    if ( user != null )
                        Session.Add( Constants.SESSION_USER_ID, user.UserId );
                }
                return (int)Session[ Constants.SESSION_USER_ID ];
            }
        }

        //
        // GET: /Contestant/

        public ActionResult Index()
        {
            IDictionary<string, IEnumerable<YourChallenge>> challenges = new Dictionary<string, IEnumerable<YourChallenge>>();

            DateTime? now = DateTime.UtcNow;

            List<int> yourActiveChallengeIds = db.Challenges.Where( c => c.StartTime < now && now < c.EndTime )
                .Select( challenge => challenge.Id )
                .ToList();

            List<YourChallenge> yourActiveChallenges = new List<YourChallenge>();
            foreach ( int challengeId in yourActiveChallengeIds )
            {
                yourActiveChallenges.Add( new YourChallenge( challengeId, UserId ) );
            }

            challenges.Add( "ActiveChallenges", yourActiveChallenges );

            IEnumerable<int?> historyProblemIds = db.Solvings.Where( s => s.UserProfile.UserName.Equals( User.Identity.Name ) ).Select( s => s.ProblemId ).Distinct();
            IEnumerable<int?> historyChallengeIds = db.Problems.Where( p => historyProblemIds.Contains( p.Id ) ).Select( p => p.ChallengeId ).Distinct();

            List<YourChallenge> yourHistoryChallenges = new List<YourChallenge>();

            foreach ( int challengId in historyChallengeIds )
            {
                yourHistoryChallenges.Add( new YourChallenge( challengId, UserId ) );
            }

            challenges.Add( "YourChallenges", yourHistoryChallenges );

            return View( challenges );
        }

        public ActionResult Challenge( int id )
        {
            Challenge challenge = db.Challenges.SingleOrDefault( c => c.Id == id );

            if ( challenge == null )
            {
                return HttpNotFound();
            }

            YourChallenge yourChallenge = new YourChallenge( id, UserId );

            if ( challenge.EndTime < DateTime.UtcNow || Roles.IsUserInRole( Constants.ROLE_ADMINISTRATOR ) )
            {
                RankingTable rankingTable = new RankingTable( id );
                ViewData.Add( Constants.VIEW_BAG_RANKING_TABLE, rankingTable );
            }

            return View( yourChallenge );
        }

        public ActionResult Problem( int id )
        {
            Problem problem = db.Problems.SingleOrDefault( p => p.Id == id );

            if ( problem == null )
            {
                return HttpNotFound();
            }

            if ( !Security.CanOpen( id, UserId ) )
            {
                ViewData.Add( Constants.VIEW_BAG_MESSAGE, "You do not have permission to open this problem right now!" );
                return View( "Information" );
            }

            YourProblem yourProblem = new YourProblem( problem, UserId );

            Solving solving = db.Solvings.SingleOrDefault( s => s.UserId == UserId && s.ProblemId == id );

            if ( solving == null )
            {
                solving = db.Solvings.Create();

                solving.ProblemId = id;
                solving.UserId = UserId;
                solving.Result = 0;
                solving.FirstOpenTime = DateTime.UtcNow;
                solving.LastOpenTime = DateTime.UtcNow;

                db.Solvings.Add( solving );
            }
            else
            {
                solving.LastOpenTime = DateTime.UtcNow;
                db.Entry( solving ).State = System.Data.EntityState.Modified;
            }

            db.SaveChanges();

            return View( yourProblem );
        }

        [HttpPost]
        public ActionResult Problem()
        {
            Entities db = new Entities();
            Submission submission = db.Submissions.Create();

            int problemId = Int32.Parse( Request[ Constants.FORM_PROBLEM_ID ] );
            Solving solving = db.Solvings.SingleOrDefault( s => s.ProblemId == problemId && s.UserId == UserId );
            Problem problem = db.Problems.SingleOrDefault( p => p.Id == problemId );

            submission.Time = DateTime.UtcNow;
            submission.Content = Request[ Constants.FORM_PROBLEM_RESULT ].Trim();
            submission.SolvingId = solving.Id;
            submission.Result = 0;

            if ( submission.Content.Equals( problem.Output, StringComparison.InvariantCulture ) )
            {
                submission.Result = 1;
                solving.Result = 1;

                db.Entry( solving ).State = System.Data.EntityState.Modified;
            }

            db.Submissions.Add( submission );
            db.SaveChanges();

            return Problem( problemId );
        }

        public ActionResult Submit()
        {
            return View();
        }

        public ActionResult Information( string message )
        {
            ViewData.Add( Constants.VIEW_BAG_MESSAGE, message );
            return View();
        }
    }
}