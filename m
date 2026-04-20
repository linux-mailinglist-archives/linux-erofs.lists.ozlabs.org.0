Return-Path: <linux-erofs+bounces-3335-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDUyAlkq5mkDswEAu9opvQ
	(envelope-from <linux-erofs+bounces-3335-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 15:30:01 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3069742BD53
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 15:30:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzmYy0yHWz2ynn;
	Mon, 20 Apr 2026 23:29:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776691798;
	cv=none; b=AdQJhniNWgFNy5ekHE/2k/nspAI9yZXWfPETRzcrB/n97VvAGb/wuKpN1hc1WPpa5NE/y9u3CKW829GBsX6r96ORg6Rq2VRnMrNjpH8WXtr50eRmsk1IQ6u+604Ijij6FmLPvxpkMAFjoOpJcg6XyvC1R5QcBc+oPsND5CjHwLPUvzo+twvkQ7VZqeZPNHvZ3c4Wi1Qb30XnyEYCKWMrab5/dz9vq9BLju9IP1NiubZL0y47ehFriD6oSrLjmTWc6MLuFDYGoGU5Ib7A+Bf3Ea3rrIXtQAMQDWKRRXsHiNmNLvXNgb3TZSZe3G9q80yo7qLlibCFj6rZWyspohk//A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776691798; c=relaxed/relaxed;
	bh=N8ijPUV9PSB9R5lBzF7mAO5G6x/B5hu/5aV+v8X65OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKTjljGugqi643Lzi0RTxASDf7mA1GcE9q8p72uE0BBXPzcuZumqSrDtNGThUJLlic8lC710PG2udUusm/iQ8YkKFqwF/O2MlHTaCkeJJPWG0ypg68MNp9MM9n5Z/lGhi9snyzTlQ7CpbExaV1EnJH76by+Z/WbkxPPKeZooDx9jymCStGiSEh/JH6Je29X71lk2NR3q6WBmsWdX815KLRLK/eq54M1joezNcJRooy9kRabN8Ze30sT6ZQccfcnB4T3LvQwmik25Szh3dTsQm12kmKQwqkauJqWKEIyL+FAAJ8V6IiHSuNEMQp9q/nTdIgr2uvu8EWodSHcDxzCJ/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nTIaONQS; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nTIaONQS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzmYx0lkcz2xll
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Apr 2026 23:29:57 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BFFC44094;
	Mon, 20 Apr 2026 13:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F97C2BCB7;
	Mon, 20 Apr 2026 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691795;
	bh=X9Fu4mccX6nbTYCTzir+XJpu4WFqFbzjgYLmdztuXxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTIaONQSVlej3BZOqwZVx67qaTrjvlxPXJN9cKzqNJlUukdUljmpR8XBNwodrrReG
	 OsjMA7O2OIcvTGG/NXadcSe4KBs2uRTX81pxlBFPM1aoOxVKfcwuCYqzeKd45LAosA
	 xvMTBbITpBBla01IrKF/xX85O9LoIGhQhEtDk/lVKBL+qj2zhjtl4w0tfBXM34EsXA
	 7CHceXtTXlYTdkXuDJ0S9tkMkh4e2TfjR9h49l9aGwp7Ygjx+bD+TfKkv3644inyKB
	 J+OAACHioZm7A3LDlkH0r9zCXJMTyplAX51oySN4hIuf5bdE6vL8xpKMueqmy1cLSk
	 U2uFyIcAatuxg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Sasha Levin <sashal@kernel.org>,
	xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.12] erofs: ensure all folios are managed in erofs_try_to_free_all_cached_folios()
Date: Mon, 20 Apr 2026 09:19:52 -0400
Message-ID: <20260420132314.1023554-198-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3335-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:patches@lists.linux.dev,m:stable@vger.kernel.org,m:zhanxusheng@xiaomi.com,m:hsiangkao@linux.alibaba.com,m:guochunhai@vivo.com,m:sashal@kernel.org,m:xiang@kernel.org,m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3069742BD53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

[ Upstream commit 5de6951fedb29700ace53b283ccb951c8f712d12 ]

folio_trylock() in erofs_try_to_free_all_cached_folios() may
successfully acquire the folio lock, but the subsequent check
for erofs_folio_is_managed() can skip unlocking when the folio
is not managed by EROFS.

As Gao Xiang pointed out, this condition should not happen in
practice because compressed_bvecs[] only holds valid cached folios
at this point — any non-managed folio would have already been
detached by z_erofs_cache_release_folio() under folio lock.

Fix this by adding DBG_BUGON() to catch unexpected folios
and ensure folio_unlock() is always called.

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chunhai Guo <guochunhai@vivo.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete picture. Let me compile my analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: PARSE THE SUBJECT LINE
Record: [erofs] [ensure] "ensure all folios are managed in
erofs_try_to_free_all_cached_folios()" — the verb "ensure" strongly
indicates a correctness/bug fix. The function is part of the erofs
shrinker path.

### Step 1.2: PARSE ALL COMMIT MESSAGE TAGS
- **Suggested-by:** Gao Xiang <hsiangkao@linux.alibaba.com> — the EROFS
  maintainer suggested this fix
- **Signed-off-by:** Zhan Xusheng <zhanxusheng@xiaomi.com> — author from
  Xiaomi
- **Reviewed-by:** Gao Xiang <hsiangkao@linux.alibaba.com> — EROFS
  maintainer reviewed
- **Reviewed-by:** Chunhai Guo <guochunhai@vivo.com> — additional
  reviewer
- **Signed-off-by:** Gao Xiang <hsiangkao@linux.alibaba.com> —
  maintainer SOB (applied through his tree)
- No Fixes: tag (expected for commits under review)
- No Cc: stable (expected)
- No Reported-by

Record: Fix was suggested and reviewed by the EROFS maintainer. Two
independent reviewers.

### Step 1.3: ANALYZE THE COMMIT BODY TEXT
The commit explains:
- `folio_trylock()` may succeed, acquiring the folio lock
- The subsequent `erofs_folio_is_managed()` check can cause a `continue`
  that **skips the `folio_unlock()`**
- Gao Xiang notes this shouldn't happen "in practice" because
  compressed_bvecs[] should only hold managed folios
- Any non-managed folio would have been detached by
  `z_erofs_cache_release_folio()` under folio lock

Record: Bug = folio lock leak when `!erofs_folio_is_managed` is true
after `folio_trylock` succeeds. Failure mode = folio stays locked
forever → deadlock. Maintainer says the condition is theoretically
impossible in practice.

### Step 1.4: DETECT HIDDEN BUG FIXES
Record: This IS a real bug fix (folio lock leak/deadlock), presented
with the "ensure" verb. The `continue` after acquiring a lock without
releasing it is an obvious code defect regardless of whether the path is
reachable.

## PHASE 2: DIFF ANALYSIS

### Step 2.1: INVENTORY THE CHANGES
- **fs/erofs/zdata.c**: -2 lines, +1 line (net -1 line)
- Function modified: `erofs_try_to_free_all_cached_folios()`
- Scope: single-file, single-function, single-line surgical fix

Record: Extremely small change — 1 file, 1 function, net -1 line.

### Step 2.2: UNDERSTAND THE CODE FLOW CHANGE
Before: After `folio_trylock(folio)` succeeds, if
`!erofs_folio_is_managed(sbi, folio)`, the code does `continue` —
skipping `folio_unlock(folio)` on lines 611-612.

After: The `if/continue` is replaced with
`DBG_BUGON(!erofs_folio_is_managed(sbi, folio))`. The code always falls
through to `folio_unlock(folio)`.

Record: Before = folio left locked on `continue` path. After = folio
always unlocked.

### Step 2.3: IDENTIFY THE BUG MECHANISM
This is a **lock leak** (folio lock not released). Category:
synchronization/resource leak. If the folio remains locked, any
subsequent attempt to lock it (by reclaim, migration, or other code
paths) would block indefinitely → **deadlock**.

Record: Bug = folio lock leak. Mechanism = `continue` after
`folio_trylock` without `folio_unlock`. Category = resource leak /
potential deadlock.

### Step 2.4: ASSESS THE FIX QUALITY
- Obviously correct: removing the `continue` ensures `folio_unlock()` is
  always reached
- Minimal/surgical: 1 line replaced
- Regression risk: extremely low — in production builds, `DBG_BUGON` is
  a no-op `((void)(x))`, so the code simply proceeds to unlock
- In debug builds, `DBG_BUGON` becomes `BUG_ON` which would crash, but
  only if the assertion condition fires

Record: Fix is obviously correct, minimal, and carries near-zero
regression risk.

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: BLAME THE CHANGED LINES
The buggy `if (!erofs_folio_is_managed)/continue` pattern at lines
608-609 was introduced by commit `2080ca1ed3e432` ("erofs: tidy up
`struct z_erofs_bvec`", Gao Xiang, 2024-07-03), merged in v6.12 cycle.

However, the same bug pattern existed BEFORE that commit in the page-
based version. Tracing further back through `706fd68fce3a5` (v6.9, folio
conversion), and even to the original `105d4ad857dcbf` (v4.19, staging
era), the page-based `trylock_page`/`continue` pattern also leaked the
page lock. In v5.4, the check was `page->mapping != mapping` instead of
`erofs_page_is_managed`, but the bug (continue without unlock after
trylock) was the same.

Record: Bug is long-standing, present since v5.4 in page form,
persisting through folio conversions. Present in ALL stable trees with
EROFS compressed data support.

### Step 3.2: FOLLOW THE FIXES: TAG
No Fixes: tag present (expected).

### Step 3.3: CHECK FILE HISTORY
Recent zdata.c changes show active development. The function has been
modified during refactoring (folio conversion, bvec tidy-up, lockref
changes) but the lock leak bug was never addressed.

Record: Standalone fix, no prerequisites needed.

### Step 3.4: CHECK THE AUTHOR
Zhan Xusheng from Xiaomi. The fix was suggested by Gao Xiang (EROFS
maintainer), who also reviewed it. This carries high credibility.

Record: Fix suggested and reviewed by subsystem maintainer.

### Step 3.5: CHECK FOR DEPENDENCIES
The fix is self-contained. It modifies only the body of
`erofs_try_to_free_all_cached_folios()`. No dependencies on other
commits. For older stable trees (v6.6 and earlier), the fix would need
adaptation to the page-based API.

Record: Self-contained fix, but needs adaptation for page-based stable
trees.

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

### Step 4.1-4.5: MAILING LIST INVESTIGATION
Lore.kernel.org is behind bot protection. Web search found no specific
patch discussion for this commit. The commit was applied through Gao
Xiang's tree (signed-off by him).

Record: Could not access lore discussion. The commit's review chain
(suggested-by + 2 reviewed-by + maintainer SOB) provides sufficient
confidence.

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1: KEY FUNCTIONS
Modified function: `erofs_try_to_free_all_cached_folios()`

### Step 5.2: TRACE CALLERS
Called from:
1. `__erofs_try_to_release_pcluster()` (line 894) — called from shrinker
   path
2. Which is called from `erofs_try_to_release_pcluster()` (line 913) and
   `z_erofs_put_pcluster()` (line 954)
3. `z_erofs_shrink_scan()` (line 930) iterates pclusters and calls this
4. `erofs_shrink_scan()` (line 282) is the registered shrinker callback

The shrinker is invoked by the kernel's memory reclaim subsystem under
memory pressure — this is a commonly-hit path on any system using EROFS
with compressed data.

Record: Called from kernel shrinker path → triggered during memory
pressure. Common execution path.

### Step 5.3-5.5: CALL CHAIN AND PATTERNS
The function is reachable whenever the kernel is under memory pressure
and an EROFS filesystem with compressed data is mounted. This is a core
memory management path for EROFS — not obscure.

Record: Reachable from core memory reclaim path.

## PHASE 6: CROSS-REFERENCING AND STABLE TREE ANALYSIS

### Step 6.1: BUGGY CODE EXISTS IN STABLE TREES
Verified the bug exists in:
- **v5.4**: `trylock_page` + `page->mapping != mapping` → `continue`
  (lock leak)
- **v5.15**: `trylock_page` + `!erofs_page_is_managed` → `continue`
  (lock leak)
- **v6.1**: same as v5.15
- **v6.6**: same as v5.15
- **v6.9, v6.12**: folio-based `folio_trylock` +
  `!erofs_folio_is_managed` → `continue` (lock leak)

Record: Bug exists in ALL active stable trees (v5.4+).

### Step 6.2: BACKPORT COMPLICATIONS
- v6.9+: patch applies cleanly or with minimal context adjustment
  (folio-based)
- v6.6 and earlier: needs adaptation to page-based API
  (`trylock_page`/`unlock_page`/`erofs_page_is_managed`)
- Function signature differs in older trees (takes `struct
  erofs_workgroup *grp` parameter)

Record: Clean apply for v6.9+; needs rework for v6.6 and earlier.

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

### Step 7.1: SUBSYSTEM CRITICALITY
- **Subsystem**: fs/erofs — Enhanced Read-Only Filesystem
- **Criticality**: IMPORTANT — used in Android, embedded systems,
  containers
- This is a filesystem's memory management path, not an obscure driver

Record: EROFS is an actively used filesystem, especially in
Android/embedded contexts.

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: WHO IS AFFECTED
Users of EROFS with compressed data (common use case — EROFS is
primarily a compressed read-only filesystem). Especially Android
devices.

### Step 8.2: TRIGGER CONDITIONS
The trigger requires: (1) EROFS filesystem mounted with compressed data,
(2) memory pressure causing shrinker to run, (3) a folio in
compressed_bvecs[] that is not managed. Condition (3) is believed to be
impossible in practice per the maintainer.

Record: Trigger requires a "theoretically impossible" condition. But if
it occurs, it would be during common memory pressure events.

### Step 8.3: FAILURE MODE SEVERITY
If triggered: folio locked forever → deadlock/hang. Severity:
**CRITICAL** (if triggered) but probability believed to be near zero.

### Step 8.4: RISK-BENEFIT RATIO
- **Benefit**: Prevents potential deadlock; eliminates a code
  correctness bug; defense-in-depth
- **Risk**: Near zero — the fix removes a `continue` and replaces it
  with a no-op assertion (in production builds). The code path proceeds
  to `folio_unlock()` which is always correct.
- **Ratio**: Very favorable — high potential benefit, near-zero risk

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: EVIDENCE COMPILATION

**FOR backporting:**
- Fixes a real code correctness bug (folio/page lock leak on `continue`
  path)
- If triggered, causes a deadlock (CRITICAL severity)
- Fix is surgical: 1 line, 1 function, 1 file
- Obviously correct — ensures unlock after lock
- Reviewed and suggested by EROFS maintainer (Gao Xiang)
- Bug exists in ALL stable trees since v5.4
- Zero regression risk
- Shrinker path is commonly executed

**AGAINST backporting:**
- Maintainer says the condition "should not happen in practice"
- No user reports of this bug triggering
- Needs adaptation for older (page-based) stable trees

### Step 9.2: STABLE RULES CHECKLIST
1. Obviously correct and tested? **YES** — maintainer reviewed, trivial
   fix
2. Fixes a real bug? **YES** — folio lock leak (even if theoretically
   unreachable)
3. Important issue? **YES** — deadlock if triggered
4. Small and contained? **YES** — net -1 line
5. No new features/APIs? **YES**
6. Can apply to stable? **YES** — cleanly for v6.9+, with adaptation for
   older trees

### Step 9.3: EXCEPTION CATEGORIES
Not an exception category — this is a standard bug fix.

### Step 9.4: DECISION
The fix eliminates a real code correctness defect (missing
`folio_unlock` on a control flow path after `folio_trylock`). While the
maintainer believes the condition can't happen in practice, the fix is
surgical, obviously correct, carries zero regression risk, and prevents
a deadlock if the condition ever did trigger. The code path is in the
kernel's memory reclaim shrinker — a commonly exercised subsystem. The
fix meets all stable kernel criteria.

## Verification

- [Phase 1] Parsed tags: Suggested-by and Reviewed-by from Gao Xiang
  (EROFS maintainer), additional Reviewed-by from Chunhai Guo
- [Phase 2] Diff analysis: 2 lines removed, 1 added — replaces
  `if(!managed) continue` with `DBG_BUGON(!managed)`, ensuring
  `folio_unlock()` is always called
- [Phase 2] DBG_BUGON definition verified: `BUG_ON` with
  CONFIG_EROFS_FS_DEBUG, `((void)(x))` without
- [Phase 3] git blame: buggy code in current form from commit
  2080ca1ed3e432 (v6.12 cycle); same bug pattern present since
  105d4ad857dcbf (v4.19/staging era)
- [Phase 3] git show v5.4/v5.15/v6.1/v6.6/v6.9/v6.12 zdata.c: confirmed
  bug exists in ALL stable trees in page-based or folio-based form
- [Phase 3] Folio conversion 706fd68fce3a5 confirmed in v6.9 but not in
  v6.6
- [Phase 3] git log: no prerequisites found, fix is self-contained
- [Phase 4] Could not access lore.kernel.org due to bot protection
- [Phase 4] b4 dig found: https://patch.msgid.link/20240703120051.365345
  2-4-hsiangkao@linux.alibaba.com for the buggy commit
- [Phase 5] Callers traced: `erofs_try_to_free_all_cached_folios` →
  `__erofs_try_to_release_pcluster` →
  `erofs_try_to_release_pcluster`/`z_erofs_put_pcluster` →
  `z_erofs_shrink_scan` → `erofs_shrink_scan` (registered shrinker
  callback)
- [Phase 6] Bug present in all stable trees v5.4+; backport needs API
  adaptation for v6.6 and earlier
- [Phase 8] Failure mode: deadlock (folio locked forever) — CRITICAL if
  triggered, but believed theoretically unreachable
- UNVERIFIED: Could not verify mailing list discussion for stable
  nomination or NAKs

**YES**

 fs/erofs/zdata.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index fe8121df9ef2f..b566996a0d1a5 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -605,8 +605,7 @@ static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 			if (!folio_trylock(folio))
 				return -EBUSY;
 
-			if (!erofs_folio_is_managed(sbi, folio))
-				continue;
+			DBG_BUGON(!erofs_folio_is_managed(sbi, folio));
 			pcl->compressed_bvecs[i].page = NULL;
 			folio_detach_private(folio);
 			folio_unlock(folio);
-- 
2.53.0


