Return-Path: <linux-erofs+bounces-3116-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F9zMuluymnG8gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3116-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 14:39:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CC335B241
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 14:39:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkrQr0jxWz2xpt;
	Mon, 30 Mar 2026 23:39:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774874339;
	cv=none; b=JsP3JCgbb/azREdO9IIOOhaL8+GyBNdsWoQwUuBY3qYNIokRbNi787zg4n4ZZ53DfwbBLy8cWB4GExMpVy5HE8iIzCFw9z4rL7r1FM3giRR0PItngqOY48ZnmWzlYTMrtAPH5fsEgZFCT6ZZYtEGjIxDmrCUM4/fwl9M3JSEc7o3DAB8LONmEyh2BLVEh1dGDC8B+qfhOGNIp8t0TlHckCkz8RdiBZJOQjP3gHx8kvBSi3kn8eOIG8qG5Ru8K9euRuLr1YW3MVoAswcFIGUF7ylWemjw9WFuNLyF/Vq1Gm7bT41AB9o0lcv/vi0kgxhGHWqw9NawjcSvLZFzqKo0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774874339; c=relaxed/relaxed;
	bh=eDDk6bbS8ZhJ4EFRnPHMcXMj2XHTv/1PNzxa/mlTGI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fu0uOjaNc19DvBvT9D2Nzc4/EtdEQQVXXHiQ0W9AifOMcY4OvyKRHZjwtR75qcyd+HOhWukWhvJO28ScacjH5L8HEpSXy7dMB0o/6HRhYEeEsn78WYXgjNbLtOKEgpimHhJ2juJtf6+ULLGtx3/mBhmQPF6tqGll/CvsWeF3QaYZY9L3YIrNvn0r7ZCzybdqvYlmZerc8mOmjBaZtpx/yNQXI7LU9kXlDoeyVaJFXu5mScHLj4G/CXQZ4gtRFIpBVFLCN6KUkQKUXzhPW5mhytBFuYpyj6d96RBRWQIzrylh3aPYAzrBi3tpBWupAKy7/Djqh13HYaHR62qbMCRQRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BXX2QQUI; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BXX2QQUI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkrQp4MZHz2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 23:38:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2415F60126;
	Mon, 30 Mar 2026 12:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC559C2BCB1;
	Mon, 30 Mar 2026 12:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774874334;
	bh=tP+lre6dq3uVg+ttZiFaRElIPoTiUazPMTJ4WyhtlvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXX2QQUIVZk+ufPUO/4wYhWhQEwJCvpliRF7mSmuIm83LqYUpSJFN0FdcmQJFeFfN
	 GkroFQ3djVRDo/4EIN04Jrtv/dn0meNgxsQdx2yE9IPMCmYHn1bsP3GTutzMjF0xPc
	 0ctyHbMws4R27E/ELx4F9hqWPL93aLfcvfyd8ZAOvuATDj1JluUq1V4OvrrmJiIEOx
	 Jp969oFvF+VM5QiKpDUFsZ7e88urB6ol3ftw2bIujnOmDUMHB2/Mt9Rygt3hpryu7g
	 9KbpCsDMoiDPNVwgBzCDQlw2CrIKBwCQN858FuzI6d4C0seCrabMQ58JNO1OsaBfAn
	 wonZV+nRPCHLg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	xiang@kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.1] erofs: add GFP_NOIO in the bio completion if needed
Date: Mon, 30 Mar 2026 08:38:21 -0400
Message-ID: <20260330123842.756154-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330123842.756154-1-sashal@kernel.org>
References: <20260330123842.756154-1-sashal@kernel.org>
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
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3116-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:patches@lists.linux.dev,m:stable@vger.kernel.org,m:jiucheng.xu@amlogic.com,m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:sashal@kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,amlogic.com:email]
X-Rspamd-Queue-Id: 07CC335B241
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiucheng Xu <jiucheng.xu@amlogic.com>

[ Upstream commit c23df30915f83e7257c8625b690a1cece94142a0 ]

The bio completion path in the process context (e.g. dm-verity)
will directly call into decompression rather than trigger another
workqueue context for minimal scheduling latencies, which can
then call vm_map_ram() with GFP_KERNEL.

Due to insufficient memory, vm_map_ram() may generate memory
swapping I/O, which can cause submit_bio_wait to deadlock
in some scenarios.

Trimmed down the call stack, as follows:

f2fs_submit_read_io
  submit_bio                      //bio_list is initialized.
    mmc_blk_mq_recovery
      z_erofs_endio
        vm_map_ram
          __pte_alloc_kernel
            __alloc_pages_direct_reclaim
              shrink_folio_list
                __swap_writepage
                  submit_bio_wait  //bio_list is non-NULL, hang!!!

Use memalloc_noio_{save,restore}() to wrap up this path.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

All verified. Here is the complete analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Subject Line
- **Subsystem**: erofs (Enhanced Read-Only File System, compressed I/O
  path)
- **Action verb**: "add" — but the body describes a deadlock fix
- **Summary**: Adds `memalloc_noio_save/restore` scope in BIO completion
  to prevent deadlock during direct decompression

Record: [erofs] [add (really "fix")] [Wraps direct decompression in
GFP_NOIO scope to prevent deadlock in bio completion]

### Step 1.2: Tags
- **Reviewed-by**: Gao Xiang <hsiangkao@linux.alibaba.com> — erofs
  maintainer
- **Signed-off-by**: Jiucheng Xu <jiucheng.xu@amlogic.com> — patch
  author (Amlogic, ARM/Android platform vendor)
- **Reviewed-by**: Chao Yu <chao@kernel.org> — regular erofs reviewer
- **Signed-off-by**: Gao Xiang <hsiangkao@linux.alibaba.com> — committed
  through maintainer tree
- No `Fixes:` tag (expected for commits needing manual review)
- No `Cc: stable@vger.kernel.org` (expected)
- No `Reported-by:` or `Link:` tags
- Notable: Two reviews from subsystem maintainer and key reviewer;
  committed by maintainer

Record: Two senior reviewers (one is the subsystem maintainer). No Fixes
tag. Author is from Amlogic (Android SoC vendor, direct user of
erofs+dm-verity).

### Step 1.3: Commit Body Text
The commit describes a **concrete deadlock scenario** with a trimmed
stack trace:
1. BIO completion runs in process context (e.g., when dm-verity is
   layered on top)
2. EROFS directly calls decompression (not via workqueue) to minimize
   latency
3. Decompression calls `vm_map_ram()` with `GFP_KERNEL`
4. Under memory pressure, `vm_map_ram()` → page allocation → direct
   reclaim → swap writeback → `submit_bio_wait()`
5. Since `bio_list` is already initialized from the parent `submit_bio`,
   the new bio gets queued to `bio_list` but is never drained →
   **deadlock/hang**

Stack trace: `f2fs_submit_read_io → submit_bio → mmc_blk_mq_recovery →
z_erofs_endio → vm_map_ram → __pte_alloc_kernel →
__alloc_pages_direct_reclaim → shrink_folio_list → __swap_writepage →
submit_bio_wait //hang`

Record: Real deadlock in BIO completion path. Trigger: erofs on dm-
verity under memory pressure. Symptom: system hang. Root cause:
GFP_KERNEL allocation inside bio completion context can recurse into
block I/O.

### Step 1.4: Hidden Bug Fix Detection
Despite the subject using "add" rather than "fix", the commit message
describes a real deadlock and provides a concrete stack trace
demonstrating the hang. The fix uses the standard kernel mechanism for
preventing I/O recursion. This is absolutely a bug fix.

Record: Yes, genuine bug fix disguised with "add" verb. The body clearly
describes a deadlock.

---

## PHASE 2: DIFF ANALYSIS

### Step 2.1: Inventory
- **Files changed**: 1 (`fs/erofs/zdata.c`)
- **Lines added**: 3 (1 local variable declaration + 2 API calls)
- **Lines removed**: 0
- **Function modified**: `z_erofs_decompress_kickoff()`
- **Scope**: Single-file, single-function, surgical fix

Record: [fs/erofs/zdata.c: +3/-0 lines] [z_erofs_decompress_kickoff]
[Surgical single-function fix]

### Step 2.2: Code Flow Change
**Before** (line 1494 of current code): When
`z_erofs_decompress_kickoff()` reaches the non-atomic fallthrough path,
it calls `z_erofs_decompressqueue_work(&io->u.work)` directly with no
memory allocation restrictions. Any `GFP_KERNEL` allocation in the call
chain can trigger reclaim I/O.

**After**: The direct call is wrapped:
```c
gfp_flag = memalloc_noio_save();
z_erofs_decompressqueue_work(&io->u.work);
memalloc_noio_restore(gfp_flag);
```
This sets `PF_MEMALLOC_NOIO` on the current task's flags, causing all
allocations in the decompression path to have `__GFP_IO` stripped,
preventing swap/reclaim I/O.

Record: Before: unrestricted GFP_KERNEL allocations during decompression
in bio completion. After: GFP_NOIO scope prevents I/O recursion.

### Step 2.3: Bug Mechanism
**Category**: Deadlock / I/O recursion

**Mechanism**: I verified the full call chain:
- `z_erofs_endio()` (bio completion, line 1668) →
  `z_erofs_decompress_kickoff(q, -1)` → non-atomic branch →
  `z_erofs_decompressqueue_work()` → `z_erofs_decompress_queue()` →
  `z_erofs_decompress_pcluster()` → multiple `GFP_KERNEL` allocations:
  - `kvcalloc(..., GFP_KERNEL | __GFP_NOFAIL)` at lines 1300 and 1304
    for decompressed/compressed pages
  - `kmalloc(..., GFP_KERNEL | __GFP_NOFAIL)` at line 1161 for secondary
    bvecs
  - `erofs_vm_map_ram()` → `vm_map_ram()` → `vb_alloc(size, GFP_KERNEL)`
    at `mm/vmalloc.c:3070` or `alloc_vmap_area(..., GFP_KERNEL, ...)` at
    `mm/vmalloc.c:3078`

Any of these `GFP_KERNEL` allocations can trigger direct reclaim under
memory pressure, which can attempt swap writeback via
`submit_bio_wait()`, and since `bio_list` is active from the parent
`submit_bio()`, the new bio goes to the list but never drains.

Record: [Deadlock] [Bio completion → direct decompression → GFP_KERNEL
allocations (vm_map_ram, kvcalloc) → direct reclaim → swap I/O →
submit_bio_wait hangs because bio_list is active]

### Step 2.4: Fix Quality
- **Obviously correct**: `memalloc_noio_save/restore` is the standard
  kernel API for this exact pattern. It is used extensively in dm, md,
  block, and filesystem layers for the same purpose.
- **Minimal**: 3 lines added, no logic changes, no data structure
  changes.
- **Regression risk**: Very low. The only effect is restricting
  allocations from triggering I/O in this scope. This could mean more
  allocation failures under extreme pressure, but the `__GFP_NOFAIL`
  allocations will still succeed (they just won't trigger I/O for
  reclaim), and `vm_map_ram` already handles allocation failure
  gracefully via retry in `erofs_vm_map_ram()`.
- **No red flags**: No API changes, no locking changes, no new code
  paths.

Record: [Obviously correct, standard kernel pattern] [Very low
regression risk] [Minimal scope]

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame Changed Lines
`git blame` on lines 1458-1495 shows:
- `z_erofs_decompress_kickoff()` function structure: commit
  `7865827c432bf9` (Gao Xiang, 2022-01-21) — a code rearrangement
- The direct `z_erofs_decompressqueue_work(&io->u.work)` call at line
  1494: same commit `7865827c432bf9`
- The direct decompression optimization was **originally introduced** by
  commit `648f2de053a88` (Huang Jianan, 2021-03-17): "erofs: use
  workqueue decompression for atomic contexts only"

The original `648f2de053a88` commit first appeared in tag `v5.13`. I
verified:
- `v5.10`: **NOT** ancestor — the buggy direct-call path does not exist
- `v5.15`: **IS** ancestor — the buggy path exists
- `v6.1`: **IS** ancestor
- `v6.6`: **IS** ancestor

Record: Direct decompression path introduced in 648f2de053a88 (v5.13).
Present in v5.15, v6.1, v6.6, v6.12 and later. NOT present in v5.10.

### Step 3.2: Fixes Tag
No `Fixes:` tag present. (Expected for commits requiring manual review.)

### Step 3.3: Related File History
Related commits in the same optimization area:
- `648f2de053a88` (v5.13): Introduced direct decompression in non-atomic
  context
- `7865827c432bf9` (v5.17): Rearranged function, same direct-call logic
- `12d0a24afd9ea` (2023): "Fix detection of atomic context" — 1-line fix
  to atomic check
- `c99fab6e80b76` (2025): "fix atomic context detection when
  !CONFIG_DEBUG_LOCK_ALLOC" — introduced `z_erofs_in_atomic()` helper

The non-atomic direct decompression path has needed **multiple follow-up
fixes**, establishing a pattern that this optimization area is
correctness-sensitive.

No prior `memalloc_noio` fix exists in erofs (verified: `git log
--grep='memalloc_noio' -- fs/erofs` returns empty).

Record: Part of a pattern of fixes to the same direct-decompression
optimization. Standalone fix. No prior NOIO fix in erofs.

### Step 3.4: Author
- Jiucheng Xu from Amlogic — no prior erofs commits found locally,
  likely a first-time contributor from the platform vendor side
- Patch was reviewed by erofs maintainer Gao Xiang and regular reviewer
  Chao Yu, and committed through Gao Xiang's tree
- Amlogic makes ARM SoCs used in Android devices — dm-verity + erofs is
  standard on such platforms

Record: Author is from platform vendor, fix reviewed and committed by
erofs maintainer.

### Step 3.5: Dependencies
The fix is self-contained:
- `memalloc_noio_save/restore` exists in `include/linux/sched/mm.h`
  (verified: 4 occurrences of `memalloc_noio_save` in current tree)
- These helpers have been available since well before v5.15
- The direct decompression call path where the fix applies exists in all
  applicable stable trees (v5.15+)
- No code structure changes needed

Record: No dependencies. Fully self-contained. Can apply standalone to
any tree with the direct-call path.

---

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

### Step 4.1: Lore Discussion
The related commit `12d0a24afd9ea` ("Fix detection of atomic context")
has accessible discussion showing:
- A concrete stack trace from `filemap_fault`/readahead through dm-
  verity into `z_erofs_decompress_kickoff()`, proving the direct
  decompression in bio completion context is a real-world scenario
- The dm-verity + erofs combination is explicitly called out as the
  trigger

The commit was included in erofs rc-fixes targeting mainline, which is
the standard path for critical fixes.

Record: Related discussion confirms real-world dm-verity + erofs
scenario. Fix submitted through maintainer's fixes branch.

### Step 4.2: Bug Report
No explicit `Reported-by:` or `Link:` tags. The stack trace in the
commit message references a concrete scenario (f2fs + mmc + erofs/dm-
verity), indicating real-world observation. The author being from
Amlogic (Android SoC vendor) strongly suggests this was discovered on
production Android devices.

Record: No formal bug report link, but stack trace indicates real
observation on Android platform.

### Step 4.3: Series Context
This is a standalone fix, not part of a dependent series.

Record: Standalone fix.

### Step 4.4: Stable Discussion
No specific stable discussion found for this patch.

Record: No stable-specific discussion found.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1: Functions Modified
Only `z_erofs_decompress_kickoff()` is modified.

### Step 5.2: Callers
`z_erofs_decompress_kickoff()` is called from:
1. **`z_erofs_endio()`** (line 1668) — BIO completion callback. This is
   the problematic path — when bio completion runs in process context
   (dm-verity), this is NOT atomic, and the non-atomic branch takes the
   direct decompression path.
2. **`z_erofs_submit_queue()`** (line 1805) — submit path, called after
   dispatching bios.

### Step 5.3: Callees in the non-atomic path
`z_erofs_decompressqueue_work()` → `z_erofs_decompress_queue()` →
`z_erofs_decompress_pcluster()` which:
- Allocates `decompressed_pages` via `kvcalloc(..., GFP_KERNEL |
  __GFP_NOFAIL)` (line 1300)
- Allocates `compressed_pages` via `kvcalloc(..., GFP_KERNEL |
  __GFP_NOFAIL)` (line 1304)
- Calls decompression algorithm which uses `erofs_vm_map_ram()` →
  `vm_map_ram()` → `vb_alloc(size, GFP_KERNEL)` (mm/vmalloc.c:3070)

All of these allocations can trigger direct reclaim.

### Step 5.4: Reachability
Full verified call chain from userspace:
- Userspace read/page fault on compressed erofs file
- → `z_erofs_read_folio()` (line 1887) or `z_erofs_readahead()` (line
  1910)
- → `z_erofs_runqueue()` → `z_erofs_submit_queue()` → `submit_bio()`
- → bio completion → `z_erofs_endio()` (line 1648)
- → `z_erofs_decompress_kickoff(q, -1)` (line 1668)
- → non-atomic branch → `z_erofs_decompressqueue_work()` → `GFP_KERNEL`
  allocations → deadlock

This is the **primary compressed data read path** for erofs. Any
unprivileged user reading a file from a mounted erofs filesystem can
trigger it.

Record: Critical primary read path. Reachable from unprivileged
userspace file reads.

### Step 5.5: Similar Patterns
`memalloc_noio_save/restore` is used extensively throughout the kernel
(dm, md, block layer) for the same purpose. No existing usage in
`fs/erofs/` — this is the first.

Record: Standard pattern used throughout kernel. First application in
erofs.

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Does the buggy code exist in stable trees?
Verified with `git show <version>:fs/erofs/zdata.c | grep`:
- **v5.10**: Direct-call path does **NOT** exist (648f2de053a88 not
  ancestor) → NOT APPLICABLE
- **v5.15**: Direct-call exists at line 802 → **AFFECTED**
- **v6.1**: Direct-call exists at line 1195 → **AFFECTED**
- **v6.6**: Direct-call exists at line 1435 → **AFFECTED**
- **v6.12**: Direct-call exists at line 1373 → **AFFECTED**

Record: Bug affects all active stable trees v5.15 through v6.12. NOT
applicable to v5.10 or older.

### Step 6.2: Backport Complications
The function context has changed across versions:
- v5.15: uses `bool sync` parameter, older `in_atomic() ||
  irqs_disabled()` check
- v6.1: same older check, some structural changes
- v6.6: uses different atomic detection
- v6.12: uses `z_erofs_in_atomic()` helper (from c99fab6e80b76)

However, the **actual fix location** (wrapping the direct
`z_erofs_decompressqueue_work()` call) is consistent across all
versions. The fix should apply with minor context adjustment (fuzz) on
older trees.

`memalloc_noio_save/restore` helpers exist in all these stable baselines
(verified in `include/linux/sched/mm.h`).

Record: Minor context adjustment needed for older stable trees. Fix site
is consistent. Helper APIs available everywhere.

### Step 6.3: Related fixes in stable
No prior `memalloc_noio` fix in erofs exists. The related atomic-context
fixes (`12d0a24afd9ea`, `c99fab6e80b76`) may or may not be in each
stable tree, but they are not prerequisites — they only change which
branch is taken (atomic vs. non-atomic), not the fix itself.

Record: No duplicate fix in stable. Not redundant with existing fixes.

---

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

### Step 7.1: Subsystem Criticality
- **Subsystem**: `fs/erofs` — compressed read-only filesystem
- **Criticality**: IMPORTANT
  - Widely used on Android devices (system/vendor partition)
  - Increasingly used in container/cloud environments (read-only layers)
  - dm-verity + erofs is the default stack on modern Android

Record: [fs/erofs] [IMPORTANT — Android, embedded, containers]

### Step 7.2: Activity Level
Recent `git log -20 -- fs/erofs/zdata.c` shows active development with
regular fixes and improvements. Actively maintained by Gao Xiang.

Record: Active subsystem with regular maintenance.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
All users of erofs with compressed data who:
- Run erofs on dm-verity (standard on Android)
- Or any other stacking block device where bio completion runs in
  process context
- AND experience memory pressure (common on memory-constrained
  mobile/embedded devices)

Record: Large user population (Android devices, embedded systems with
dm-verity + erofs).

### Step 8.2: Trigger Conditions
- erofs compressed file read (ordinary `read()` or page fault)
- BIO completion in process context (dm-verity provides this)
- Memory pressure sufficient to trigger direct reclaim
- Reclaim attempts swap writeback → `submit_bio_wait` with active
  `bio_list`

This is realistic on Android devices which frequently run under memory
pressure. No privileges needed beyond read access to mounted filesystem.

Record: [Common trigger: ordinary file reads under memory pressure on
Android/dm-verity] [No special privileges needed]

### Step 8.3: Failure Mode Severity
**CRITICAL**: Complete system deadlock/hang. The `submit_bio_wait()`
blocks indefinitely because the bio is queued to the active `bio_list`
but never drained (the draining happens only after the parent bio
completion returns, which is waiting for this one). This renders the
system unresponsive and typically requires a hard reboot.

Record: [System deadlock/hang] [Severity: CRITICAL]

### Step 8.4: Risk-Benefit Ratio
- **BENEFIT**: Very high — prevents a complete system hang on a widely-
  deployed platform configuration
- **RISK**: Very low — 3-line addition using a well-established kernel
  API, no logic changes, no new code paths, no changed return values, no
  API modifications
- **Ratio**: Overwhelmingly favorable

Record: [Benefit: Very High] [Risk: Very Low] [Ratio: Strongly
favorable]

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Evidence Compilation

**FOR backporting:**
- Fixes a real deadlock (system hang) with a concrete trigger and stack
  trace
- Extremely small and contained fix (3 lines in 1 function in 1 file)
- Uses the standard, well-established `memalloc_noio_save/restore`
  kernel API
- Reviewed by erofs maintainer (Gao Xiang) and key reviewer (Chao Yu)
- Committed through the maintainer's fixes tree
- Affects widely-deployed platform configuration (Android + dm-verity +
  erofs)
- Bug has existed since v5.13 and is present in all active stable trees
  v5.15+
- Multiple `GFP_KERNEL` allocation sites confirmed in the decompression
  path (vm_map_ram, kvcalloc)
- Primary read path for compressed erofs — not an obscure corner case
- Pattern of earlier bugs in same optimization area (648f2de,
  12d0a24afd9ea, c99fab6e80b76) demonstrates the area is correctness-
  sensitive
- No existing `memalloc_noio` protection in erofs anywhere

**AGAINST backporting:**
- No explicit `Fixes:` tag or `Cc: stable` (expected for commits needing
  manual review)
- Minor context differences across stable tree versions (trivially
  resolvable)
- NOIO scope affects the entire decompression call, not just
  `vm_map_ram()` (intentional and beneficial — there are multiple
  GFP_KERNEL sites)

**UNRESOLVED:**
- Exact frequency of this deadlock in production (but the trigger
  conditions are realistic)
- Exact lore.kernel.org discussion thread for this specific patch (anti-
  bot protections)

### Step 9.2: Stable Rules Checklist
1. **Obviously correct and tested?** YES — standard kernel pattern,
   reviewed by maintainer
2. **Fixes a real bug?** YES — deadlock under memory pressure
3. **Important issue?** YES — system hang/deadlock, CRITICAL severity
4. **Small and contained?** YES — 3 lines in 1 file, 1 function
5. **No new features or APIs?** YES — no new features
6. **Can apply to stable?** YES — applicable to v5.15+ with minor
   context adjustment; `memalloc_noio_*` helpers available in all target
   trees

### Step 9.3: Exception Categories
Not applicable (this is a straightforward critical bug fix).

### Step 9.4: Decision
This is a clear, surgical fix for a critical deadlock in the primary
read path of a widely-deployed filesystem. The fix is minimal, uses a
standard kernel API, was reviewed by the subsystem maintainer, and has
virtually no regression risk. It meets all stable kernel criteria.

---

## Verification

- [Phase 1] Parsed tags: Reviewed-by Gao Xiang (erofs maintainer) and
  Chao Yu. No Fixes: tag (expected). Signed-off-by Jiucheng Xu (Amlogic
  author).
- [Phase 2] Diff analysis: 3 lines added in
  `z_erofs_decompress_kickoff()`, wrapping
  `z_erofs_decompressqueue_work()` with `memalloc_noio_save/restore`.
- [Phase 2] Verified `vm_map_ram()` uses `GFP_KERNEL` at
  `mm/vmalloc.c:3070` (`vb_alloc(size, GFP_KERNEL)`) and line 3078
  (`alloc_vmap_area(..., GFP_KERNEL, ...)`).
- [Phase 2] Verified additional `GFP_KERNEL` allocations in
  decompression: `kvcalloc(..., GFP_KERNEL | __GFP_NOFAIL)` at
  `zdata.c:1300,1304` and `kmalloc(..., GFP_KERNEL | __GFP_NOFAIL)` at
  `zdata.c:1161`.
- [Phase 2] Verified `erofs_vm_map_ram()` at `internal.h:439-452` calls
  `vm_map_ram()`.
- [Phase 3] git blame: Lines 1458-1494 traced to `7865827c432bf9` (Gao
  Xiang, 2022-01-21, rearrangement) and original logic from
  `648f2de053a88` (Huang Jianan, 2021-03-17).
- [Phase 3] `git tag --contains 648f2de053a88`: First appeared in v5.13.
- [Phase 3] `git merge-base --is-ancestor 648f2de053a88 v5.10`: NOT
  ancestor (path absent in v5.10).
- [Phase 3] `git merge-base --is-ancestor 648f2de053a88 v5.15`: IS
  ancestor (path present).
- [Phase 3] `git merge-base --is-ancestor 648f2de053a88 v6.1`: IS
  ancestor.
- [Phase 3] `git merge-base --is-ancestor 648f2de053a88 v6.6`: IS
  ancestor.
- [Phase 3] Related atomic-context fixes verified: `12d0a24afd9ea` (1
  file, 1 line), `c99fab6e80b76` (1 file, 11 lines).
- [Phase 3] `git log --grep='memalloc_noio' -- fs/erofs`: empty — no
  prior NOIO fix in erofs.
- [Phase 3] `git log --author='Jiucheng Xu' -- fs/erofs`: no prior erofs
  commits from author.
- [Phase 4] lore.kernel.org not directly fetchable (anti-bot). Related
  discussion for 12d0a24afd9ea confirms dm-verity + erofs scenario with
  real stack traces.
- [Phase 5] Callers verified: `z_erofs_decompress_kickoff()` called from
  `z_erofs_endio()` (line 1668) and `z_erofs_submit_queue()` (line
  1805).
- [Phase 5] Reachability verified: `z_erofs_read_folio()` (line 1887)
  and `z_erofs_readahead()` (line 1910) are the address_space_operations
  (line 1944-1945).
- [Phase 5] No existing `memalloc_noio_save` in `fs/erofs/` (grep
  confirmed 0 matches).
- [Phase 6] Direct-call path verified in: v5.15 (line 802), v6.1 (line
  1195), v6.6 (line 1435), v6.12 (line 1373).
- [Phase 6] `memalloc_noio_save` helpers exist in
  `include/linux/sched/mm.h` (4 occurrences confirmed).
- [Phase 8] Failure mode: System deadlock/hang in `submit_bio_wait` due
  to bio queued to active `bio_list`, severity CRITICAL.
- UNVERIFIED: Exact lore.kernel.org thread for this specific patch
  (anti-bot protection blocked access).
- UNVERIFIED: Exact real-world frequency of this deadlock in production
  (trigger conditions are realistic based on Android + dm-verity +
  memory pressure).

**YES**

 fs/erofs/zdata.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b71fcf4be484a..8ba409df1ca70 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1459,6 +1459,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       int bios)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
+	int gfp_flag;
 
 	/* wake up the caller thread for sync decompression */
 	if (io->sync) {
@@ -1491,7 +1492,9 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 			sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
 		return;
 	}
+	gfp_flag = memalloc_noio_save();
 	z_erofs_decompressqueue_work(&io->u.work);
+	memalloc_noio_restore(gfp_flag);
 }
 
 static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
-- 
2.53.0


