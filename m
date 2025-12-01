Return-Path: <linux-erofs+bounces-1458-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 78269C95985
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 03:38:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKSkv2NHFz2yv1;
	Mon, 01 Dec 2025 13:38:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764556711;
	cv=none; b=OpUNxX2do0xrk/LdV0MD9ZmJjMUJveQmVX+FWVoDtx3mKzlL0DcBlIXpABLGZUcsi8+quYU68sMn+Zn3/N8FIMujd8i74LImpQaWiNSTqTBFTw9+rJrI6eIz2HPULWxH4/dQWQf3vEmNMMWPflpHkEx2zy0rMzisdVbdEHj6eRGaU3+uitOEVANt3UnebKJP44QLIwXNOSTLdCv6ldbVW7p8tx1gvv+4Ach6XdHpZLUFBYUMLmEQpbBY2WlswyUDkM4OxdTdPXVjf7oeQw1+ujhTxmhig4J0T3wT66npwR6aaDn0tDB2+Mz4qjV3AWLOYpQNIbykwbbKZ70w7jUDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764556711; c=relaxed/relaxed;
	bh=dGMuG/uhfFS031kWTMc0pshBSmQ8+D9uJQLSsOT9IGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mTHfU+i8mUWhgCRIuLuSd7BAMhgWmR0MzeIZC2e0kWJXgD+T87tqxeFKI7m8UNMzF9rP3Bupn2H7p8aJIa2uS/hn+dnXNKeOTy3pbvBCLJRhORZS26Yg4LF8rySC5qqI6Qg3LgtdOIj8R+ExqSIDd83Pfup0SFkC2yGzuATtG/upIgO2/LJY2KYxI6AEGYmyy58+mlvLS0VqVO/uAH9QrWvEWgNcjiKMQ516znfKlVQCukcwJf1z8vFQVk8cw1dxAsI+w/Vn8JjmlAiBGTSq+yGjTjQ2SoTKkUK/ZUbjHhEuAy9OJRmydZV6Lm1EueQ+C24itYnce68L6Pmj4GgrxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=M75Cpv9v; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=M75Cpv9v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKSkr4BC1z2ypW
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 13:38:26 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764556702; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dGMuG/uhfFS031kWTMc0pshBSmQ8+D9uJQLSsOT9IGs=;
	b=M75Cpv9v6laxTS6lWRyWwLtQrpbGVefzpOM9C/poamIivITpRNFqtbiyhXxKINGyOGyAzf6zvxmPlnzScxTDJBwnulvXFytjeYTQ3nu2qy0vfrC4Dz1MWrKLRzWNGqSY986WUt0eSBf09sh7Y2HYcrXuooSAvAZLqRJiz+YTd9M=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtkUtv7_1764556697 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Dec 2025 10:38:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: switch on-disk header `erofs_fs.h` to MIT license
Date: Mon,  1 Dec 2025 10:38:16 +0800
Message-ID: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
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
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Switch to the permissive MIT license to make the EROFS on-disk format
more interoperable across various use cases.

It was previously recommended by the Composefs folks, for example:
https://github.com/composefs/composefs/pull/216#discussion_r1356409501

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 3d5738f80072..e24268acdd62 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
+/* SPDX-License-Identifier: MIT */
 /*
  * EROFS (Enhanced ROM File System) on-disk format definition
  *
-- 
2.43.5


