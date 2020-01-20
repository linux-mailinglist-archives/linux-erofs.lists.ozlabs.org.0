Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CF071142774
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2020 10:38:04 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 481RRZ0rBqzDqGF
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2020 20:38:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1579513082;
	bh=71gFP9+7ShoEliz/wpCNLQQM7JNnTRZYgyO04op7+b4=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=f0pqmcYo08exq6ZNrwpvh4LZzKUm+1NoCSiKi0q4vmAZOv2jc5/ckwjBNT1rrhhj3
	 HVpe/dLZaTUlPoN05NRbShbPttwKHwjKsTp/2rj8HzHm4Hj6ZPSFrjOLgVWQo6y5TN
	 NSOwJP8kIVXwpV4wDnbR3hMCS5UEzxYPR0496DuOJemdjVaeupIu4eigH1N1gS91gv
	 RHUxdmQPIeyikEGSkSrHnISNXrJptDhdE1gbm5QxUr7ciCpO0oBGnryqxmNeUFhQg/
	 vaWTCGwfvqbiOeo3HjXAfDceha8pyu0aRB0LMWdLQt3YP8DMWyVLXEBcJhkp6v2+4V
	 DkJubZpljLy9g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.30; helo=sonic308-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=SGZ/rsEM; dkim-atps=neutral
Received: from sonic308-54.consmr.mail.gq1.yahoo.com
 (sonic308-54.consmr.mail.gq1.yahoo.com [98.137.68.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 481QXt4V4qzDqd9
 for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2020 19:57:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1579510649; bh=zuUeC+q1lHGrclRsJn5X44Wy5fQ7zVbOLjUy1OQMpkE=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=SGZ/rsEMQGXmDTUASSxzKfrX8sJ8tnxyZoScQDBoCN5J77IEKwj/MLHkRbGykacDMw4pcG0CYvKxe+01meJzuZVvrs7+CtAVE317uVchTdhlEtLpQ2H8QyBiMfcNwmQv7lP7dPz2gAK2Fd8jeRK6AJlBUwgCXRF5reil3jNCWlmawYGItn6ao3eQqMV/e943Ft9ijjxg+y9nYcyGdzuEgzHJzsO40n9f9VU4J9RDYx7qHC41ho+Rl8GvQLTa2hyNx0gPqSVH+bP6NsCsBq1sIffC8AN5Vpt3Ixi3gGQNLxR0jkAjzDkRoAvBLIu5ZR77uJcRVSYldcnSaSfcEtRxbg==
X-YMail-OSG: UYRY3WkVM1k2NrL2u1xuPI5eI1iQ3NMoxPiM1CsVwoFyPPxW479fmMGaXdQ3.uq
 qc9DJj86ytjn44cq7CbtfrnsKCRtzKQgD24kKDKEKmGFgPdat81r.1uyUjsKbeTwysr55Q9LeTuB
 zdkW.Mpn_HjDkeHfXuD6vFl2TMjfd_hbRQiAinrk3CvWCTicBaoiAAw338BZhNJLIE0UhOwYPjkw
 FY42jOh1D7YI7ne3u7bCeY1gdNKe6skHlnKnVGwQxdgJmfF3R1m_zw9AdiaRYlm9WeDraBg5OJd6
 8UDHVSUNaiue9xCYAzgGH3LGtIBHY2ZwVIgXEb_1hVio8FuFcn7Op5zPH5oKimmCclKNidTtw082
 w6n3_vBllI1oGjRAd9CR0pHbNC_iyd3t.kQ6pmYdFCEaEIDe7aXFuSKSE8Rh7TgtAjjfcSnI.wPI
 Jt4S9zew1WPBnH07oGbTguCnX7IjXoP3T_HAFLi_Yr3.zhf9hmqMJAZC.plijHe5AuoVpG10995n
 MUrYOgvU3noPe.ZcnGFIjW.emzIUDVXVFf11qBYW.MsEA7EOC2iIbaVg7oPNZ46.9pQ4_avNGrYG
 r9LujY0D.jR.VkY7Ac_KOzGxu0mz_DRt_QDknYtCGoaUcxnBmLeqo_MqGr5XRuYetuECijf55Av6
 wqFr4ZcoohRICGDHgE6RUvxXiqyYCFV7tF7DdBcWBtViZyLEG9gnkrhFk6m8vjIg2nbVESBJtm7g
 2WzkriJlUhxXHURPckoW0uyosAMrEtEiyCua9BIHRNdazZbWQQLzXcYzcIpPucZWjt7gIPIxDIDU
 7aWGu7buhGz6VC1ehX.UGH.x5zaLSrtpyaxB8OKnzAX1Y_h3wPTkFgoL5h.jB.J00498m6jQAUrb
 zwQfudcQQ3bFGRY3EqZ7UN1TiOi.8CGqLYnaB6pbLR2U9CqCRsLvQSitJVWUM3yEE4ibDsNNkzl4
 fAAvVEYhVrK1KeZz7ECZs5buZIZd6Q10wwEeuiOo6sgcQIldyrgGFX1VoE4LMw1XqwutpshdnfoB
 9CjC9vj7oc10mydOhKOIj_nB00ZWHK2ZZjlOSRloQ2Wm8GdROYCqmbPQuVwM0EL5RioodkuqMvC1
 0aRTkWjfB0nWJGEXVI2E9PVUd33s9bGtZQKN4vBO5KjwXJyPDur_TDpy.8vTrVK48qg_pu.Fu_HM
 neVWcyRVb_mfYdqy22k5mPh3Yn.hH909yuqZjFQrRRBYSAhN6SPSit0KAgMYfhOwWt4YYdA08tp9
 DoSNM3SNE..p7vTKQGEf0a95J44GdBD3ou22738oa2AyEODVg07mJaYlsjt9LI7.X.aqr9LfXZg4
 h2do_EUrLZl0QN8e_7bVSO4VlC8rvArdp2KeGutIdn0spdq4i9Teqa6LlxKUzYGsDlNY-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 20 Jan 2020 08:57:29 +0000
Received: by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 108e935cc9711f548eb3f10aaf32bbda; 
 Mon, 20 Jan 2020 08:57:24 +0000 (UTC)
To: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] erofs: fold in postsubmit_is_all_bypassed()
Date: Mon, 20 Jan 2020 16:57:08 +0800
Message-Id: <20200120085709.10320-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200120085709.10320-1-hsiangkao.ref@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

No need to introduce such separated helper since
cache strategy compile configs was changed into
runtime options instead in v5.4. No logic changes.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/zdata.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4fedeb4496e4..6ee5153801b2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1148,20 +1148,6 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
-static bool postsubmit_is_all_bypassed(struct z_erofs_decompressqueue *q[],
-				       unsigned int nr_bios, bool force_fg)
-{
-	/*
-	 * although background is preferred, no one is pending for submission.
-	 * don't issue workqueue for decompression but drop it directly instead.
-	 */
-	if (force_fg || nr_bios)
-		return false;
-
-	kvfree(q[JQ_SUBMIT]);
-	return true;
-}
-
 static bool z_erofs_submit_queue(struct super_block *sb,
 				 z_erofs_next_pcluster_t owned_head,
 				 struct list_head *pagepool,
@@ -1262,9 +1248,14 @@ static bool z_erofs_submit_queue(struct super_block *sb,
 	if (bio)
 		submit_bio(bio);
 
-	if (postsubmit_is_all_bypassed(q, nr_bios, *force_fg))
+	/*
+	 * although background is preferred, no one is pending for submission.
+	 * don't issue workqueue for decompression but drop it directly instead.
+	 */
+	if (!force_fg && !nr_bios) {
+		kvfree(q[JQ_SUBMIT]);
 		return true;
-
+	}
 	z_erofs_decompress_kickoff(q[JQ_SUBMIT], *force_fg, nr_bios);
 	return true;
 }
-- 
2.20.1

