Return-Path: <linux-erofs+bounces-16-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43EA562AF
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Mar 2025 09:39:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z8KTV5TSrz2yhG;
	Fri,  7 Mar 2025 19:39:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741336766;
	cv=none; b=i5inUXoLkw1fEzcXjOIXTOxhUiTj0bkEd/joBQK1fxejrX/vO+kEvHpId6YxhuCm98c2R2ZG2yTOEtaY3wiJIpV71L6/KOw/mpJWH/NEgE2DimA/0RvZr9MA0ETIivuULgK4XkzAYPLMP74tYrhguNuxgULEzjcq45UWlFm6m3/qwC7bjMr9Dar0oYeUzZfoLyiyZpOCZA6ickfcavqGFvOTgYuW2b7dvJGr9+PUq2VUh3w821VN6md8vFCxndSKRZgrWto2hQcgnTtsW0nIXDiOndgGfwrWJFNWZ5SAubJ2CTUX8jclK9MOsw1tf9O2NhiSNluASFKf8cNfGjmqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741336766; c=relaxed/relaxed;
	bh=YpChwRMhukdkpSb1PwQAaJ3ciIe0NxIqG++uDlUlGEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUyQW15KZXe15RtvsZqHEoKnKkGbCcffpCAilBnXKP7De/EaS451wGlo05ldM85xCosFe7gKHFn9JDUMGwtPVhS5SYgnpZjMsDWWLTJF+MMQvO/g1VVRX8R1veFltZ82dlzsg1+aOeud3vGsOnoCtsEqrwceSLqduRCjlie+A71qzUXO4zMtXbwJPLx0WjUqZbAQbLwKHR518unIf9rlKg/+O1mYbPAyHfIHT/QminOpCPhU5TGbMDwXyUiEhpyRUha3DlHliChlK1OoIUk/em8BXOKWxAes2pWJyt2FK7P9Y99Ecwd9hcstjfNAnWrHAZ6D/CTbJvbw838iox1udw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hMiHxgjh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hMiHxgjh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z8KTT0dZLz2yYq
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Mar 2025 19:39:23 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741336758; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YpChwRMhukdkpSb1PwQAaJ3ciIe0NxIqG++uDlUlGEk=;
	b=hMiHxgjh28JJ1W6XF64WX6VVxUbAsrdN1u102uIuaB4df1Xj1z6HIY3NT0VGOt+/Gwru1nXwv73CY8LZzrxZcdh672oomAy2GuU+7t2VoLLOX67tDiHq4/qhjKmNOWsKBMxhXORm+feNasQovzk23D6I1zMg9bnhJFMST1AdX6A=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQrdYVr_1741336753 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Mar 2025 16:39:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: error out if fragment_off is crafted
Date: Fri,  7 Mar 2025 16:39:12 +0800
Message-ID: <20250307083912.1223564-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
 lib/fragments.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/fragments.c b/lib/fragments.c
index 2f5fbf9..a345acf 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -524,6 +524,10 @@ int erofs_packedfile_read(struct erofs_sb_info *sbi,
 			erofs_blk_t bnr = erofs_blknr(sbi, pos);
 			bool uptodate;
 
+			if (__erofs_unlikely(bnr > epi->uptodate_size)) {
+				erofs_err("packed inode EOF exceeded @ %llu", pos);
+				return -EFSCORRUPTED;
+			}
 			map.m_la = round_down(pos, bsz);
 			len = min_t(erofs_off_t, bsz - (pos & (bsz - 1)),
 				    end - pos);
-- 
2.43.5


