Return-Path: <linux-erofs+bounces-18-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF2A567F3
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Mar 2025 13:37:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z8QmF6tLwz3cCt;
	Fri,  7 Mar 2025 23:37:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741351053;
	cv=none; b=nNtawNaCHK02mqdnnRo3ZMAQeUWec8TM9onltQF5KPXjyb+KO8nIpHOGQNYr0Ox2gnsCk2M/gQ+SPbNuPFMVedIW4wHPAYku3NxuzNGU4J7krt+A5ejbeg8qm/IRBsS74PzZ1qSAd/ZM9J/dq28upGq6ug+UF/T6CGyMFuALGMHaBAOuhwAyXNzRo9NwCieZCGkLaEIs84woIlEy0ZCpulM8tNb0lZ7IbYDwT75zJp0GeNctHYzI+U+wCi+02jj+x3/y1kJUnU1qNecILRpTo67+z77onyzWT4VsyRHF/+jZazIzn//HJrEnzoEAwQr0b3x9hbHgnfoFrkeYM8cr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741351053; c=relaxed/relaxed;
	bh=f0IPANNTPJveWPHPHrluj1MWRZ36YTelMvTpuJcLvWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8KbpbW1juOI8dqWr/VBzYULvy5txgkT3pte6KBJdgSlg49SNPUzjmHjKerqp/wnOTQuT3IfW0vLcPcdl/tVlFoh1AAuXQv2oqBdVTsznxYzBfpuQoBusKbobw9xGs8vy5FZcofwFEbtvHPo+aGDOXo0Ok5ugQguw05abj4f6EmjHQ7YBHsEQbH/MfcPlJaT3UCPOPIKLVSX7EVQbd4Dg3AdgKpdSN9PdxRLH4Rh9LGIpB4VkIPGyXCAxesM0r/++MmspPTWTOGQOqzO37HUXXZO5N842sXTrjJeah5qCwwuUYfODLt5fMjVaUbjOIQamyvHM9myLqrYKY39WhINzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WZ5YUZhR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WZ5YUZhR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z8QmC45Vzz2yh2
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Mar 2025 23:37:29 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741351045; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=f0IPANNTPJveWPHPHrluj1MWRZ36YTelMvTpuJcLvWI=;
	b=WZ5YUZhR+sguSPhl150j8A4xH7bEcDlokgITou/8bQOVXkjwl5Ubz7OVAl4H8wPKTRpBSdFcIYGIYBaL/s6S3bTx4qMdERwkaD0pxo/sE+uuktqvQ6nyhoY/ctc/4DjTdP1bW+W8JFknWS3H/muATpAG0XEMHFqm5gyfRwcXT7c=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQsDOE4_1741351039 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Mar 2025 20:37:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs-utils: lib: error out if fragment_off is crafted
Date: Fri,  7 Mar 2025 20:37:18 +0800
Message-ID: <20250307123718.1535556-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20230922183055.1583756-3-hsiangkao@linux.alibaba.com>
References: <20230922183055.1583756-3-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

Found in some fuzzed images.

Fixes: f511cfbbc0da ("erofs-utils: introduce fragment cache")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/fragments.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/fragments.c b/lib/fragments.c
index 2f5fbf9..05bbf0d 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -524,6 +524,11 @@ int erofs_packedfile_read(struct erofs_sb_info *sbi,
 			erofs_blk_t bnr = erofs_blknr(sbi, pos);
 			bool uptodate;
 
+			if (__erofs_unlikely(bnr > (epi->uptodate_size << 3))) {
+				erofs_err("packed inode EOF exceeded @ %llu",
+					  pos | 0ULL);
+				return -EFSCORRUPTED;
+			}
 			map.m_la = round_down(pos, bsz);
 			len = min_t(erofs_off_t, bsz - (pos & (bsz - 1)),
 				    end - pos);
-- 
2.43.5


