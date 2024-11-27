Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD2E9DA42C
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 09:53:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XytWN0lLtz2ypP
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 19:53:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732697581;
	cv=none; b=hFp11ZaspSiVhj4BBxJZ/gUP31wZqPl1oEs0WO7+y+h0jaSz0SrgBdxCccEYtlP0CfIacHRqXdUSLhwohUSzlEwfx61zEZ2n4/nerAWa1QwNSrRxwjPoYmUb8W92WmFa3N9Wt+uBARaj+4vFUIbOaa0pP/MoF5hN+4mpQdlDYxny3xONDXO9qPat0cfpzMDPCV8qKrDzA6k+gZM8odVeYEXRjB4qEyU39WkOjUJcyYe7eyGuOLDk0rjckewg9+eNJETNUWC0afEz+WwYaQCNdjPwGq7a7TBqc4GODzAdyxz/K/sBMrTnMkhF3C+0RwhkKyRmNPKmJ5t+Ff0iurufVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732697581; c=relaxed/relaxed;
	bh=/75P4yZ3HLTWLNgRcQezp8O8WllCY0JuxZe7FDTAslM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsAq46GEEhmuKPDw9+3Xlk62qaUgSZiBPJW3O2o2iLb2U6exSps1BxO/vf9DjLCkN9skIJRRCjouaVXNa0MD/xr+sv4d2FFaFF13d2Phb9+2DRt526iq7Ow7BWT8RBgzpGvkSlxZB40fPpQ2FKrPzlmNZzJVcEl3AckGwquoQt/bjjxYmT4ZHr7mMS/HcMHWMTho+mjfFQMBEys/3u4Q4rmAD72SHK+gHBjh/iEyH46uT/6uH7fm6e9QUUeCye+hOsJNLgI0nYpn2AdvMYaZLV0l2D2qcGnn3M2BFUIjKBuourvZWmRn8eh22eUoR1vDLx2o5uopg6dvA2lZVfnr5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bjoG0QYq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bjoG0QYq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XytWG1Mlnz2xYs
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Nov 2024 19:52:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732697565; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/75P4yZ3HLTWLNgRcQezp8O8WllCY0JuxZe7FDTAslM=;
	b=bjoG0QYq70q7wPvo6W4maoKP6BgdT9PBAQp/Ev5rwdEyd3ZRudotQpG2rjloiB93ZhMpCMtiCUNqxNPeSsLVR6PtXBxzIu311aPYOUN451Q/pHin+Qv8O1cMjXvuaSBb8QgZI99QTA4w7zkqkg/5asQvbJc5h7z4iypI49X2AuA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKLmL2V_1732697558 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 16:52:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix PSI memstall accounting
Date: Wed, 27 Nov 2024 16:52:36 +0800
Message-ID: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Max Kellermann <max.kellermann@ionos.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Max Kellermann recently reported psi_group_cpu.tasks[NR_MEMSTALL] is
incorrect in 6.11.9 kernel.

I think the root cause of the recent issue is that since the problematic
commit, bio can be NULL so psi_memstall_leave() could be missed in
z_erofs_submit_queue().

Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com
Fixes: 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 01f147505487..19ef4ff2a134 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1792,9 +1792,9 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			erofs_fscache_submit_bio(bio);
 		else
 			submit_bio(bio);
-		if (memstall)
-			psi_memstall_leave(&pflags);
 	}
+	if (memstall)
+		psi_memstall_leave(&pflags);
 
 	/*
 	 * although background is preferred, no one is pending for submission.
-- 
2.43.5

