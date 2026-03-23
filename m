Return-Path: <linux-erofs+bounces-2946-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJRGLAvywGkUOwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2946-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 08:55:55 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE742EDED1
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 08:55:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQTN1t61z2yfs;
	Mon, 23 Mar 2026 18:55:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.143.211.150
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252552;
	cv=none; b=HoS2mNUSK0Zm3RwAPk3poAIgT422JogwmSbSfmuifUla1hKAI0EEhbv7rgTsJaz+94FU7gEMvXW4nea44bviW3qpG+473nybIFFiH5saaDJwp4g9lZKzvtJ/L+OBRgnLelwmHY7JQT9woj7f1kw1HGVP3N0R14+Dd6EOWkeOIl00elTDuLmPgd6gTFsxSTr6t3t4R2zoJfqtkLWxjaiPhqsxSLT2YLg4b/M0OEB0X9ipE9GPpjoasFx6mai+xcJTX5t3xSD3XOeiv6sT1Wz5aAMfOJ2KHyO/KtV0JaW+6ZgLwSVfRSy3yg2GmyeR9ff6vNOv9qplHEhmWif+PM18SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252552; c=relaxed/relaxed;
	bh=MFw/vB8P7VLJD61eJATtRx37nqbkMe0J8+xFPuYrJvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qai0L5UqWoudRNeL8DqOOnF0EENtI1hn3q8vM5/ldlReUQV8Eakqc4eurwUN/OVXihaaAiROARFNq180H9mX14Ys0fsKQAo8F2bCar4OeBbMSQLNnXy8GiR/hsN9aYs4JYm4c80ARwBei+EEJxGMPr3OfSCPEyW0UYOlu6p65ibNaxD9t+eEmBbssvORfcSEll24jUGb49Im885tvW/z9xUXvwASxjGOXd7BFKEkuEJmVhx5cHR7F41fbRLmooJ1RrTVJrlfJZI14zTYLaOs8v1Ms927o5wlhi6bLK1vaz1FVRbJMWTlI52Kg81KO1qESYhOfXNkKwfXasyLE1f3GQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; dkim=pass (1024-bit key; unprotected) header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=L4lneEn1; dkim-atps=neutral; spf=pass (client-ip=95.143.211.150; helo=mx.swemel.ru; envelope-from=arefev@swemel.ru; receiver=lists.ozlabs.org) smtp.mailfrom=swemel.ru
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=L4lneEn1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=swemel.ru (client-ip=95.143.211.150; helo=mx.swemel.ru; envelope-from=arefev@swemel.ru; receiver=lists.ozlabs.org)
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQTK1Rgjz2yfl
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 18:55:49 +1100 (AEDT)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1774252090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFw/vB8P7VLJD61eJATtRx37nqbkMe0J8+xFPuYrJvQ=;
	b=L4lneEn13a7wHcip66v1l2hXTXW+pN7j2AWRig9HY9F1A4XZFDV00ILPxqBos9TTRsjb5d
	Ewo2TErc7WIdziEvQjCh1J0iSjL/TAPavhBkMCc0WAP4XUQKd5tYAOjiQKjnWak3F+2ZTd
	BwHm4SA2zeeBMAy5NvK7tcN2DtRqkuQ=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.1 1/1] erofs: enable large folios for iomap mode
Date: Mon, 23 Mar 2026 10:48:06 +0300
Message-ID: <20260323074809.4542-2-arefev@swemel.ru>
In-Reply-To: <20260323074809.4542-1-arefev@swemel.ru>
References: <20260323074809.4542-1-arefev@swemel.ru>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[swemel.ru,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[swemel.ru:s=mail];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:xiang@kernel.org,m:chao@kernel.org,m:huyue2@coolpad.com,m:jefflexu@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:hsiangkao@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[arefev@swemel.ru,linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2946-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[swemel.ru:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arefev@swemel.ru,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,syzkaller.appspot.com:url,swemel.ru:dkim,swemel.ru:email,swemel.ru:mid]
X-Rspamd-Queue-Id: CBE742EDED1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jingbo Xu <jefflexu@linux.alibaba.com>                                                                               

commit ce529cc25b184e93397b94a8a322128fc0095cbb upstream. 

Enable large folios for iomap mode.  Then the readahead routine will
pass down large folios containing multiple pages.

Let's enable this for non-compressed format for now, until the
compression part supports large folios later.

When large folios supported, the iomap routine will allocate iomap_page
for each large folio and thus we need iomap_release_folio() and
iomap_invalidate_folio() to free iomap_page when these folios get
reclaimed or invalidated.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20221130060455.44532-1-jefflexu@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
Link: https://syzkaller.appspot.com/bug?id=c6aeabd0c4ad2466f63a274faf2a123103f8fbf7
---
 fs/erofs/data.c  | 2 ++
 fs/erofs/inode.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fe8ac0e163f7..c9526c627dda 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -403,6 +403,8 @@ const struct address_space_operations erofs_raw_access_aops = {
 	.readahead = erofs_readahead,
 	.bmap = erofs_bmap,
 	.direct_IO = noop_direct_IO,
+	.release_folio = iomap_release_folio,
+	.invalidate_folio = iomap_invalidate_folio,
 };
 
 #ifdef CONFIG_FS_DAX
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index ad2a82f2eb4c..e457b8a59ee7 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -295,6 +295,8 @@ static int erofs_fill_inode(struct inode *inode)
 		goto out_unlock;
 	}
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
+	if (!erofs_is_fscache_mode(inode->i_sb))
+		mapping_set_large_folios(inode->i_mapping);
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (erofs_is_fscache_mode(inode->i_sb))
 		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
-- 
2.43.0


