Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE9D972B34
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 09:53:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2wtS6z1Gz2ygX
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 17:53:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725954797;
	cv=none; b=nZBcXCL1NcLWPIFkQXO8m0bpTav836mIjGggv8IyeTF0whae2M8qTf9pe0FzsO34hCS0cAQZPlVVlw3Lpjf2bqfvZ9Ll3+nRbcxbetqjTBn8O4+ASFsHETaAEYAGydhjrCOISr9EYIpJ6XyglAiIE1QIO6MNmPFagz635njUSaqCi8jqewyQ2jO8kQ1mTBdaE0qwZOQeVt6q3LVcGtkzEHbMmHIAbx4XO4+JnrEoeWulE6ksIG7AbPH8Q9L7yn1O1o05lLCIq/jd+4xT0J8meDVMiRgBpND4axVHks3g4BZ6Wsgte0pt2Il64mku6HamGC99BnyiV9yjYY/TB/bphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725954797; c=relaxed/relaxed;
	bh=uK7xtrFRitTcp77d3InzRv9PVwAtmdKfgq8cfkjcTLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQHMN04U/kQZ3oEHm087U5dF9I/hgxv1kNCwYP1CuOVM0lHam3qME/IwyAkTSc8mSlauiUhSbIIvyqKOGfL+uFasOsnbPC0S/QchHU7bRcH3fkGNb5xAmcAMgaQbwv86Y9c8nZR2733d1YGxz/gD3sscBL3UYR2HhaESpioizshAXKwVij4nhM5cHQ93wMeqBhRBvvkJElreZxHHMXOU1qljMwKhB5saoaybt6DuTBH/m5dsd21LoH+uRqATEk/Xu50N0D9RSmwXDnIubnW3HPFPGIyHTj9G6uE1ydny/DOPl3rd3O5mRe5vRmlSrO7iBx2yyQJe/8px54cipVX8jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vU6YNZm1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vU6YNZm1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2wtN34zzz2xCp
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Sep 2024 17:53:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725954790; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uK7xtrFRitTcp77d3InzRv9PVwAtmdKfgq8cfkjcTLg=;
	b=vU6YNZm1xizlabSRzH0DVA6hiDjiC/jRU6SKdZJqxuJSTCAl8DCsbzdwegvYHbbwGAqxg8fX+mn56HzQ8vhsN5JdAB1SvzW5Y/Ti8XJYSI7hEiMuflTZn9yicbcoON0vuXE3BBDSI8LUFN9du/gJsXhc+FRrqkVV/+cWhGmHgy8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEjgeBj_1725954779)
          by smtp.aliyun-inc.com;
          Tue, 10 Sep 2024 15:53:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: use another way to check power-of-2
Date: Tue, 10 Sep 2024 15:52:56 +0800
Message-ID: <20240910075256.3423180-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Otherwise, Coverity will complain as "Operands don't affect result
(CONSTANT_EXPRESSION_RESULT)", which I don't think that is an issue.

Coverity-id: 508261
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/kite_deflate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index 4b1068b..592c4d1 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -834,7 +834,7 @@ static int kite_mf_init(struct kite_matchfinder *mf, unsigned int wsiz,
 		return -EINVAL;
 	cfg = &kite_mfcfg[level];
 
-	if (wsiz > kHistorySize32 || (1 << ilog2(wsiz)) != wsiz)
+	if (wsiz > kHistorySize32 || (wsiz & (wsiz - 1)))
 		return -EINVAL;
 
 	mf->hash = calloc(0x10000, sizeof(mf->hash[0]));
-- 
2.43.5

