Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8540461257
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Nov 2021 11:24:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J2hKP43T6z3bjP
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Nov 2021 21:24:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=l2HeU8pd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+13c9c90cf431a9f4f7f6+6672+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=l2HeU8pd; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J2hHz2M7Nz3cZN
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Nov 2021 21:22:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=CpdIv33J0woQiQie2FA5j4DvYI7ANLTE3cQ274uSOLs=; b=l2HeU8pd8OX8MEvrORrtSs9Bfm
 JS8/QDQuQcqpCPw8NtwBVZ4Y5lx/jMxdkQChoyDWo8sQDQhkRtZ4f64MpzMYtibvbEjwKZlbYb8WF
 HCBrxfA7P0HKGsNtPPLdyRR53HEHh2CGztJ3qyfrdtfWzFwVLPd+VMKa6Ve902TshdXO0D/+4buAK
 Gro9f3w+TbP/PL9bvCYNIPu6P0jl10bpiBhCfF4T/zbTnzJqXQzehxIYiWe/KBJSTjVzesk0Z+Ths
 fKiM476zd599wCnwBQUIDVa33a3A9R/qsjZ49IMBarU00JI7iY0N3hCthPFix/vWH5tIwoekBmDp7
 054Fnt7g==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrdo2-0073ZN-I8; Mon, 29 Nov 2021 10:22:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 28/29] iomap: build the block based code conditionally
Date: Mon, 29 Nov 2021 11:22:02 +0100
Message-Id: <20211129102203.2243509-29-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Only build the block based iomap code if CONFIG_BLOCK is set.  Currently
that is always the case, but it will change soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/Kconfig        | 4 ++--
 fs/iomap/Makefile | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index a6313a969bc5f..6d608330a096e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -15,11 +15,11 @@ config VALIDATE_FS_PARSER
 	  Enable this to perform validation of the parameter description for a
 	  filesystem when it is registered.
 
-if BLOCK
-
 config FS_IOMAP
 	bool
 
+if BLOCK
+
 source "fs/ext2/Kconfig"
 source "fs/ext4/Kconfig"
 source "fs/jbd2/Kconfig"
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 4143a3ff89dbc..fc070184b7faa 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -9,9 +9,9 @@ ccflags-y += -I $(srctree)/$(src)		# needed for trace events
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
 iomap-y				+= trace.o \
-				   buffered-io.o \
+				   iter.o
+iomap-$(CONFIG_BLOCK)		+= buffered-io.o \
 				   direct-io.o \
 				   fiemap.o \
-				   iter.o \
 				   seek.o
 iomap-$(CONFIG_SWAP)		+= swapfile.o
-- 
2.30.2

