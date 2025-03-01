Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6019FA4AC65
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Mar 2025 15:50:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4p0Q6F7Qz3cll
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Mar 2025 01:50:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740840625;
	cv=none; b=U5jgS8w1UUgoA3DqCeZB4LpTgFUxFOM0W2kaQp8oHrfdQx0RSzib9bzCz0DLLkwH0CQ8ozvksPVJ3HQ+MLt07svivR4KGghIkbgdiPXU0cotjsn15m+NSv6+x+nIhSnrR4lY+aMwusS9qgD2xlTZLtF1aF40TzFeLYAZ8au0BObTirVSiakBG4mvF/E1pYZpCV50Jk7iWAFIYhRz4ryE3eaQIOaLg/a6ylNTlWGaY6VNEfD9A/AvF+tG9UHGlBg3KSV0OXO/EifoEEbKc5DAEpcTGuvZ1wYMDXaywSz0kCnfOVi2MdbllE9fmSXqpLWAyqZdToKQBs8R1kPGHj/Itg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740840625; c=relaxed/relaxed;
	bh=BOTXNFCiusEeI6Bv6xOR/ZPHNnysL9qJrOFxRXLReDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FI/S4ap0Kbzc1C+6INUFt6gcLUXR4fVqpDFzBF/ucmrfXmRaXPxEje35FULHHjvTXicQzRtPpdchBXnYxsgUD7wbN5jlmKJmvqDafmFcNAveZRT0vDuncrzGWcw8CzskjbdyArMshFhAP2u8mOt/SZSjoEPRAn2ZqiArIaUFu1jROvLIf+ytJXye1X1rWT8nckU9DKLYX5mWHbUqkZr1jNwadRBwANhq6vVopFPQeHW4MnmTgcjmyzR/buNDASOvi+QWrsRTTnRoB2iGPxWUTU/PYNlFKq9u2pGPRtYOoKVOpm28I3/FY/lnLRv6aaAaYwOMkID0cWDCLBQnc0xW0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N//ZjzR6; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N//ZjzR6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4p0H72bGz2x9g
	for <linux-erofs@lists.ozlabs.org>; Sun,  2 Mar 2025 01:50:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740840619; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BOTXNFCiusEeI6Bv6xOR/ZPHNnysL9qJrOFxRXLReDE=;
	b=N//ZjzR6VKrtAQ2IP/hmqBwrlb9MEdqiNcrRJNL6EH5BdyQ5CmHN1zTrSTIhsP3w47CtEgSdi5YAgPO/MW0n1CXHeKGVbDuj/0XJ7/v7pWfgBEpGcZC5h9qmBH21g+/0Vq6azUqiy3/y856dPcxERaJPNPQAKgKZZE4TnvWZVyw=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WQSjMs._1740840617 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 22:50:18 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v6 7/7] erofs: implement .fadvise for page cache share
Date: Sat,  1 Mar 2025 22:49:44 +0800
Message-ID: <20250301145002.2420830-8-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch implements the .fadvise interface for page cache share.
Similar to overlayfs, it drops those clean, unused pages through
vfs_fadvise().

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/ishare.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index e68bb1a6cf4b..a7c2be5d6f25 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -230,6 +230,14 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int erofs_ishare_fadvice(struct file *realfile, loff_t offset, loff_t len,
+				int advice)
+{
+	struct file *file = realfile->private_data;
+
+	return vfs_fadvise(file, offset, len, advice);
+}
+
 const struct file_operations erofs_ishare_fops = {
 	.open		= erofs_ishare_file_open,
 	.llseek		= generic_file_llseek,
@@ -238,6 +246,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvice,
 };
 
 void erofs_read_begin(struct erofs_read_ctx *rdctx)
-- 
2.43.5

