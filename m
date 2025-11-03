Return-Path: <linux-erofs+bounces-1337-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F63C2C82E
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 15:58:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0ZTH6YWbz3bd8;
	Tue,  4 Nov 2025 01:58:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762181891;
	cv=none; b=Q7wDcgO2HB8OyFXoQ+y5k9kL8c56H2kLkhZnj6yIdMOD/3RRwOtCpocz5lxHtNtKt7LH0s8SifYjwkcV8/bxchb5qNyI2v4Yx/0MXzOgyfh/fOnt11yKPme9toups1OZsDWFzEs3iWj0rRTb/1SYOj9ZgJuiMtE67QhRYUtpyuKtiwRE4eoc2YYT4IUwaRfY/s8y/bIuAx0Oon03eKxbrvB56/nOOEjJ554QHR67Kc/cewl4SHwo4g2uNdpSv0QYLJFh9XyQ03KTMbN/VgEvbDR/cDHLTbaoT6mMvlgwCP4p4GlGqEPjjF+aJ3Y6lnGlzaVPi0mGentVyLRxJRVlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762181891; c=relaxed/relaxed;
	bh=KOT6WDXmVIPdqfzo1aG+RdA5V1/Ol69ef5EJriH/y0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTMrqfOatL6w/MhRnhjwzR6+lqQXb0/z/9s56fL37vVGym5ZQt4vQ+1hGCmn2xzpT/IW60aj/ym5pAERjBRlfTAEDv46DZWx875IusV5EcrPNvbYtEAvAZjk0DN5AmadFKZQM4yp5JcX0LCBOok60516UT+13JVoOD8yOmHE9h9s3JArpB+zeAEwtg13DP8wlCURrEiBWV6/lp9VEZ5Wu7ra0U9DEAt6IvBNWP0V0rqStkkwvKLLBYGXlXspjsqACK+Z+pjoRsSLWKdZRomQixXNv+UVHc+KeE/V50Psgf3RlLmm1vkVC9yGfy7gkl62wLGZN/g41b9HrAGOHQjMwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rm5ipfPk; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rm5ipfPk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0ZTH2VVpz2xnx
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 01:58:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 77BFB601B3;
	Mon,  3 Nov 2025 14:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39356C16AAE;
	Mon,  3 Nov 2025 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181889;
	bh=EP4X5ZOadtmMtGSodwXabbolR1oPbrjawwY7HhpdVyM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rm5ipfPkZ5jOLNVd7v3x/bd/uiTsZuAeEfY3O1BbacTQ3mrXb++tbKrh3zNkQe1Ot
	 yLbfg3VXH7/HRMXuoqg57AWBiQTRY9r5VeQ5gVNQQUkMLGSX5zRwQcjqniDDbXM7Zi
	 8uT77iMIEoOWEH2GArUKwPp5sI23+tagAEh5Q0Lw0Dag8PY3NqLmB+JosSWOcqhodr
	 B/wzXIKtPZehf9KpsBMWEs7LrD0EONuhAA3cZtASk35iQvDjzdbQtru8V7jzgPlGVV
	 fPwok5yQBon3DDQgONY6xml7axr8vbcBYWidVXaQXSTbO1KVVpalPYw9wa4CSxPgRu
	 50yJso83WxuvQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:32 +0100
Subject: [PATCH 06/12] coredump: pass struct linux_binfmt as const
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
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-6-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EP4X5ZOadtmMtGSodwXabbolR1oPbrjawwY7HhpdVyM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHpZkJ72rDJgX35OmNX/XUm22Z4y+3M884MOOq7sk
 lJ70zS9o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLJfxj+cJivjbN0+el3Ut7y
 1Hm51Wklp410S6P/bdLanhsWeCmch5HhlmLgXuNTbcff8Pf9OpA89d0T/U65s1PUpc/yZ349Jqn
 BDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

We don't actually modify it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 4fce2a2f279c..590360ba0a28 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1036,7 +1036,7 @@ static bool coredump_pipe(struct core_name *cn, struct coredump_params *cprm,
 
 static bool coredump_write(struct core_name *cn,
 			  struct coredump_params *cprm,
-			  struct linux_binfmt *binfmt)
+			  const struct linux_binfmt *binfmt)
 {
 
 	if (dump_interrupted())
@@ -1093,7 +1093,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	struct core_state core_state;
 	struct core_name cn;
 	struct mm_struct *mm = current->mm;
-	struct linux_binfmt *binfmt = mm->binfmt;
+	const struct linux_binfmt *binfmt = mm->binfmt;
 	const struct cred *old_cred;
 	int argc = 0;
 	struct coredump_params cprm = {

-- 
2.47.3


