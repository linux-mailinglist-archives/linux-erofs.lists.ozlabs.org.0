Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3956D65FF
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 16:55:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrW634gXtz3bZv
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:55:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G1omy9wt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G1omy9wt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G1omy9wt;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G1omy9wt;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrW5h1GN5z3chv
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 00:55:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DCV/M5yyrM1g1B6cxt9ZQ7HQFDQ1socxlG7tzRHhCM=;
	b=G1omy9wtgL1btfmtqxvQ0YSUYcqr2bA2iuVpunQ/s7ZZEoj4MpWbsjnj39MFXyV2zvIj5o
	FB6pEGvHnH5YR8kx0kd77feyqseFAAgwewPYmmoqaF/ARa0thDwMl4hltBQ5Vt14DnueJw
	4qreaGyJevHO7X2Lh6oOkiQ0jyhOyvE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DCV/M5yyrM1g1B6cxt9ZQ7HQFDQ1socxlG7tzRHhCM=;
	b=G1omy9wtgL1btfmtqxvQ0YSUYcqr2bA2iuVpunQ/s7ZZEoj4MpWbsjnj39MFXyV2zvIj5o
	FB6pEGvHnH5YR8kx0kd77feyqseFAAgwewPYmmoqaF/ARa0thDwMl4hltBQ5Vt14DnueJw
	4qreaGyJevHO7X2Lh6oOkiQ0jyhOyvE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-dzhzkDgFMPSFIq_priAjuQ-1; Tue, 04 Apr 2023 10:55:16 -0400
X-MC-Unique: dzhzkDgFMPSFIq_priAjuQ-1
Received: by mail-qt1-f200.google.com with SMTP id f2-20020ac87f02000000b003e6372b917dso10373602qtk.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 07:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DCV/M5yyrM1g1B6cxt9ZQ7HQFDQ1socxlG7tzRHhCM=;
        b=VnIUKpR1Shtf1ohoDyHTfRlx1ZJJ+QWqOsW4/WDkghhQSKO2X1nzRurqin9v8pr8T3
         EfPEvWWU5hGSX4dnI68bcHsqPVRmjw3QaQ/gFgS2eRIWRjKACB49S7kOTyIr7tZlF327
         UXPqyxsklIegjcSssbNqa5qle5si6GmQn4MxUU+w0EXle2uvOVNjhdNspIexKgc857Br
         AmRNym9zJhDQueAL7E/FuDFAu7dXKO6w4y95at7IVgmota8uoJjOqCwu1QGScrMgF5ax
         hivFStNigs/7Qzu0cTioux9kKluQHEVYKKHXcXzm/anULPZi9IL6Mnef4qmkwrCCYTnu
         c8Mg==
X-Gm-Message-State: AAQBX9dGHl87rvGFj4Ui8xFSlDB/ZbwVGx++UlaUMhWrw3v8kqC+uHRs
	5lbR9GVkPNMhj7PGFAXXWOwDLj/tiBUNR1MTJO/+JpeTgKI0zGlua1dWO9zb92om6aUJz1lPWtl
	eQHx8CRZDRle6hR8D3Mb5vKs=
X-Received: by 2002:a05:622a:1002:b0:3e3:8ebe:ce17 with SMTP id d2-20020a05622a100200b003e38ebece17mr3401477qte.43.1680620115385;
        Tue, 04 Apr 2023 07:55:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZeTsqSdwXkQooxtkxa5UspUTLXqFsUhIKZ9BZk1HmO99VPevTQAHz0NwCmfjyQvtO6XB3OTQ==
X-Received: by 2002:a05:622a:1002:b0:3e3:8ebe:ce17 with SMTP id d2-20020a05622a100200b003e38ebece17mr3401445qte.43.1680620115062;
        Tue, 04 Apr 2023 07:55:15 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:14 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org,
	dchinner@redhat.com,
	ebiggers@kernel.org,
	hch@infradead.org,
	linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v2 10/23] xfs: add XBF_VERITY_CHECKED xfs_buf flag
Date: Tue,  4 Apr 2023 16:53:06 +0200
Message-Id: <20230404145319.2057051-11-aalbersh@redhat.com>
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

The meaning of the flag is that value of the extended attribute in
the buffer was verified. The underlying pages have PageChecked() ==
false (the way fs-verity identifies verified pages), as page content
will be copied out to newly allocated pages in further patches.

The flag is being used later to SetPageChecked() on pages handed to
the fs-verity.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_buf.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 549c60942208..8cc86fed962b 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -24,14 +24,15 @@ struct xfs_buf;
 
 #define XFS_BUF_DADDR_NULL	((xfs_daddr_t) (-1LL))
 
-#define XBF_READ	 (1u << 0) /* buffer intended for reading from device */
-#define XBF_WRITE	 (1u << 1) /* buffer intended for writing to device */
-#define XBF_READ_AHEAD	 (1u << 2) /* asynchronous read-ahead */
-#define XBF_NO_IOACCT	 (1u << 3) /* bypass I/O accounting (non-LRU bufs) */
-#define XBF_ASYNC	 (1u << 4) /* initiator will not wait for completion */
-#define XBF_DONE	 (1u << 5) /* all pages in the buffer uptodate */
-#define XBF_STALE	 (1u << 6) /* buffer has been staled, do not find it */
-#define XBF_WRITE_FAIL	 (1u << 7) /* async writes have failed on this buffer */
+#define XBF_READ		(1u << 0) /* buffer intended for reading from device */
+#define XBF_WRITE		(1u << 1) /* buffer intended for writing to device */
+#define XBF_READ_AHEAD		(1u << 2) /* asynchronous read-ahead */
+#define XBF_NO_IOACCT		(1u << 3) /* bypass I/O accounting (non-LRU bufs) */
+#define XBF_ASYNC		(1u << 4) /* initiator will not wait for completion */
+#define XBF_DONE		(1u << 5) /* all pages in the buffer uptodate */
+#define XBF_STALE		(1u << 6) /* buffer has been staled, do not find it */
+#define XBF_WRITE_FAIL		(1u << 7) /* async writes have failed on this buffer */
+#define XBF_VERITY_CHECKED	(1u << 8) /* buffer was verified by fs-verity*/
 
 /* buffer type flags for write callbacks */
 #define _XBF_INODES	 (1u << 16)/* inode buffer */
-- 
2.38.4

