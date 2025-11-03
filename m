Return-Path: <linux-erofs+bounces-1339-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63DC2C834
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:58:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZTQ6Ldcz3bf1;
	Tue,  4 Nov 2025 01:58:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181898;
	cv=none; b=iHRogy/Vomk5SUJ0RvrChGFQFfeRG6gcmq6xOYx8p1vgyUyioS1A9J8eeMG6XdGofyvxYlELODda4EQ7fu0Z9k+GMmM60abuvH7YbbVbgzwugIsHjmz4WNeOVIy5ejGcD3qdo+EV49PmMeKXDFzVCbrRYmIz+3pP5pHdDFtuJ+u94F9blkq0HCq9HJFK4bj3zKkj/y1I0UhxEF1JgqD0ciFeBcBPt50ORxhut1YGSCP55j3PQmwN+qX7zhnShzKAQJyv9X++xmjMkNPNv/KagyK5Yus8lZfRU9OBcU8QWowQ4qVVCSyjJ5pdQu6BJetdrXJaUYT/UDFasnhQpcQ8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181898; c=relaxed/relaxed;
	bh=ETVYVf9HkJgcXaeThm5fCA1ct2f2eHxeh7hkGKvZjpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgxS2Tk5u54PuQJc8ojWBUeN8/T457f2bjAr9AdidWFickndyonIrW908Tyy3eJqXXcr9nkfXIoDbjv8CjewYn0LHfRwKZt6AORR+UkOdmquIvZHT4e2PdXAe27B2q7tNNabVQXtQ0ClzglxagnEO2dL3D49wdzVZ7CHd4fkS1AQoLtzi/74wRRxgSfDFWnLHi01va9B3vjEMXKG+JjDNE+ZKWPXQmNEtgiBRhkSlY362aom0sDIDT3ro2ikJBUaUUnQNjJLPhN6dKvyLEGio3JdEWGZSqvzZ4CFGnTr6n+/8/Vy4TI0oY9kh61ABRI6CtlqY50mU6K8qnc87ISy/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C2N09nCE; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C2N09nCE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZTQ17hWz2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:58:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C12C601B7;
	Mon,  3 Nov 2025 14:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18630C4CEFD;
	Mon,  3 Nov 2025 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181896;
	bh=3SOHcCNtJai0jiEeFwDApQD/S8x6jH+uzaK2QaiBxx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C2N09nCE2+2V+HW48Wm/8xl8T3Vs8shmBL2PzA64cpY2NjZv0TZ1uBu113H5CVGUs
	 EIyuggylugy1YAjqFJ0MnPVsslM9K1zthxOVsJAaezo2jCSqpPZh7Tbnj8HidnJ0TL
	 7c4Jzs/R/fB+qKavyrWiLeVudH93nJTZddLVeumTJXbyrKouxsaiimk9gBmosy2RUg
	 cnYZJP8rHuq+nlQL0IEmY/WnyYSG+gLwW/Zj7U921FCiFxyaiaunfjlGlODqdahK8m
	 SIoYI+3SzIj9gb4JTV/Cq8k7QI7yoz2habV+V908LDCAsoWQfTf5MRgBq7IfvbK1ZG
	 wuuNTqG+YFw2w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:34 +0100
Subject: [PATCH 08/12] coredump: split out do_coredump() from
 vfs_coredump()
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
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-8-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=4185; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3SOHcCNtJai0jiEeFwDApQD/S8x6jH+uzaK2QaiBxx8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrpENDx8pHFoi2H5317oP34Z/jR3KMOi5/83viya
 RrDlOUfJnWUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBMROsmw3/nghPNR/u3azIl
 LkpZocCh1tZ2Zx//pAsrTy1+G7vjTawRwz8F5ZnNO/Ylyd7eMoO7/eC3E+zhHy+93lWTrjH9glk
 VpzI/AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Make the function easier to follow and prepare for some of the following
changes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 131 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 68 insertions(+), 63 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 8253b28bc728..79c681f1d647 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1086,6 +1086,73 @@ static inline bool coredump_skip(const struct coredump_params *cprm,
 	return false;
 }
 
+static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
+			size_t **argv, int *argc, const struct linux_binfmt *binfmt)
+{
+	if (!coredump_parse(cn, cprm, argv, argc)) {
+		coredump_report_failure("format_corename failed, aborting core");
+		return;
+	}
+
+	switch (cn->core_type) {
+	case COREDUMP_FILE:
+		if (!coredump_file(cn, cprm, binfmt))
+			return;
+		break;
+	case COREDUMP_PIPE:
+		if (!coredump_pipe(cn, cprm, *argv, *argc))
+			return;
+		break;
+	case COREDUMP_SOCK_REQ:
+		fallthrough;
+	case COREDUMP_SOCK:
+		if (!coredump_socket(cn, cprm))
+			return;
+		break;
+	default:
+		WARN_ON_ONCE(true);
+		return;
+	}
+
+	/* Don't even generate the coredump. */
+	if (cn->mask & COREDUMP_REJECT)
+		return;
+
+	/* get us an unshared descriptor table; almost always a no-op */
+	/* The cell spufs coredump code reads the file descriptor tables */
+	if (unshare_files())
+		return;
+
+	if ((cn->mask & COREDUMP_KERNEL) && !coredump_write(cn, cprm, binfmt))
+		return;
+
+	coredump_sock_shutdown(cprm->file);
+
+	/* Let the parent know that a coredump was generated. */
+	if (cn->mask & COREDUMP_USERSPACE)
+		cn->core_dumped = true;
+
+	/*
+	 * When core_pipe_limit is set we wait for the coredump server
+	 * or usermodehelper to finish before exiting so it can e.g.,
+	 * inspect /proc/<pid>.
+	 */
+	if (cn->mask & COREDUMP_WAIT) {
+		switch (cn->core_type) {
+		case COREDUMP_PIPE:
+			wait_for_dump_helpers(cprm->file);
+			break;
+		case COREDUMP_SOCK_REQ:
+			fallthrough;
+		case COREDUMP_SOCK:
+			coredump_sock_wait(cprm->file);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct cred *cred __free(put_cred) = NULL;
@@ -1133,70 +1200,8 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 
 	old_cred = override_creds(cred);
 
-	if (!coredump_parse(&cn, &cprm, &argv, &argc)) {
-		coredump_report_failure("format_corename failed, aborting core");
-		goto close_fail;
-	}
-
-	switch (cn.core_type) {
-	case COREDUMP_FILE:
-		if (!coredump_file(&cn, &cprm, binfmt))
-			goto close_fail;
-		break;
-	case COREDUMP_PIPE:
-		if (!coredump_pipe(&cn, &cprm, argv, argc))
-			goto close_fail;
-		break;
-	case COREDUMP_SOCK_REQ:
-		fallthrough;
-	case COREDUMP_SOCK:
-		if (!coredump_socket(&cn, &cprm))
-			goto close_fail;
-		break;
-	default:
-		WARN_ON_ONCE(true);
-		goto close_fail;
-	}
-
-	/* Don't even generate the coredump. */
-	if (cn.mask & COREDUMP_REJECT)
-		goto close_fail;
-
-	/* get us an unshared descriptor table; almost always a no-op */
-	/* The cell spufs coredump code reads the file descriptor tables */
-	if (unshare_files())
-		goto close_fail;
-
-	if ((cn.mask & COREDUMP_KERNEL) && !coredump_write(&cn, &cprm, binfmt))
-		goto close_fail;
-
-	coredump_sock_shutdown(cprm.file);
-
-	/* Let the parent know that a coredump was generated. */
-	if (cn.mask & COREDUMP_USERSPACE)
-		cn.core_dumped = true;
-
-	/*
-	 * When core_pipe_limit is set we wait for the coredump server
-	 * or usermodehelper to finish before exiting so it can e.g.,
-	 * inspect /proc/<pid>.
-	 */
-	if (cn.mask & COREDUMP_WAIT) {
-		switch (cn.core_type) {
-		case COREDUMP_PIPE:
-			wait_for_dump_helpers(cprm.file);
-			break;
-		case COREDUMP_SOCK_REQ:
-			fallthrough;
-		case COREDUMP_SOCK:
-			coredump_sock_wait(cprm.file);
-			break;
-		default:
-			break;
-		}
-	}
+	do_coredump(&cn, &cprm, &argv, &argc, binfmt);
 
-close_fail:
 	revert_creds(old_cred);
 	coredump_cleanup(&cn, &cprm);
 	return;

-- 
2.47.3


