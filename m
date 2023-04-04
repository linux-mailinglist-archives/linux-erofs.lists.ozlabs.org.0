Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF86D6625
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 16:56:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrW6l5BQLz3cjF
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:56:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ijq7OA9c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KWkIFepV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ijq7OA9c;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KWkIFepV;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrW653NJdz3chc
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 00:55:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhiCGxChrVJlRUkYdDGuEzFvZQCsRtVvsPA45L+6JnY=;
	b=ijq7OA9ceEZH3/stfrO35e4xzocjfRz7YG5zFDC/zVfmhfeUX/Tdrr7HcpS+l4KK6kiuwp
	f5B897eBEmLGz2s3M1odcWFtZPDnmWmoqqnYOwnQYs+PAitfN/B/kqkI9213rsxJJV7SR3
	VZPhBkv+Uej9eq+hJBQVdcEOXY+VCfw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhiCGxChrVJlRUkYdDGuEzFvZQCsRtVvsPA45L+6JnY=;
	b=KWkIFepVGuhAA3THGcN2o0wfPA5+QjtrkbU+fvQxzt1Swck87WuF3Lmt8dp37Uyj6Rrrnu
	KxfBxIyQ3DjVhgabVFLRuTfNW09ImXQdOtpGCXPdqiAjPcBChKyk63Au4uaOzJgdRsgyQb
	7QEG3RAnoL6Zd9VdtEvT/P2w03JRCs8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-QCF1kXIdMV2x-aYKHr0ZEQ-1; Tue, 04 Apr 2023 10:55:37 -0400
X-MC-Unique: QCF1kXIdMV2x-aYKHr0ZEQ-1
Received: by mail-qk1-f198.google.com with SMTP id 187-20020a3707c4000000b007468d9a30faso14842269qkh.23
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 07:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhiCGxChrVJlRUkYdDGuEzFvZQCsRtVvsPA45L+6JnY=;
        b=hUKRw+KmkK8pSlqbGuz3I9fYQvrh+s/SqfAOXGdFO0qHVyGv7mAIPRGsHjcgGFWnb4
         urIkXYiEE0kgcPZAQEL/lDBGHn1KVDG1kCPRFIUk+r3p/+RBw3ua5FLw+vPRi1fI9w4D
         v27b4DoRw7tLPw//SSNqhHiURi09QHn2674xxQyhCmqtQt5soO00HhG4QtTHw267KA3V
         1zhPTusfjMEQeZsxo06F8DUt6Im/gT3Y8kh5eVD1hnYhgMfuGQXn0bRAkrv4AVdmSwAp
         X+Xa3Ccg1gqq0VJJbm6qjL6MTYjq5FXjtVu23AlIF+7Vh0H5iEjne1KJi3UmX6Iz+YWM
         kdSA==
X-Gm-Message-State: AAQBX9c2Tud2HYJ85aWaXCc7ePPEPx0ZNmWoEQoRzxKmamMq9X9l9KaT
	qeMhpAWu82/zPmRvHBSjlqndaoadfWpijcWKFu27jAM3omhzHLMZVs8r/e8eUNRYHxh2BjS0ufS
	yPlEliu2HJ98fQJUFknrHMZM=
X-Received: by 2002:a05:6214:f05:b0:571:13c:6806 with SMTP id gw5-20020a0562140f0500b00571013c6806mr3972711qvb.33.1680620137280;
        Tue, 04 Apr 2023 07:55:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z8MfugNU6YKVlXuq75L3kQ3utmgGFoqTKtMHqOCvYgrWH2c48gYF9y20EeEoB2IWzu0Fdckw==
X-Received: by 2002:a05:6214:f05:b0:571:13c:6806 with SMTP id gw5-20020a0562140f0500b00571013c6806mr3972665qvb.33.1680620136915;
        Tue, 04 Apr 2023 07:55:36 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:36 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org,
	dchinner@redhat.com,
	ebiggers@kernel.org,
	hch@infradead.org,
	linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v2 17/23] xfs: initialize fs-verity on file open and cleanup on inode destruction
Date: Tue,  4 Apr 2023 16:53:13 +0200
Message-Id: <20230404145319.2057051-18-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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
Cc: linux-ext4@vger.kernel.org, agruenba@redhat.com, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_file.c  | 8 ++++++++
 fs/xfs/xfs_super.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 705250f9f90a..947b5c436172 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -31,6 +31,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1169,9 +1170,16 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error = 0;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d6f22cb94ee2..d40de32362b1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -46,6 +46,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -667,6 +668,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 
-- 
2.38.4

