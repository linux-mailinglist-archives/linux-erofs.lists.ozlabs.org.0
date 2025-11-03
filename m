Return-Path: <linux-erofs+bounces-1331-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A95CAC2C813
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:57:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZSw3SJnz2yrm;
	Tue,  4 Nov 2025 01:57:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181872;
	cv=none; b=mP+imhbguF2E+XrHn7jK5MEgBOt2wEV5DitfZ4GVwhRa1e3Vo2chEeoEniBpFv8yKe98COg4+tP1fa42KIEDRSWivTb4HeNkH4QjpukyCdDhr3hUt+YnTXtFVKi0X9WA7wfAclq0U1/wgPOU1/cu1PpKtQuhfoZmGaKQEKmLJddcyeV/qXml+x9m9ZQLuAuyPid7mvyO1VdnUhRevStPXmYfXdIqxNZsamTnEnn5Hb4VbK3Q0UmWPVolFnMM59JPbpHmfYGyj89zNjTVsWd1QB7/o/zkUU93tA7pxCW3QA53y1CaCKbWYEdUyiLsX7FaJjrd6Fslr0tp1hDTK4Yw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181872; c=relaxed/relaxed;
	bh=5l4ptmGTWprb5gI9LjUp2bi7HAOFs4nxbgDjjfM4Cjc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ddzPf/gd6k1UqYaJvR4C50Rdmv7qqBpHMAiMXpP1opo9QcbqvZ4UZgLp+F4GYusTMB2dKDv+XO1t9TGtSvWk4FL5e1YJPVlBJtkprH5PsTjM2nO+twHPCTXxAiZdDKNWYodbZDHBHUpoml+sD4XUjkEcsIDWbIsukLRLc4vk157Wbf04Dw2vq0/6/w7LcQDfgZaNT010Ste0taO0/ouL2lrPU0o6qT1mR+/NUsOJjH3im5np0SNhYI1oZ8ctrrMeoFBWzrou08jZkUGRa4KLJsAxYnl/iJ45ZrzsAkRQOtIsfAkEnr/qdEq6WQJTrGeOMGfUwFBNxTcqU1/loXmyGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JopLWCYf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JopLWCYf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZSv6KB3z2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:57:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F375B6013E;
	Mon,  3 Nov 2025 14:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5322C4CEE7;
	Mon,  3 Nov 2025 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181868;
	bh=JXDW7P6E9z56BXNMj15VvrGXF4N3b0bWA60p7x5LQqQ=;
	h=From:Subject:Date:To:Cc:From;
	b=JopLWCYfHSrSbznS4ihVysckhWf8JMMnvb0Hif1kKondAOJjQ7Dx9G54BJiNcd7Gk
	 posKi1BWWDrqStGY2hjE0V6DFH6kMtLNhkV4B/AAD4UYY6OyUwvS4wD35v4tNtmaiD
	 ipRNu81q3J8lI/vplWFqmt9nFmbF4qsfRvCnusKA+V1QsubpfvUPNGiTPMvXXkvJuV
	 mlkbBMGP3lw4PtpfZIRCWEQ9J6HtSx5euh/4C7ZgjXTgZ6Lu+defSs/qcl9qf614CH
	 Y3X4gKIE3YNdRZ4yRQdz0GHPX2F1rJ5vniRDrpdKKBxW5M6TFIr8pxL+ePvuJofZDw
	 tvyGE00aHeqbw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/12] credential guards: credential preparation
Date: Mon, 03 Nov 2025 15:57:26 +0100
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANbCCGkC/yWN3QqDMAyFX0VyvZa2wwl7lTGk1qhhWy0J+wHx3
 Rf1KnzncL4sIMiEAtdqAcYPCc1ZwZ8qSFPMIxrqlSG4UHvvzuY788Mkxl7M+I6spzCWyNgeoXc
 emzqEy9A4UIu2A/32D7e7chcFTccxp2nzbjq7L+2hs0Kv8kRY1z94xaNanAAAAA==
X-Change-ID: 20251103-work-creds-guards-prepare_creds-101e75226f70
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JXDW7P6E9z56BXNMj15VvrGXF4N3b0bWA60p7x5LQqQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrxnWHFbIufseyLvsUV3/KtOvVs2ZUXuhP130w9/
 OjalYgl0R2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATec/KyHCk5pabi6vlwvDm
 zWt6LZ5XsX/bt7b9z+eMy6su+d3YGf2IkWH/e4HWO9eVNx054XPncMgJvXWqtV6zU2Sn7oiMFP+
 9S4sVAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This converts most users combining

* prepare_creds()
* modify new creds
* override_creds()
* revert_creds()
* put_cred()

to rely on credentials guards.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (12):
      cred: add prepare credential guard
      sev-dev: use guard for path
      sev-dev: use prepare credential guard
      sev-dev: use override credential guards
      coredump: move revert_cred() before coredump_cleanup()
      coredump: pass struct linux_binfmt as const
      coredump: mark struct mm_struct as const
      coredump: split out do_coredump() from vfs_coredump()
      coredump: use prepare credential guard
      coredump: use override credential guard
      trace: use prepare credential guard
      trace: use override credential guard

 drivers/crypto/ccp/sev-dev.c     |  15 ++---
 fs/coredump.c                    | 142 +++++++++++++++++++--------------------
 include/linux/cred.h             |   5 ++
 include/linux/sched/coredump.h   |   2 +-
 kernel/trace/trace_events_user.c |  15 ++---
 5 files changed, 86 insertions(+), 93 deletions(-)
---
base-commit: bcbcea89c608394efecb35237fa9fc1bf5f349d1
change-id: 20251103-work-creds-guards-prepare_creds-101e75226f70


