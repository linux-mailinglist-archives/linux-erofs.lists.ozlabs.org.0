Return-Path: <linux-erofs+bounces-1320-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E97DDC2B542
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0TpH6q1fz3bf1;
	Mon,  3 Nov 2025 22:27:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169255;
	cv=none; b=gDuI0Ny8ygBf9H/VlrkVdNoIPb9kUKG42Ar3ljgmv9WMgnHvwEOsUshIC3nRIXV3VT7DjPC0P9zsgjlHGs7TwTZiKBQAo2TU8IYMGS5UKtO5iwenFk3F2z25VC9sNw8PDBUcB7KJf1HjEk8LHx3qfVqPsmx5W8GJZqXCs+fyB0P9JCg5yHKPwEhbYbiSOU1pht7GTgSVObX6TVK9StDSk6QnzeepzNGSkSjMtPyhotHQkGYlei1aqnTBP/d/cZKNzfaHR+0ZhCyrElrqcBv2O68b/DwhMGuDk6Hn0lSOhrnBE1hA2FEK3GESHaEFrpFZHB1jYzJRE0jJLHROjkLfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169255; c=relaxed/relaxed;
	bh=RMVgQ7jmn9Dd3AaIxOcijYMSKPMk9SP5vQK5JaYtdEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvh+Mhj6jk1u4/2gD60uix/5wJ9uo+u/KP4rxSFnNbDydA+RfVoerppKhTBXGk5co/dVHoxLTWDgszULlq1k87GuuyWDITqoejgSrHr5OFvHH78ZMybqBR0YP81gf7ICY7mO4tg+js3HEcXMst0aVHWi71iCzBlcJFs5dBvymrEEpk8aFhw6tV6QWp1Ms9VJCIIq+5HixvDXgKGmqeKBgTRtOECeuqE01AECUM4gRpUrFoAatVFiQdrE5cQA4oHA3nUVbaO3mvmPLkCpRmiOXLmS6mAYMbmOnWhLBRiGvPLJ9HBkZvI69ZCo93mjK27lHPY6g9KzDK4PkBvZc2H6nQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U6WkkxGT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U6WkkxGT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0TpH3B5Xz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DCCD643474;
	Mon,  3 Nov 2025 11:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB8FC4CEF8;
	Mon,  3 Nov 2025 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169253;
	bh=rKQ/y4Od9YwZy6lC+CZIwz4HC5HTRvkb8TpxPddq1Vk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U6WkkxGTZLtlnNdBQazDAtsgeorAhuV5hDik2pKTcqsbl3AaR8l1x/LcjhuAqzZmM
	 FnUljnz4oNoibMK6CNcTsI4Cmk8GCZDxmUgQLJpGu6LNbAdK3eBHjjmQmzO+eiozl6
	 LSrtXCRVfTPH0uCruRfXoi/ShDZVsvqVitWm7iob2y3dvUuZXBE+KFlybomgbT1jZl
	 FiQr9dcZVjF6Q77JMbh+SdH48QAgj635490LAFLfFWZTbB3E61HjQO2q6btJFVZXXv
	 JEtz2qOaA5A7hFtdB/OapYZMe47sQxmIQQAfCj0yV1hphNgVui5vZ4o+rXxARtLPvx
	 xGUBJ68dEzFyA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:57 +0100
Subject: [PATCH 09/16] erofs: use credential guards
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
Message-Id: <20251103-work-creds-guards-simple-v1-9-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rKQ/y4Od9YwZy6lC+CZIwz4HC5HTRvkb8TpxPddq1Vk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGwvdjrU7i51dLfjOt7O6IIJCSndv3gerc31srrjL
 W3fKHK3o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLK+YwMJzeedL6l15ZWc+Rc
 huX+xWsVps0+7X4xPfcr3+sHt++GCTAyfPgWIblbax3XPz3/q2cNb1f6+T3fwW7ZOHnP15KSP9x
 rGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/erofs/fileio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index b7b3432a9882..d27938435b2f 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -47,7 +47,6 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 {
-	const struct cred *old_cred;
 	struct iov_iter iter;
 	int ret;
 
@@ -61,9 +60,8 @@ static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 		rq->iocb.ki_flags = IOCB_DIRECT;
 	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
 		      rq->bio.bi_iter.bi_size);
-	old_cred = override_creds(rq->iocb.ki_filp->f_cred);
-	ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
-	revert_creds(old_cred);
+	scoped_with_creds(rq->iocb.ki_filp->f_cred)
+		ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
 	if (ret != -EIOCBQUEUED)
 		erofs_fileio_ki_complete(&rq->iocb, ret);
 }

-- 
2.47.3


