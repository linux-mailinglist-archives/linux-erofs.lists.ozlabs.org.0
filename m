Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3374F290F08
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 07:18:23 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCrrr3BlvzDr02
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 16:18:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602911900;
	bh=c91nxXMOh6jf/Su1kWQOAqRYjGRtZupHxgWW0H4YkuQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SZ0YpNp0MiUcO3y6PM6I5TsqIaHLj9GO0ijC8yZB/b+oU5Ds9izLQSJ84iYaZood9
	 hzPtWyS9Ofx/RqykXu5eulbla97ys3QlF4FlEpv8WkrMf1tTDaK92rLijcSSMoTsco
	 gnlg/Tqf45SBLz22Fl1hkrI2UeG15++dblGc+Z86JZYlrkmqsaBbzCqmRynMcUVWrW
	 A7Bk25pssSCCaMD8ONGa/xVcE8ytTZhlWltPlOYqNp7ai/daR3wUVSjQ1tbNdaGCGR
	 m4YD8jLTzoIg4i+dYNI5v+asBuje1CRPBQVqQP1oYWAhl4QCZ6seXZ39+rUYVGh/sq
	 U2TFsps1ef+/g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.148; helo=sonic317-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=TBp+GC+0; dkim-atps=neutral
Received: from sonic317-22.consmr.mail.gq1.yahoo.com
 (sonic317-22.consmr.mail.gq1.yahoo.com [98.137.66.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCrrj3vtKzDqGS
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 16:18:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602911888; bh=X3BF4ND9TcNtsbs0P072SrkWqVb65RRvLgOfI+e0k3g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=TBp+GC+0FZaUK2x1zqDI4Bud1mPbLkUqBRGzqfxSwoqlybE5+MOUd0b8DOujCSqLPOp9kXGXibFvt9nL4y8pOH0xj8Fyyz2BkpRLMFm4DIJgWmfyf4+rp3F5TJVahRNNkedOJM5rCOhOu1vpb9g7aSx6gkB3zaNZydiCUIyH8nblRHJ5XS0FdEkkhxRGJ6o+lEF8m21lc8tDOK1SK8qa+iyYuszCKmbIil8dMJG6b+d5AJ4vkOdJktj+IPbkZGvOrIc6TNny+6RXb1SIBmexEL4h+Fd/Rbu5Fnij8/0AnldImcdBlv4C0pnMjwG0cP7dJt/oMRN/MLkpxR53qrBRVQ==
X-YMail-OSG: I_N6RfMVM1mDMZYlNGnBVdCeI4msPvoZ6s9M4HjjCz8ed459XsZ76PaMCWB4X_6
 m7gLtAzb2qh9Mpj6YWyOdSHXrMTsHNAeJhwJE0jI0wu9wh7u9ku8eyAg6fXa7SZAqsfjO78X3kh8
 afqlp5E8B_fScolaaIdkRKbhelQOnemmOQNFxusa.SqmcWjliEO3VBoqOdEkgu7SpcpOa0o2jwDN
 ot_2JxIRsTNVPfwOTdIG3Oqi2_7zG0wZfJ_Bhz9yCdlLHxoAr4tUKD0dHk0UG1HQ_OAytSckKXib
 vvCeCIOELYqSkkrrOqE16yhf7U8H4MoizIirzy3ZTcf86suIAa3apO1hnQ0UAykCAxkKXDv6IWrB
 Cgmndy7s49V7vWinf1x8ba7GgGm9.Q8tfDpO5zH.udvq.cjapEOnQmxpWYK9PdDAIu95UytHqdr2
 Kxmaj4QZvfu0mVM0S2fNdk_seEb9ir5OSuwqHs52N6_G4EVOZG96GeL4BaTj5a9IYehk.HO7Nh35
 ACqTn7oWCfBCua0HcQsGIBJmVjUeIx0kvQLaGrMqqGi2242tyP.iYOeJLqgnOSqs7YtSI7DkO.xg
 4cBT6XPyHfAwu4D.6o8d8LqIoZ0FeCEcXljLFxHYNY3mno3NxCCQnUWpYB9_CcLHUvRhHt03T07b
 mSTo5MfQdAQx8lLMspS5b0o1WY_RhNKymUsv8WnK7jrBg0lneb6rtQAVRB8GdB7D8aotxkrFFzIN
 QjJtfwVi_W1_c8rEbIYyeB5wDTyexUCcHp0bpziHeghmJyZREA_IvNaOQM0apLLFfwSUyKIhttjp
 qmRrKRHW.gxrwMYQ70FXwUyFo2EoqPzEcM1nT2fOLN1ILD6AjDtnnEoQIgRjHv0dTMpd5jgnrwAv
 _RQ7bx5SMj8F497XLH9Bt5vffkVKjNr32eBU2h5k9nIGJyiyEMCHY.yRjlyN8pLkEW7r.732LQXP
 JCt7EOMZz3IVH7YGJQAgiOJSnrX69TNRQegUVaGWk6N0uICJhleWRS10JEixo4dY9RjNuhOEQrF4
 p7eYwxD28NO_BMm5SQxJyOfCHv2klfzZyUeF5qQsX.sXxhafr8f1bA05OVqqUgHcoeqVkiYT3KZd
 _vj82gJcpRhk6LBlk7Mzcm0T4kFhjiSmRYJmPe7.cLxWCtZ4KoBgIvWoMJ3cfXfz_chldPd6t1.9
 Sbi.jcg1B0iGNPKItmXJMNmW0WAmioUobiAtFY4.MdPwddghYLcXcCSMHTUHMks5S_aymMFVoYmL
 lsVefCf7PnSP6oYmuAjfEsKNGYTKRT5Jkf8JlVdBITnCSDjagV0jPsBI6dO.nnBJ6VFYd62gILIb
 UwcxmKJ0bflDh_NYS4eKjTNBsDx5gjuRlVZz1swDTYtrzPONSsONHRrpA_dfaPgBrEKm9tV67_wM
 bw2BnYgUrUrpa7DGpTmLXN1P5HKA8Gs06OzUC2SXmFYHEZU0gbzWS_Os6sR8X_p.m4eq7jsLkotR
 7R3npd4LtTxnnN1BalZyxdC7ai_lL7cqYdNezc7CEHd8jUHFtKVjiwbfs9e8E5NH8u4f.7PmQIqp
 xgeYD5O5tRg4-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 05:18:08 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9d3dc137a63e5241cc606f3cba181f35; 
 Sat, 17 Oct 2020 05:18:02 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 07/12] erofs-utils: fuse: refuse a undefined shifted
 cluster behavior
Date: Sat, 17 Oct 2020 13:16:16 +0800
Message-Id: <20201017051621.7810-8-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201017051621.7810-1-hsiangkao@aol.com>
References: <20201017051621.7810-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[ let's fold in to the original patch. ]
Cc: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/decompress.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fuse/decompress.c b/fuse/decompress.c
index 4b7cf3211319..4a9f8e7995c1 100644
--- a/fuse/decompress.c
+++ b/fuse/decompress.c
@@ -18,8 +18,11 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq)
 	char *dest = rq->out;
 	char *src = rq->in + rq->ofs_head;
 
-	memcpy(dest, src, rq->outputsize - rq->ofs_head);
+	if (rq->inputsize != EROFS_BLKSIZ)
+		return -EFSCORRUPTED;
 
+	DBG_BUGON(rq->outputsize > EROFS_BLKSIZ);
+	memcpy(dest, src, rq->outputsize - rq->ofs_head);
 	return 0;
 }
 
-- 
2.24.0

