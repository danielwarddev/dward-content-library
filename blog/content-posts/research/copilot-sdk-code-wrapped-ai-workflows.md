# GitHub Copilot SDK: AI Workflows That Need Deterministic Code

**Generated:** January 20, 2026  
**Context:** Blog post demo ideas for AI workflows that work better with a thin layer of deterministic code around the prompts

---

## Why This Matters

Some AI workflows are better served by wrapping AI calls in actual code:

- **Control flow** (branching, loops, state machines)
- **Validation gates** (check AI output before proceeding)
- **Aggregation** (combine multiple AI responses)
- **Rollback/compensation** (undo if AI makes bad decisions)
- **Deterministic transforms** (parse, filter, join with DB data)
- **Checkpointing** (resume long-running processes)
- **Human-in-the-loop** (wait for approvals, handle escalations)

Pure prompt-chaining or no-code AI tools can't do this well. The Copilot SDK + C# gives you both.

---

## Part 1: Core Code-Wrapped Patterns (10 Ideas)

### 1. Multi-Source Research Aggregator

**Why code helps:** You need to query multiple sources, validate each result, handle failures, then synthesize.

```csharp
public async Task<ResearchReport> CompileResearchAsync(string topic)
{
    var sources = new[] { "internal-docs", "stackoverflow", "github-issues" };
    var findings = new List<Finding>();

    // Parallel fetch with individual error handling
    await Parallel.ForEachAsync(sources, async (source, ct) =>
    {
        try
        {
            var data = await FetchFromSource(source, topic);
            var analysis = await copilot.AnalyzeSource(data, topic);

            // Deterministic validation
            if (analysis.Confidence > 0.7 && analysis.Citations.Any())
                findings.Add(analysis);
        }
        catch (SourceUnavailableException)
        {
            // Continue without this source
            logger.LogWarning("Source {Source} unavailable", source);
        }
    });

    // Only synthesize if we have enough valid findings
    if (findings.Count < 2)
        throw new InsufficientDataException("Need at least 2 sources");

    return await copilot.SynthesizeFindings(findings);
}
```

**Why not pure prompts:** Error handling per source, minimum threshold logic, parallel execution.

---

### 2. Iterative Refinement Loop

**Why code helps:** AI output needs validation, and if it fails, you retry with feedback—but with limits.

```csharp
public async Task<GeneratedCode> GenerateValidCodeAsync(string requirement)
{
    GeneratedCode result = null;
    var feedback = new List<string>();

    for (int attempt = 0; attempt < 3; attempt++)
    {
        result = await copilot.GenerateCode(requirement, feedback);

        // Deterministic validation (actually compile it)
        var compilation = compiler.TryCompile(result.Code);
        if (compilation.Success)
        {
            // Run tests too
            var testResult = await testRunner.RunAsync(result.Code);
            if (testResult.AllPassed)
                return result;

            feedback.Add($"Tests failed: {testResult.FailureSummary}");
        }
        else
        {
            feedback.Add($"Compilation errors: {compilation.Errors}");
        }
    }

    // After 3 attempts, return best effort with warnings
    result.Warnings.Add("Could not produce fully validated code");
    return result;
}
```

**Why not pure prompts:** Actual compilation, test execution, retry limits, accumulated feedback.

---

### 3. Document Processing Pipeline

**Why code helps:** Each document needs different handling based on type, with human review gates.

```csharp
public async Task ProcessDocumentAsync(Document doc)
{
    // Step 1: Deterministic classification (file type, size checks)
    var docType = ClassifyDocument(doc); // No AI needed

    // Step 2: AI extraction based on type
    var extracted = docType switch
    {
        DocType.Invoice => await copilot.ExtractInvoiceData(doc),
        DocType.Contract => await copilot.ExtractContractTerms(doc),
        DocType.Resume => await copilot.ExtractCandidateInfo(doc),
        _ => await copilot.ExtractGeneric(doc)
    };

    // Step 3: Deterministic validation against business rules
    var violations = businessRules.Validate(extracted);
    if (violations.Any())
    {
        await queueForHumanReview(doc, extracted, violations);
        return;
    }

    // Step 4: Confidence threshold
    if (extracted.Confidence < 0.85)
    {
        await queueForHumanReview(doc, extracted, "Low confidence");
        return;
    }

    // Step 5: Deterministic storage
    await repository.SaveAsync(extracted);
    await eventBus.PublishAsync(new DocumentProcessedEvent(doc.Id));
}
```

**Why not pure prompts:** Switch on doc type, business rule validation, human review routing, event publishing.

---

### 4. Approval Workflow with AI Recommendations

**Why code helps:** AI recommends, but state machine controls the actual approval flow.

```csharp
public async Task<ApprovalResult> ProcessApprovalAsync(Request request)
{
    var state = await stateStore.GetStateAsync(request.Id);

    while (state.Status != ApprovalStatus.Complete)
    {
        switch (state.Status)
        {
            case ApprovalStatus.PendingAnalysis:
                var analysis = await copilot.AnalyzeRequest(request);
                state.AiRecommendation = analysis.Recommendation;
                state.RiskScore = analysis.RiskScore;

                // Deterministic routing based on risk
                state.Status = analysis.RiskScore > 0.8
                    ? ApprovalStatus.RequiresVpApproval
                    : ApprovalStatus.RequiresManagerApproval;
                break;

            case ApprovalStatus.RequiresManagerApproval:
                var managerDecision = await WaitForHumanApprovalAsync(state);
                if (managerDecision == Decision.Rejected)
                {
                    state.Status = ApprovalStatus.Complete;
                    state.Result = ApprovalResult.Rejected;
                }
                else if (state.RiskScore > 0.5)
                {
                    state.Status = ApprovalStatus.RequiresVpApproval;
                }
                else
                {
                    state.Status = ApprovalStatus.Complete;
                    state.Result = ApprovalResult.Approved;
                }
                break;

            case ApprovalStatus.RequiresVpApproval:
                // Similar pattern...
                break;
        }

        await stateStore.SaveAsync(state);
    }

    return state.Result;
}
```

**Why not pure prompts:** State machine logic, human-in-the-loop waits, durable state persistence.

---

### 5. Batch Processing with Checkpoints

**Why code helps:** Process thousands of items, checkpoint progress, resume on failure.

```csharp
public async Task ProcessBatchAsync(string batchId)
{
    var checkpoint = await checkpointStore.GetAsync(batchId) ?? new Checkpoint();
    var items = await GetItemsAsync(batchId, skip: checkpoint.ProcessedCount);

    await foreach (var item in items)
    {
        try
        {
            // AI processing
            var result = await copilot.ProcessItem(item);

            // Deterministic validation
            if (!IsValid(result))
            {
                await deadLetterQueue.AddAsync(item, "Invalid AI output");
                continue;
            }

            // Deterministic storage
            await resultStore.SaveAsync(result);

            // Checkpoint every 100 items
            checkpoint.ProcessedCount++;
            if (checkpoint.ProcessedCount % 100 == 0)
            {
                await checkpointStore.SaveAsync(batchId, checkpoint);
            }
        }
        catch (RateLimitException)
        {
            // Save checkpoint and pause
            await checkpointStore.SaveAsync(batchId, checkpoint);
            await Task.Delay(TimeSpan.FromMinutes(1));
        }
    }

    await checkpointStore.MarkCompleteAsync(batchId);
}
```

**Why not pure prompts:** Checkpointing, rate limit handling, dead letter queue, resume capability.

---

### 6. Data Enrichment Pipeline with Fallbacks

**Why code helps:** Try AI first, fall back to deterministic methods, merge results.

```csharp
public async Task<EnrichedContact> EnrichContactAsync(Contact contact)
{
    var enriched = new EnrichedContact(contact);

    // Try AI enrichment first
    var aiResult = await copilot.EnrichFromContext(contact);

    // Validate AI results against known data
    if (aiResult.Company != null)
    {
        var verified = await companyDatabase.VerifyAsync(aiResult.Company);
        if (verified)
            enriched.Company = aiResult.Company;
    }

    // Fall back to deterministic enrichment for missing fields
    if (enriched.Company == null)
    {
        enriched.Company = await clearbitApi.LookupByEmail(contact.Email);
    }

    if (enriched.Location == null && contact.Phone != null)
    {
        // Deterministic: area code lookup
        enriched.Location = phoneNumberParser.GetLocation(contact.Phone);
    }

    // AI for fields that can't be looked up
    if (enriched.Industry == null && enriched.Company != null)
    {
        enriched.Industry = await copilot.InferIndustry(enriched.Company);
    }

    enriched.EnrichmentScore = CalculateCompleteness(enriched);
    return enriched;
}
```

**Why not pure prompts:** Verification against DB, fallback chains, multiple data sources, score calculation.

---

### 7. Multi-Model Consensus Builder

**Why code helps:** Query multiple AI approaches, compare results, build consensus.

```csharp
public async Task<Classification> ClassifyWithConsensusAsync(string text)
{
    // Get opinions from different prompting strategies
    var opinions = await Task.WhenAll(
        copilot.ClassifyZeroShot(text),
        copilot.ClassifyWithExamples(text, examples),
        copilot.ClassifyWithChainOfThought(text)
    );

    // Deterministic consensus logic
    var grouped = opinions.GroupBy(o => o.Category)
                          .OrderByDescending(g => g.Count())
                          .First();

    if (grouped.Count() >= 2)
    {
        // Majority agrees
        return new Classification
        {
            Category = grouped.Key,
            Confidence = grouped.Average(o => o.Confidence),
            ConsensusStrength = grouped.Count() / 3.0
        };
    }

    // No consensus - ask AI to reconcile
    var reconciled = await copilot.ReconcileClassifications(opinions);
    reconciled.ConsensusStrength = 0.3; // Low confidence flag
    return reconciled;
}
```

**Why not pure prompts:** Parallel calls, grouping logic, consensus calculation, conditional reconciliation.

---

### 8. Scheduled Digest Generator

**Why code helps:** Gather data from multiple sources on a schedule, filter, summarize.

```csharp
public async Task GenerateDailyDigestAsync(User user)
{
    // Gather from deterministic sources
    var recentActivity = await activityService.GetSinceAsync(user.Id, TimeSpan.FromDays(1));
    var mentions = await slackService.GetMentionsAsync(user.SlackId);
    var prActivity = await githubService.GetPrActivityAsync(user.GithubUsername);
    var calendarToday = await calendarService.GetEventsAsync(user.Id, DateTime.Today);

    // Filter to what's relevant (deterministic rules)
    var relevantPrs = prActivity.Where(pr => pr.NeedsAttention || pr.WasMerged);
    var urgentMentions = mentions.Where(m => m.IsUrgent || m.WaitingOnReply);

    // Only call AI if there's something to summarize
    if (!recentActivity.Any() && !relevantPrs.Any() && !urgentMentions.Any())
    {
        await emailService.SendAsync(user.Email, "Quiet day - no digest needed!");
        return;
    }

    // AI summarization
    var digest = await copilot.GenerateDigest(new DigestInput
    {
        Activity = recentActivity,
        PullRequests = relevantPrs,
        Mentions = urgentMentions,
        Calendar = calendarToday,
        UserPreferences = user.DigestPreferences
    });

    // Deterministic delivery
    await emailService.SendAsync(user.Email, digest.Html);
    if (user.SlackNotifications)
        await slackService.SendDmAsync(user.SlackId, digest.Summary);
}
```

**Why not pure prompts:** Multiple API calls, filtering logic, conditional AI invocation, multi-channel delivery.

---

### 9. Comparative Analysis Engine

**Why code helps:** Analyze multiple items, score each, rank, handle ties.

```csharp
public async Task<RankedList<Candidate>> RankCandidatesAsync(Job job, List<Candidate> candidates)
{
    var scoredCandidates = new List<ScoredCandidate>();

    foreach (var candidate in candidates)
    {
        // AI analysis
        var analysis = await copilot.AnalyzeFit(candidate.Resume, job.Requirements);

        // Deterministic scoring
        var score = new CandidateScore
        {
            AiMatchScore = analysis.MatchScore,
            YearsExperienceMatch = CalculateExperienceMatch(candidate, job),
            LocationScore = CalculateLocationScore(candidate, job),
            AvailabilityScore = candidate.AvailableDate <= job.StartDate ? 1 : 0.5,
            SalaryFit = candidate.ExpectedSalary <= job.BudgetMax ? 1 :
                        (job.BudgetMax / candidate.ExpectedSalary)
        };

        // Weighted composite
        score.Composite = (score.AiMatchScore * 0.4) +
                          (score.YearsExperienceMatch * 0.2) +
                          (score.LocationScore * 0.15) +
                          (score.AvailabilityScore * 0.1) +
                          (score.SalaryFit * 0.15);

        scoredCandidates.Add(new ScoredCandidate(candidate, score, analysis.Reasoning));
    }

    // Deterministic ranking with tie-breaker
    return scoredCandidates
        .OrderByDescending(c => c.Score.Composite)
        .ThenByDescending(c => c.Score.AiMatchScore)
        .ThenBy(c => c.Candidate.AvailableDate)
        .ToRankedList();
}
```

**Why not pure prompts:** Business rule scoring, weighted calculations, tie-breaking, structured output.

---

### 10. Content Moderation Pipeline

**Why code helps:** Multiple checks, escalation paths, audit logging, appeal handling.

```csharp
public async Task<ModerationResult> ModerateContentAsync(Content content)
{
    // Fast deterministic checks first (no AI cost for obvious cases)
    var hashMatch = await knownBadContentDb.CheckHashAsync(content.Hash);
    if (hashMatch != null)
        return ModerationResult.Reject(hashMatch.Reason, "hash-match");

    var wordFilter = bannedWordFilter.Check(content.Text);
    if (wordFilter.HasViolations)
        return ModerationResult.Reject(wordFilter.Reason, "word-filter");

    // AI analysis for nuanced content
    var aiAnalysis = await copilot.AnalyzeContent(content);

    // Deterministic decision tree
    if (aiAnalysis.Severity == Severity.Clear)
        return ModerationResult.Approve();

    if (aiAnalysis.Severity == Severity.Severe)
    {
        await auditLog.LogAsync(content, aiAnalysis, "auto-rejected");
        await NotifyTrustAndSafetyAsync(content, aiAnalysis);
        return ModerationResult.Reject(aiAnalysis.Reason, "ai-severe");
    }

    if (aiAnalysis.Severity == Severity.Borderline)
    {
        // Queue for human review with AI context
        await humanReviewQueue.AddAsync(new ReviewItem
        {
            Content = content,
            AiAnalysis = aiAnalysis,
            Priority = aiAnalysis.Confidence < 0.7 ? Priority.High : Priority.Normal
        });
        return ModerationResult.Pending("queued-for-review");
    }

    return ModerationResult.Approve(warning: aiAnalysis.Suggestion);
}
```

**Why not pure prompts:** Fast-path checks, severity routing, human escalation, audit logging.

---

## Part 2: Additional Code-Wrapped Patterns (10 More Ideas)

### 11. Progressive Disclosure Chatbot

**Why code helps:** Gather information step-by-step, validate each step, branch based on answers.

```csharp
public async Task<ConversationResult> RunIntakeConversationAsync(string sessionId)
{
    var state = await sessionStore.GetAsync(sessionId) ?? new IntakeState();

    while (!state.IsComplete)
    {
        // Determine next question based on what we know
        var nextQuestion = state.Step switch
        {
            IntakeStep.Initial => await copilot.GenerateGreeting(state.Context),
            IntakeStep.GatheringProblem => "Can you describe the issue you're experiencing?",
            IntakeStep.GatheringDetails => await copilot.GenerateFollowUp(state.Problem),
            IntakeStep.Confirming => await copilot.GenerateSummary(state),
            _ => throw new InvalidOperationException()
        };

        // Wait for user response
        var userResponse = await WaitForUserInputAsync(sessionId);

        // Validate response is usable
        var validation = await copilot.ValidateResponse(state.Step, userResponse);
        if (!validation.IsValid)
        {
            await SendMessageAsync(sessionId, validation.ClarificationRequest);
            continue; // Don't advance step
        }

        // Store and advance
        state.AddResponse(state.Step, userResponse, validation.ExtractedData);
        state.Step = DetermineNextStep(state);

        // Checkpoint after each step
        await sessionStore.SaveAsync(sessionId, state);
    }

    return state.ToResult();
}
```

**Why not pure prompts:** Step validation, state persistence across messages, branching logic, retry on invalid input.

---

### 12. Distributed Transaction Coordinator

**Why code helps:** Coordinate AI-driven decisions across multiple services with compensation.

```csharp
public async Task<BookingResult> BookTravelAsync(TravelRequest request)
{
    var transaction = new DistributedTransaction();

    try
    {
        // AI picks best options
        var flightOptions = await copilot.RecommendFlights(request);
        var hotelOptions = await copilot.RecommendHotels(request, flightOptions.First());

        // Deterministic booking with transaction tracking
        var flightBooking = await flightService.BookAsync(flightOptions.First());
        transaction.Add(flightBooking, () => flightService.CancelAsync(flightBooking.Id));

        var hotelBooking = await hotelService.BookAsync(hotelOptions.First());
        transaction.Add(hotelBooking, () => hotelService.CancelAsync(hotelBooking.Id));

        // AI generates itinerary only after bookings succeed
        var itinerary = await copilot.GenerateItinerary(flightBooking, hotelBooking);

        await transaction.CommitAsync();
        return BookingResult.Success(flightBooking, hotelBooking, itinerary);
    }
    catch (Exception ex)
    {
        // Deterministic rollback
        await transaction.RollbackAsync();

        // AI explains what went wrong
        var explanation = await copilot.ExplainBookingFailure(ex, request);
        return BookingResult.Failed(explanation);
    }
}
```

**Why not pure prompts:** Transaction tracking, compensation actions, rollback coordination.

---

### 13. Rate-Limited Bulk Processor

**Why code helps:** Process items respecting external API rate limits, with smart batching.

```csharp
public async Task EnrichLeadsAsync(List<Lead> leads)
{
    var rateLimiter = new TokenBucketRateLimiter(requestsPerMinute: 60);
    var results = new ConcurrentBag<EnrichedLead>();

    // Group leads by domain for efficient batching
    var byDomain = leads.GroupBy(l => GetDomain(l.Email));

    foreach (var domainGroup in byDomain)
    {
        await rateLimiter.WaitAsync();

        try
        {
            // AI enrichment with domain context (more efficient)
            var enriched = await copilot.EnrichLeadBatch(domainGroup.ToList(), new
            {
                CompanyContext = await companyDb.GetByDomainAsync(domainGroup.Key)
            });

            foreach (var lead in enriched)
            {
                // Deterministic validation
                if (ValidateEnrichment(lead))
                    results.Add(lead);
                else
                    await invalidQueue.AddAsync(lead);
            }
        }
        catch (RateLimitException ex)
        {
            // Exponential backoff
            var delay = TimeSpan.FromSeconds(Math.Pow(2, ex.RetryCount));
            logger.LogWarning("Rate limited, waiting {Delay}", delay);
            await Task.Delay(delay);

            // Re-queue this batch
            await retryQueue.AddAsync(domainGroup.ToList());
        }
    }

    await resultStore.SaveBatchAsync(results);
}
```

**Why not pure prompts:** Rate limiting, batching strategy, exponential backoff, retry queues.

---

### 14. Schema Migration Assistant

**Why code helps:** Analyze data, generate migration, validate, apply with rollback capability.

```csharp
public async Task<MigrationResult> MigrateSchemaAsync(SchemaChange change)
{
    // Step 1: AI analyzes impact
    var impact = await copilot.AnalyzeSchemaImpact(change, await GetCurrentSchemaAsync());

    // Deterministic safety checks
    if (impact.DataLossRisk > 0.1)
    {
        return MigrationResult.Blocked($"Data loss risk: {impact.DataLossRisk:P0}");
    }

    if (impact.DowntimeEstimate > TimeSpan.FromMinutes(5))
    {
        await NotifyDbaTeamAsync(change, impact);
        return MigrationResult.RequiresApproval("Extended downtime expected");
    }

    // Step 2: AI generates migration script
    var script = await copilot.GenerateMigrationScript(change);

    // Step 3: Deterministic validation (parse and dry-run)
    var parseResult = sqlParser.Validate(script);
    if (!parseResult.IsValid)
    {
        return MigrationResult.Failed($"Invalid SQL: {parseResult.Errors}");
    }

    // Step 4: Test on replica first
    using var testConnection = await replicaDb.OpenAsync();
    using var testTransaction = await testConnection.BeginTransactionAsync();
    try
    {
        await testConnection.ExecuteAsync(script);
        // Don't commit - just validate it runs
    }
    finally
    {
        await testTransaction.RollbackAsync();
    }

    // Step 5: Apply with savepoint
    using var transaction = await primaryDb.BeginTransactionAsync();
    try
    {
        await primaryDb.ExecuteAsync(script);
        await transaction.CommitAsync();

        return MigrationResult.Success(script, impact);
    }
    catch (Exception ex)
    {
        await transaction.RollbackAsync();
        var diagnosis = await copilot.DiagnoseMigrationFailure(ex, script);
        return MigrationResult.Failed(diagnosis);
    }
}
```

**Why not pure prompts:** Safety thresholds, dry-run testing, transaction management, rollback.

---

### 15. Anomaly Response Orchestrator

**Why code helps:** Detect anomaly, investigate, take graduated response, notify appropriate people.

```csharp
public async Task HandleAnomalyAsync(Anomaly anomaly)
{
    // Step 1: AI investigates
    var investigation = await copilot.InvestigateAnomaly(anomaly, new
    {
        RecentDeployments = await deploymentService.GetRecentAsync(),
        RelatedMetrics = await metricsService.GetCorrelatedAsync(anomaly),
        RecentAlerts = await alertService.GetRecentAsync()
    });

    // Step 2: Deterministic severity assessment
    var severity = CalculateSeverity(anomaly, investigation);

    // Step 3: Graduated response based on severity
    switch (severity)
    {
        case Severity.Low:
            // Just log and notify on-call
            await slackService.NotifyChannelAsync("#ops", investigation.Summary);
            break;

        case Severity.Medium:
            // Auto-scale if it's a capacity issue
            if (investigation.LikelyCause == Cause.Capacity)
            {
                await autoScaler.ScaleUpAsync(investigation.AffectedService);
                await slackService.NotifyAsync(OnCallUser,
                    $"Auto-scaled {investigation.AffectedService}. Please verify.");
            }
            break;

        case Severity.High:
            // Page on-call, prepare rollback
            await pagerDuty.CreateIncidentAsync(anomaly, investigation);

            if (investigation.LikelyDeploymentRelated)
            {
                var rollbackPlan = await copilot.GenerateRollbackPlan(
                    investigation.SuspectedDeployment);
                await incidentChannel.PostAsync($"Rollback plan ready:\n{rollbackPlan}");
            }
            break;

        case Severity.Critical:
            // Auto-rollback if confident
            if (investigation.Confidence > 0.9 && investigation.LikelyDeploymentRelated)
            {
                await deploymentService.RollbackAsync(investigation.SuspectedDeployment);
                await pagerDuty.CreateIncidentAsync(anomaly, investigation,
                    note: "Auto-rollback executed");
            }
            break;
    }

    await incidentStore.SaveAsync(new Incident(anomaly, investigation, severity));
}
```

**Why not pure prompts:** Graduated response logic, auto-remediation actions, integration with external systems.

---

### 16. Compliance Report Generator

**Why code helps:** Gather evidence from multiple systems, validate completeness, format for auditors.

```csharp
public async Task<ComplianceReport> GenerateSOC2ReportAsync(DateRange period)
{
    var report = new ComplianceReport(period);

    // Gather evidence from deterministic sources
    var accessLogs = await accessLogService.GetAsync(period);
    var changeRecords = await changeManagementService.GetAsync(period);
    var incidentRecords = await incidentService.GetAsync(period);
    var policyDocuments = await policyService.GetCurrentAsync();

    // Check completeness before AI processing
    var missingEvidence = ValidateEvidenceCompleteness(
        accessLogs, changeRecords, incidentRecords, policyDocuments);

    if (missingEvidence.Any())
    {
        report.Status = ReportStatus.Incomplete;
        report.MissingItems = missingEvidence;
        return report;
    }

    // AI analyzes each control area
    foreach (var control in SOC2Controls.All)
    {
        var evidence = GatherEvidenceForControl(control,
            accessLogs, changeRecords, incidentRecords, policyDocuments);

        var analysis = await copilot.AnalyzeControlCompliance(control, evidence);

        // Deterministic compliance scoring
        var finding = new ControlFinding
        {
            Control = control,
            Status = analysis.Gaps.Any() ? ComplianceStatus.FindingsNoted : ComplianceStatus.Compliant,
            AiAnalysis = analysis,
            EvidenceReferences = evidence.Select(e => e.Reference).ToList(),
            // Calculate score deterministically
            Score = CalculateControlScore(analysis)
        };

        report.Findings.Add(finding);
    }

    // AI generates executive summary
    report.ExecutiveSummary = await copilot.GenerateComplianceSummary(report.Findings);

    // Deterministic overall status
    report.OverallStatus = report.Findings.All(f => f.Status == ComplianceStatus.Compliant)
        ? ComplianceStatus.Compliant
        : ComplianceStatus.FindingsNoted;

    return report;
}
```

**Why not pure prompts:** Evidence gathering, completeness validation, deterministic scoring, structured output.

---

### 17. A/B Test Analyzer with Statistical Validation

**Why code helps:** Gather data, run statistical tests, only use AI for interpretation.

```csharp
public async Task<ExperimentResult> AnalyzeExperimentAsync(string experimentId)
{
    var experiment = await experimentService.GetAsync(experimentId);
    var controlData = await metricsService.GetAsync(experiment.ControlGroup);
    var treatmentData = await metricsService.GetAsync(experiment.TreatmentGroup);

    // Deterministic statistical analysis
    var stats = new StatisticalAnalysis
    {
        ControlMean = controlData.Average(d => d.ConversionRate),
        TreatmentMean = treatmentData.Average(d => d.ConversionRate),
        ControlStdDev = CalculateStdDev(controlData),
        TreatmentStdDev = CalculateStdDev(treatmentData),
        SampleSizeControl = controlData.Count,
        SampleSizeTreatment = treatmentData.Count
    };

    // Calculate p-value and confidence interval (deterministic)
    stats.PValue = CalculatePValue(stats);
    stats.ConfidenceInterval = CalculateCI(stats, 0.95);
    stats.IsStatisticallySignificant = stats.PValue < 0.05;
    stats.Lift = (stats.TreatmentMean - stats.ControlMean) / stats.ControlMean;

    // Check for sample ratio mismatch (deterministic validation)
    var expectedRatio = experiment.TrafficSplit;
    var actualRatio = (double)stats.SampleSizeTreatment /
                      (stats.SampleSizeControl + stats.SampleSizeTreatment);
    stats.SampleRatioMismatch = Math.Abs(actualRatio - expectedRatio) > 0.02;

    if (stats.SampleRatioMismatch)
    {
        return new ExperimentResult
        {
            Status = ExperimentStatus.Invalid,
            Reason = "Sample ratio mismatch detected - experiment may be compromised",
            Stats = stats
        };
    }

    // AI only for interpretation and recommendations
    var interpretation = await copilot.InterpretExperimentResults(experiment, stats);

    return new ExperimentResult
    {
        Status = stats.IsStatisticallySignificant ? ExperimentStatus.Conclusive : ExperimentStatus.Inconclusive,
        Stats = stats,
        Interpretation = interpretation.Summary,
        Recommendation = interpretation.Recommendation,
        CaveatsAndLimitations = interpretation.Caveats
    };
}
```

**Why not pure prompts:** Statistical calculations must be deterministic, validation checks, structured result.

---

### 18. Dependency Update Evaluator

**Why code helps:** Fetch updates, check compatibility, test, generate changelog.

```csharp
public async Task<UpdateReport> EvaluateDependencyUpdatesAsync(Project project)
{
    var report = new UpdateReport();

    // Deterministic: find available updates
    var currentDeps = await nugetService.GetInstalledAsync(project);
    var availableUpdates = await nugetService.GetAvailableUpdatesAsync(currentDeps);

    foreach (var update in availableUpdates)
    {
        var evaluation = new UpdateEvaluation { Package = update };

        // Deterministic: check for known breaking changes
        evaluation.HasKnownBreakingChanges =
            await breakingChangeDb.CheckAsync(update.Package, update.FromVersion, update.ToVersion);

        // Deterministic: check our codebase for usage of deprecated APIs
        var usageAnalysis = await codeAnalyzer.FindUsagesAsync(project, update.Package);
        evaluation.AffectedFiles = usageAnalysis.Files;

        // AI: analyze changelog and release notes
        var changelog = await nugetService.GetChangelogAsync(update.Package, update.ToVersion);
        evaluation.AiAnalysis = await copilot.AnalyzeChangelog(changelog, new
        {
            OurUsage = usageAnalysis,
            FromVersion = update.FromVersion,
            ToVersion = update.ToVersion
        });

        // Deterministic: attempt update in isolated environment
        var testResult = await isolatedBuilder.TryUpdateAsync(project, update);
        evaluation.BuildSucceeds = testResult.BuildSuccess;
        evaluation.TestsPass = testResult.TestSuccess;
        evaluation.NewWarnings = testResult.Warnings;

        // Deterministic risk scoring
        evaluation.RiskScore = CalculateUpdateRisk(evaluation);

        report.Evaluations.Add(evaluation);
    }

    // Sort by risk and AI summary
    report.Evaluations = report.Evaluations.OrderBy(e => e.RiskScore).ToList();
    report.Summary = await copilot.SummarizeUpdateReport(report.Evaluations);

    return report;
}
```

**Why not pure prompts:** Build/test execution, version checking, risk calculation, isolated testing.

---

### 19. Incident Post-Mortem Generator

**Why code helps:** Gather timeline from multiple sources, correlate events, generate structured document.

```csharp
public async Task<PostMortem> GeneratePostMortemAsync(Incident incident)
{
    var postMortem = new PostMortem(incident);

    // Gather timeline from deterministic sources
    var alertTimeline = await alertService.GetTimelineAsync(incident.StartTime, incident.EndTime);
    var deploymentTimeline = await deploymentService.GetTimelineAsync(incident.StartTime.AddHours(-24), incident.EndTime);
    var slackMessages = await slackService.GetIncidentChannelHistoryAsync(incident.ChannelId);
    var pagerDutyEvents = await pagerDuty.GetEventsAsync(incident.PdIncidentId);
    var metricsSnapshots = await metricsService.GetSnapshotsAsync(incident.AffectedServices, incident.StartTime, incident.EndTime);

    // Deterministic timeline correlation
    postMortem.Timeline = BuildCorrelatedTimeline(
        alertTimeline, deploymentTimeline, slackMessages, pagerDutyEvents);

    // Deterministic impact calculation
    postMortem.Impact = new ImpactAssessment
    {
        Duration = incident.EndTime - incident.StartTime,
        AffectedUsers = await CalculateAffectedUsersAsync(incident),
        ErrorCount = metricsSnapshots.Sum(m => m.ErrorCount),
        RevenueImpact = await CalculateRevenueImpactAsync(incident)
    };

    // AI analyzes root cause from evidence
    postMortem.RootCauseAnalysis = await copilot.AnalyzeRootCause(new
    {
        Timeline = postMortem.Timeline,
        Deployments = deploymentTimeline,
        Metrics = metricsSnapshots,
        Resolution = incident.ResolutionNotes
    });

    // AI generates action items, but we validate they're actionable
    var proposedActions = await copilot.GenerateActionItems(postMortem.RootCauseAnalysis);
    postMortem.ActionItems = proposedActions
        .Where(a => ValidateActionItem(a)) // Must have owner, deadline, success criteria
        .ToList();

    // AI generates narrative, but facts come from deterministic sources
    postMortem.Narrative = await copilot.GeneratePostMortemNarrative(postMortem);

    // Deterministic formatting
    postMortem.Document = FormatAsGoogleDoc(postMortem);

    return postMortem;
}
```

**Why not pure prompts:** Multi-source data gathering, timeline correlation, impact calculation, validation.

---

### 20. Customer Health Score Calculator

**Why code helps:** Aggregate signals, apply business rules, use AI only for qualitative insights.

```csharp
public async Task<CustomerHealth> CalculateHealthScoreAsync(Customer customer)
{
    var health = new CustomerHealth(customer);

    // Gather deterministic signals
    var usageMetrics = await analyticsService.GetUsageAsync(customer.Id, TimeSpan.FromDays(30));
    var supportTickets = await supportService.GetTicketsAsync(customer.Id, TimeSpan.FromDays(90));
    var billingHistory = await billingService.GetHistoryAsync(customer.Id);
    var npsResponses = await npsService.GetResponsesAsync(customer.Id);
    var featureAdoption = await featureService.GetAdoptionAsync(customer.Id);

    // Deterministic scoring components
    health.Scores = new HealthScores
    {
        // Usage trend (deterministic calculation)
        UsageScore = CalculateUsageTrend(usageMetrics),

        // Support health (deterministic rules)
        SupportScore = CalculateSupportScore(supportTickets),

        // Payment reliability (deterministic)
        PaymentScore = billingHistory.All(b => b.PaidOnTime) ? 100 :
                       billingHistory.Count(b => b.PaidOnTime) / billingHistory.Count * 100,

        // NPS (deterministic average)
        NpsScore = npsResponses.Any() ? npsResponses.Average(n => n.Score) * 10 : 50,

        // Feature adoption (deterministic)
        AdoptionScore = featureAdoption.AdoptedFeatures.Count /
                        featureAdoption.AvailableFeatures.Count * 100
    };

    // Weighted composite (deterministic)
    health.OverallScore =
        (health.Scores.UsageScore * 0.3) +
        (health.Scores.SupportScore * 0.2) +
        (health.Scores.PaymentScore * 0.15) +
        (health.Scores.NpsScore * 0.2) +
        (health.Scores.AdoptionScore * 0.15);

    // Deterministic risk classification
    health.RiskLevel = health.OverallScore switch
    {
        >= 80 => RiskLevel.Healthy,
        >= 60 => RiskLevel.Monitor,
        >= 40 => RiskLevel.AtRisk,
        _ => RiskLevel.Critical
    };

    // AI only for qualitative insights and recommendations
    health.Insights = await copilot.GenerateCustomerInsights(new
    {
        Customer = customer,
        Scores = health.Scores,
        RecentTickets = supportTickets.Take(5),
        UsagePatterns = usageMetrics
    });

    health.RecommendedActions = await copilot.SuggestRetentionActions(health);

    return health;
}
```

**Why not pure prompts:** Business rules for scoring, weighted calculations, deterministic thresholds.

---

## Summary: When Code Wrapping AI Wins

| Pattern                  | Why Code Helps                                                         |
| ------------------------ | ---------------------------------------------------------------------- |
| Multi-source aggregation | Parallel fetch, error handling per source, minimum thresholds          |
| Iterative refinement     | Actual validation (compile, test), retry limits, feedback accumulation |
| Document pipelines       | Type-based routing, business rules, human review gates                 |
| Approval workflows       | State machines, human-in-the-loop, durable state                       |
| Batch processing         | Checkpointing, resume, rate limit handling                             |
| Enrichment pipelines     | Fallback chains, verification against databases                        |
| Multi-model consensus    | Parallel calls, voting logic, confidence calculation                   |
| Scheduled digests        | Data gathering, filtering rules, conditional AI calls                  |
| Comparative analysis     | Weighted scoring, tie-breakers, business rules                         |
| Content moderation       | Fast-path checks, escalation trees, audit trails                       |
| Progressive disclosure   | Step validation, state persistence, branching                          |
| Distributed transactions | Transaction tracking, compensation, rollback                           |
| Rate-limited processing  | Batching, backoff, retry queues                                        |
| Schema migration         | Safety checks, dry-run, transaction management                         |
| Anomaly response         | Graduated response, auto-remediation, integrations                     |
| Compliance reporting     | Evidence gathering, completeness checks, scoring                       |
| A/B test analysis        | Statistical calculations, validation, structured output                |
| Dependency updates       | Build/test execution, version checking, isolated testing               |
| Post-mortem generation   | Timeline correlation, multi-source gathering, validation               |
| Health scoring           | Business rules, weighted calculations, thresholds                      |

---

## Recommended for Blog Post

**Best for demonstrating the concept:**

1. **#2 Iterative Refinement Loop** - Simple, relatable, shows validate-retry pattern
2. **#5 Batch Processing with Checkpoints** - Shows resume capability
3. **#7 Multi-Model Consensus** - Shows parallel + aggregation

**Most practical for real production use:**

- **#10 Content Moderation** - Common need, clear value
- **#16 Compliance Report Generator** - Enterprise appeal
- **#20 Customer Health Score** - SaaS companies will love this

**Best combination for a blog post:**

1. Start with #2 (Iterative Refinement) - shows the core pattern simply
2. Then #5 (Batch with Checkpoints) - shows durability
3. End with #10 (Content Moderation) - shows production complexity

---

## Notes

- All examples use a hypothetical `copilot` session object from the Copilot SDK
- The pattern is: **deterministic setup → AI processing → deterministic validation → deterministic action**
- AI should be used for judgment calls; code handles business rules and orchestration
- Consider wrapping AI calls with retries and timeouts even in these patterns
