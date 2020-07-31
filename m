Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F3233D4C
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Jul 2020 04:41:32 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHs3s0ysyzDqYY
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Jul 2020 12:41:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1596163289;
	bh=EOehjXPvddlxmFgxbvj3zTsWytZpiXEtjIY2Dm3740Q=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=jViAyB3yxBB+CVI89adjVgdTeTwRHDAkfo5VoNVvUbjIaCFhW2X1ANrQq9PzcaBPE
	 6mM+xOZL+cGDIr/ZhO7VefymQlr/SixHVLb9Mq+4qmq3tF1Tl0PHl15FkRIXv+SuFT
	 lyqlQv/8rMvb2e9hD0i6QWyyRtH86d3sAWzykYfFZdBaED3DxxCZSl0TFeA2MHCQF7
	 QHY6fncbUDK+yIDoHa5fUB21Vh3dHROShbo7Gz9sONz+qEd+MyPF0TgmG/sUnNwCf+
	 EsCeFZDeSIrT9/zfALMuxz4m5V8icPpfZMDjpBenV9b2rVVwOCdI2ur7/HISF3wjmV
	 L9hozLnMIgcRw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.148; helo=sonic309-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=VmIDRVFy; dkim-atps=neutral
Received: from sonic309-22.consmr.mail.gq1.yahoo.com
 (sonic309-22.consmr.mail.gq1.yahoo.com [98.137.65.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHs3d2GnRzDqYJ
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 Jul 2020 12:41:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1596163269; bh=DD91Y+8hLQEWUJa1HsJ2lWsRkBMbpRbQsE0hFQtmbLc=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=VmIDRVFyBlAXv4h/wj0to2Y5NvQsQCC1NkpWNImyjBSxIScGyqit8kStor21AWhNMhZXiU0mmtnb7Z4DVpykNmFyVT0jRunbUjJeavCZa5Dzy+y/nuyzJzzKivNWIVCbUq4Nr/xO6Wd22pIWU1BcsWXfl1qE1Mp/suemCVfbYHKIPKb8EPHPG+7Meb87P01AJsb+KE/iqwPoDQmv0zJhALDqbW8cRxppSc41cBFWv2eVMmOs8lDwi3cfKCnGvsaCuLpXtLathSCjmtQpqXOhYkLmqBl5FPRKjAV5UcqZsva8CYukjDIeSaOERpMOIzVt3ee6KQ9Fz5yQ2Tpv/95lhw==
X-YMail-OSG: 0MYneP0VM1kbyZvS9MjCj3h4zIa7Ff1gyM4zgfqAjRrzKcm0.t4ltJ4tOu4QHAD
 v5c6w7ykcLqfjrjCGnuS49oBw6O0oY3wfCyj8RGh2hAdyfOe1eH9BweR7e0uGAksjS2FTPEvzgWX
 zgvtGEW45kl2ZvqQjf3v_bDa20mxNXLeUCYo5EwwRuWfau9XrrxVRakZUTHbyFLTph1MdZGdMCK6
 IxTtmOBvghl0.WgIJFexVpzuaWCpEL_oPc3.aRIHx7MGMOWtfAcEx19zaNG9fFKObciFSYpli4dz
 CQZzgfz3ROrfj8vldt14hG29AMq7YPOWWj7msB9KkuJ1fBi687Z9Un3rzIQ4CL1Piyibvn9iTHt.
 R1jqlgZcOWqHBFBCDxmrlp6N.rjbSH1BWhNM2FlbkbLpoApbkcBXOrwed6AELeuoYEIkF.DvprXG
 l_qTxcR6WnkLM2FquOr.UhyJtVNAjAoNiwvM53dSDzqmKEuXxC4FR1BKnExquf5J5z1J1xf9zLsp
 Ii_uFrZ8F3aQ4ht4wYelC2rNX8y8DSreiOFbXkhpB6tekh.6sjHpy7XQ0Q2HyLt3jca.Hg7BbyS1
 KOGUZewQ3w_v_GntTirMu3a75LSDy.cu_aQhBYyQ85WbqB3FuJyySj4n_q2rKfxHst2IEDCcLfQe
 nmeNNGErZNJ32K1MFeEePF8zgxvbmaXYKWgYmPrC.U4TfAJkvZd2pDbQabA9OVAplK6xqAGB4UvL
 JyBGCVVGUsLtS399tUD_buICu7955NHTU5iAfeDNA4p5ejmC.WaG2.0Upb6x1MILqmaYmLDd.VwX
 Hxac0mtGfdwYFswohqxMzMCMuLBdoIqkxj0o5rrhXuPeA1JnhTsW8zlzBdwih3E7M8oDCrZWSv12
 oY7uS7qPvhUo_1d7Z4GVb1mAPA3QBdvXAzKMIlDIT.DHwFB93xed8Lg1g.NpRmuyA1jYnLYR.gxP
 UNUGtfA9SNacVR0Be.H_IS6bTTqC5T3a7WtpqkuCPLQwio0CBINnB_WUmySv1.rWEkFHkHShS6Ng
 on4nlefh2b06tPoWuPVi6T8KzUCA9G0pYNuvh0KSzuFlHdlBPzpGr.cqnhp.HiL3PI4AksYKQBKq
 Opb.2c8FgrjxHM45oK3MLHb17LGEjaGUuVDLg8XXCWAzuKx3JyakLXwlTpSCEMWBwpbKyQEQVpTR
 j9Z4.iFaRBtlWj6bjl0tGlvoWsfEj8hEDsUZzdT9PKw6nivX46VCY4s2EA2fd_theyLBpPo3Rsn3
 yONYNBWRujEa8CwRisiA_EpYfZT5vpb2B1naxPbHNCNjIwRqHze2TJ6Iqe.MFc_fbEfbrOUHqtN.
 0gYG81w0ddmvrlUxEB4_RROAiHd_JoxE15QvDR.Owhzwx1pVsERPm9BjtuqKq5g9zdVgr
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 Jul 2020 02:41:09 +0000
Received: by smtp432.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID b10174ed125d8e8034f121a89cf92327; 
 Fri, 31 Jul 2020 02:41:04 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: remove WQ_CPU_INTENSIVE flag from unbound wq's
Date: Fri, 31 Jul 2020 10:40:49 +0800
Message-Id: <20200731024049.16495-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200731024049.16495-1-hsiangkao.ref@aol.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

The documentation [1] says that WQ_CPU_INTENSIVE is "meaningless" for
unbound wq. I remove this flag from places where unbound queue is
allocated. This is supposed to improve code readability.

[1] https://www.kernel.org/doc/html/latest/core-api/workqueue.html#flags
Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
[Gao Xiang: since the original treewide patch [2] hasn't been merged
            yet, handling the EROFS part only for the next cycle. ]
[2] https://lore.kernel.org/r/20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 80bf09c4de09..9ac2723c11bf 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -43,13 +43,13 @@ void z_erofs_exit_zip_subsystem(void)
 static inline int z_erofs_init_workqueue(void)
 {
 	const unsigned int onlinecpus = num_possible_cpus();
-	const unsigned int flags = WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE;
 
 	/*
 	 * no need to spawn too many threads, limiting threads could minimum
 	 * scheduling overhead, perhaps per-CPU threads should be better?
 	 */
-	z_erofs_workqueue = alloc_workqueue("erofs_unzipd", flags,
+	z_erofs_workqueue = alloc_workqueue("erofs_unzipd",
+					    WQ_UNBOUND | WQ_HIGHPRI,
 					    onlinecpus + onlinecpus / 4);
 	return z_erofs_workqueue ? 0 : -ENOMEM;
 }
-- 
2.24.0

