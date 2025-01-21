Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6156EA17E7F
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2025 14:08:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcnZx6jwvz30V3
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Jan 2025 00:08:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737464919;
	cv=none; b=cGgGIwEL8wSMr2l/5EJxp1zvE0cpcVK8H8f3vMRVAyDQKGXEgRHGLIF+XCIBRluK3+/OrLiNKl0B8lpqhPlBeBUZq1lRN7u0Vv3foA3y+m62OY1Wr5s30pW5piHCgLpVNDtg5r/5rs5MZCXrmukDf46DLO8L8fl4IMwyL9r0H0kZaIqJ0Fl4uUq689VUhKAVcUHYpDPYaTltCn1qUGbQHNlVEdznpgKEp1Hj9TyKejgDmCpblJi18VxTHCbq54KFJeTGSLZ9Q7xkkcWS2YTbhWc6NNUZteOd98SJaJgiTZeiLe/TCOG7Gl8TFyEM3SrLjQgVj0Vs0adfo708w4GYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737464919; c=relaxed/relaxed;
	bh=V5CeX2pKzWKHN+43WOK9aHEXIuGpyJDc9TE1dfAvzK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0yREFiF74E8b+leM6dgAGEJ8epPpDmoVpAYTmCczlba7wIlcRlirJc9M8kNvF4K2bo22rL1/cs4H/zqhoNo9HMrZIxwrLL0Wr3tK4e89FepWR4vwYM5ChhF0oKlRztnw8YJdTA63iwT3+H2RfI4y7zpB/IOPkR9E5+eoCdbVkehoUXcTvAkezSrII5/EJqe2hyY6HbAAkjYGN7luSQHYP+FMXqWPDaMSQQxIx+iG+OJGfS43dzJc2zLzy6Tu6blYRq01gpxgFjIgoeoUeWrUs5P4ce12ziP5kYzzUrCugHBnir4mamGTMNHlpVmnu6dyX7BGqY2NQ9G2vUQXoNdOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r3AaHLGU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r3AaHLGU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YcnZt1L3sz2yZ6
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Jan 2025 00:08:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737464913; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=V5CeX2pKzWKHN+43WOK9aHEXIuGpyJDc9TE1dfAvzK8=;
	b=r3AaHLGUEbNK2V7sVlerbOal5t1v4sxOby+ZSHYIW5Dl40jHbhOmyuPj/6WAG1QQwWM5beKmxsUk5utD7l5hV3blLPEiRURo2yLnLipVe2t8M4aNcRFyuFJ60/t+srEkMezxh2//l4I6xzzG4p5FQwIcuyZw8wutT8UUa+aRrig=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WO5XNwb_1737464906 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Jan 2025 21:08:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: limit NONHEAD delta1 for compact indexes
Date: Tue, 21 Jan 2025 21:08:25 +0800
Message-ID: <20250121130825.1722009-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Otherwise it could be identified as a CBLKCNT lcluster.

It actually has no real impact for 4 KiB lclusters (blocks) since
EROFS_CONFIG_COMPR_MAX_SZ == 4 MiB and Z_EROFS_LI_D0_CBLKCNT means
2048 * 4KiB == 8 MiB.

Fixes: 0917ff150846 ("erofs-utils: fix delta[1] out-of-bound of compact indexes")
Fixes: 2f871035cca6 ("erofs-utils: mkfs: support compact indexes for bigpcluster")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 94a9d52..5c9c051 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -839,7 +839,7 @@ static void *write_compacted_indexes(u8 *out,
 				*dummy_head = false;
 			} else if (i + 1 == vcnt) {
 				offset = min_t(u16, cv[i].u.delta[1],
-						(1 << lobits) - 1);
+					       Z_EROFS_LI_D0_CBLKCNT - 1);
 			} else {
 				offset = cv[i].u.delta[0];
 			}
-- 
2.43.5

