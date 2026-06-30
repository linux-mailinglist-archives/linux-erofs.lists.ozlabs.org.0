Return-Path: <linux-erofs+bounces-3785-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YOikI4AvQ2rKTwoAu9opvQ
	(envelope-from <linux-erofs+bounces-3785-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:48 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F24506DFE76
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=J+A6fbo+;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3785-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3785-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq73q5Tlmz2yY1;
	Tue, 30 Jun 2026 12:52:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782787959;
	cv=none; b=gxK+6hn+LgeT/9XOeNoJNIHWMfvmjLaXRJs2c7rFIgxoQE9kGU0X/XsT3DsEgODFX6IHTEh7UTk6bm+vDU8rXOqLfbnQeBmpoG2oFoXkGb9yC65q9FHBkyU0eNMSaqAg/j9+vDYcvm6jkdVtHx8kbDmIl+FDLd/3275CfDTQs/4CN3780q2t42jTdXx1eij8NtC8TjYfIR/pL1hDSycun7zrvrKwnJkSJTU6MehjnFrYMOMMzuBAHey1PC3rvUZ1lG1Y0aATNU1p3+HShW0N0Bv7iBDZPg9c7/Y56KofOhsjZmUJc6+tsAQrtsKqvjOdI+TOzx3ArdIaQX00lp7gnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782787959; c=relaxed/relaxed;
	bh=l0WJx2OPKbxm8ob0i8qCBjtXlz+l3XV4a3bx9pYeJnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHpfOooKSlgIOwV+F06jOVnH+AX1YtyVpqnrsibhEu9ofL81MzI74ep/j1AwTqoqHn4+PiCFApvKkyOWKTTxBqiFNLg6zoeOMcKsgCf/WfwhhwMg8rgc+DlsxXXutElP1XUUBRdzWHd5ztZh/HZ0hK4bJvDHpxONenHYVs0HfffpGVHoSSzOfNKI+4pOuNk1ZSmH8W/1lMEkzTEGakxxeVZp5fd7nGqP6laso+SVpNBRuMfhuDSq1ltiFniE5ZOe9jo4fbvJ+OxL/T3pymcGRZm+mhE8SCTJPL6T7Jo7jKJ0Ie8wAbt4X0zDOUy+NtfsrFBe/rRcKnng4HkDkgFI6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J+A6fbo+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq73n4PWHz2yYd
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 12:52:36 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782787953; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=l0WJx2OPKbxm8ob0i8qCBjtXlz+l3XV4a3bx9pYeJnI=;
	b=J+A6fbo+AJXK2OWPBXN2R1ik6aiTcLHlIe4U+VEylK388VNt8K+AMTXfWj+GHNlkN/fVhUZ1u+iMNh1K60DQk1fnP5KjHRrn44oE+xEA+NC91NYLPtIwmxel29QHPXHF+AcEajD8spLBUFch07zUdFRwNGyJwY38SVF5uuUOlIQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X5zS2pL_1782787950;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5zS2pL_1782787950 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 10:52:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/7] erofs-utils: lib: fix `PRINTF_ARGS`
Date: Tue, 30 Jun 2026 10:52:20 +0800
Message-ID: <20260630025224.3955763-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260630025224.3955763-1-hsiangkao@linux.alibaba.com>
References: <20260630025224.3955763-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-3785-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F24506DFE76

Coverity-id: 647268
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index d3f922d37739..0523873570a2 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -361,8 +361,9 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 				  erofs_strerror(ret));
 			goto err;
 		}
-		erofs_dbg("Align /%s on block #%d (0x%llx)",
-			  erofs_fspath(inode->i_srcpath), erofs_blknr(sbi, off), off);
+		erofs_dbg("Align /%s on block #%llu (0x%llx)",
+			  erofs_fspath(inode->i_srcpath),
+			  erofs_blknr(sbi, off) | 0ULL, off);
 	}
 
 	for (pos = 0; pos < inode->i_size; pos += len) {
-- 
2.43.5


