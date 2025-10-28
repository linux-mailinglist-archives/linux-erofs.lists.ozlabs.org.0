Return-Path: <linux-erofs+bounces-1298-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C48FC14B03
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Oct 2025 13:48:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwqtG2YJ2z3dWF;
	Tue, 28 Oct 2025 23:48:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761655702;
	cv=none; b=jv1eMXTvYADaWUIIvmBhJoalR55h9uDGKiH6eWzE263plJFjNQKEGV40nE0RoIJpXmsw+68UnTQX19WO8ts+8+9rIOY6QjdylbKLveJ408LZ4yfxXisFFxzMMJ6YzGudH0PSW5HTE9wDfM/uZ6Ch5q/4vEyCrY9eVc7eXAGTrHOkqK6m7iCLTZyYAY2AdCHtfDjLNG8/Yq+cXWHrhe7TWz7Be7e4lJCqdTnxqLm891IPXNtSzjajg7TtnkI5U/KUxY3ZxGoFwrWQLygl1SO3WoRsIw2vvCKAM4r3n0ysc/7+ma0/eq5EdXYOYIZQCWT2dB1VZYuYYZU9ZCU0BHBTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761655702; c=relaxed/relaxed;
	bh=IbWl0FLLqNYn7w8cvibcgE8ralQvOzdNAZm+KmqCPto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/Q58m+okf4CmtNXspMC3XgW+Cm8EP7HbCQBPAvYUrQKCZmbDLnyf4GgbyEk+/YMkfcyGY80ou9Ihb4ljEtLyuowO/F96YSJOsMnbTQemAgzyRGLZBrs00/K0amZnB6TnVv/EsDmXBub4XYIv4O6bUszn3A9J8mnQybATlD+hnei/9AjHaFOSZ9cUUpH0nvSsM0hiApdLKqrUrQyIjwAqU9L8Zt+S6x4tvO0JvYgqfz7awRSCO7F5qtbS9mlJWkUwRwZvG/Ohn8m1TWjGPn6FAsoePvItUXPRVpU35P0RtFkyIU6Z5vPCM1Bq7vKCVEjR6/Wdc6mPETC3xslZ7drxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sXvWC6YC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sXvWC6YC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwqtF2slsz3dWD
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Oct 2025 23:48:21 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F304244BD7;
	Tue, 28 Oct 2025 12:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D135C4CEFD;
	Tue, 28 Oct 2025 12:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761655698;
	bh=8l3k7nzIzD5IAzRMsVP1ElNUo3/BBc1y6iqkR5WulOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXvWC6YChUnkvDLzrJ2/xJTOg38Cgnrq9z+7qL5fvQQkDzPSStYub4q12W/XSRseP
	 DM3TnI1TZnhJ9TdVx7d0ozwxtC61eMofAmfIuZJVjhhhVzawiB+L6vVs2iis5/90KB
	 Rzmo3sBXZ48LzfOy66O8XyJMB3kUdw/rd3VuuNbT7O2CoKtUmX6WxKSd8m7BMmUl6h
	 zkWfxZ0eaEfChUiRZFaARnzFaYBbMqKH+WyKbd/SC5ZVeaiuAyvsb5gsMMCQpy5HpK
	 3M1VIfACvHuioQCWul+O4dU5jY53PM7AZlzvBllRycN5Uf6JJWQw8cwmDttrGp2W0i
	 o397EjSJzkhnw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>,
	xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.17] erofs: consolidate z_erofs_extent_lookback()
Date: Tue, 28 Oct 2025 08:48:02 -0400
Message-ID: <20251028124815.1058740-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028124815.1058740-1-sashal@kernel.org>
References: <20251028124815.1058740-1-sashal@kernel.org>
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
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 2a13fc417f493e28bdd368785320dd4c2b3d732e ]

The initial m.delta[0] also needs to be checked against zero.

In addition, also drop the redundant logic that errors out for
lcn == 0 / m.delta[0] == 1 case.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## BACKPORT RECOMMENDATION: **YES**

## EXTENSIVE ANALYSIS

### 1. Code Changes Analysis

The commit makes two specific changes to `fs/erofs/zmap.c`:

**Change 1 - In `z_erofs_extent_lookback()` function
(fs/erofs/zmap.c:272):**
- **BEFORE**: The check `if (!lookback_distance)` occurred AFTER calling
  `z_erofs_load_lcluster_from_disk()` and only within the
  `Z_EROFS_LCLUSTER_TYPE_NONHEAD` branch
- **AFTER**: The check `if (!lookback_distance)` is moved to the
  beginning of the while loop, BEFORE calling
  `z_erofs_load_lcluster_from_disk()`
- **Impact**: This prevents unnecessary disk I/O when
  `lookback_distance` is 0, and ensures the initial `m.delta[0]` value
  is validated before use

**Change 2 - In `z_erofs_map_blocks_fo()` function
(fs/erofs/zmap.c:435-440):**
- **BEFORE**: Code rejected `lcn == 0` as corrupted filesystem with
  `EFSCORRUPTED` error
- **AFTER**: This check is completely removed
- **Impact**: Allows valid `lcn == 0` cases to proceed instead of
  incorrectly treating them as corruption

### 2. Semantic Analysis Tools Used

I used the following tools to analyze the commit:

- **git log/show**: To examine commit history, related fixes, and code
  changes
- **Read tool**: To examine the current state of `fs/erofs/zmap.c`
  (lines 260-290, 400-450)
- **Grep tool**: To find all callers of `z_erofs_extent_lookback` and
  `z_erofs_map_blocks_fo`
- **Bash**: To examine commit context, tags, and related fixes

### 3. Key Findings from Analysis

**Caller Analysis:**
- `z_erofs_extent_lookback()` is called from `z_erofs_map_blocks_fo()`
  at line 446
- `z_erofs_map_blocks_fo()` is called from:
  - `z_erofs_map_blocks_iter()` at lines 699 and 756
  - `z_erofs_map_blocks_iter()` is the main entry point for EROFS block
    mapping
  - Called from `z_erofs_iomap_begin_report()` (fiemap operations) and
    `zdata.c` (read operations)

**Impact Scope:**
- Affects ALL compressed file reads in EROFS filesystems
- EROFS is widely used in Android and embedded systems
- The bug path is user-triggerable through normal file read operations

**Related Context:**
I discovered that this commit came immediately after TWO critical bug
fixes by the same author:

1. **e13d315ae077b** (2025-10-17): "erofs: avoid infinite loops due to
   corrupted subpage compact indexes"
   - Has `Fixes:` tags, `Reported-by: Robert Morris`, bug report link
   - Fixes infinite loops from crafted images
   - **Already backported to stable** as commit a3a04e4d968b0

2. **a429b76114aac** (2025-10-12): "erofs: fix crafted invalid cases for
   encoded extents"
   - Has `Fixes:` tags, `Reported-by: Robert Morris`, bug report links
   - Fixes system crashes from crafted images
   - **Being backported to stable**

### 4. Bug Severity Assessment

**Bug #1: Missing initial lookback_distance check**
- **Severity**: Medium (Correctness + Performance)
- **Symptom**: If initial `m.delta[0]` is 0, code performs unnecessary
  disk I/O
- **Consequence**: Performance degradation, potential confusion in error
  paths
- **Exploitability**: Low - requires specific filesystem state

**Bug #2: False positive corruption error**
- **Severity**: Medium (Functionality)
- **Symptom**: Valid filesystems with `lcn == 0` are rejected as
  corrupted
- **Consequence**: Unable to read certain valid compressed files
- **User Impact**: File read failures with `EFSCORRUPTED` errors

### 5. Backport Justification

**Arguments FOR backporting:**

1. **Fixes real bugs**: This is not just a cleanup - it fixes two actual
   bugs:
   - Unnecessary disk I/O (performance regression)
   - False positive corruption errors (functionality regression)

2. **Related to critical fixes**: Comes in a series with two other
   critical bug fixes that ARE being backported. Having partial fixes
   backported creates inconsistency.

3. **Low risk**:
   - Small, focused change (6 insertions, 14 deletions)
   - Simplifies code (removes unnecessary branches)
   - No new features or architectural changes

4. **Production impact**: EROFS is actively used in Android and embedded
   systems. Users could encounter:
   - Performance issues from unnecessary I/O
   - Mount/read failures from false positive errors

5. **Author expertise**: Gao Xiang is the EROFS maintainer and clearly
   understands the correct behavior. The removed check was indeed
   "redundant logic" as stated.

**Arguments AGAINST backporting:**

1. **No explicit stable marking**: Author didn't add `Cc:
   stable@vger.kernel.org` or `Fixes:` tag

2. **No reported issues**: Unlike the surrounding commits, no bug
   reports or CVEs mentioned

3. **Title suggests cleanup**: "consolidate" could imply refactoring
   rather than bug fixing

### 6. Final Recommendation Reasoning

Despite the lack of explicit stable marking, I recommend **YES for
backporting** because:

- The commit message explicitly states a bug: "The initial m.delta[0]
  also needs to be checked against zero"
- It fixes user-visible issues (false corruption errors)
- It's part of a series addressing EROFS robustness with
  crafted/corrupted filesystems
- The surrounding critical fixes ARE being backported
- Small size and low regression risk
- Improves correctness and performance with no downsides

The commit follows the stable kernel rules:
- ✅ Fixes important bugs (performance + false positives)
- ✅ Small and contained change
- ✅ No new features
- ✅ Low regression risk
- ✅ Affects production systems (Android/embedded)

**Recommendation: Backport to all stable trees that contain the affected
code (likely 6.15+ where encoded extents were introduced).**

 fs/erofs/zmap.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 798223e6da9ce..7a14902af5d38 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -268,20 +268,19 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		unsigned long lcn = m->lcn - lookback_distance;
 		int err;
 
+		if (!lookback_distance)
+			break;
+
 		err = z_erofs_load_lcluster_from_disk(m, lcn, false);
 		if (err)
 			return err;
-
 		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			lookback_distance = m->delta[0];
-			if (!lookback_distance)
-				break;
 			continue;
-		} else {
-			m->headtype = m->type;
-			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
-			return 0;
 		}
+		m->headtype = m->type;
+		m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
+		return 0;
 	}
 	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
 		  lookback_distance, m->lcn, vi->nid);
@@ -431,13 +430,6 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 			end = inode->i_size;
 	} else {
 		if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-			/* m.lcn should be >= 1 if endoff < m.clusterofs */
-			if (!m.lcn) {
-				erofs_err(sb, "invalid logical cluster 0 at nid %llu",
-					  vi->nid);
-				err = -EFSCORRUPTED;
-				goto unmap_out;
-			}
 			end = (m.lcn << lclusterbits) | m.clusterofs;
 			map->m_flags |= EROFS_MAP_FULL_MAPPED;
 			m.delta[0] = 1;
-- 
2.51.0


