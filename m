Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF6B9F30F0
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 13:53:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBfy416pkz3c9R
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 23:53:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734353608;
	cv=none; b=jwaShBPhhsjN21mKna+7ceyiBtG9aqAhi0LGeEeXKuWo+toF0/3OYeO7dqEE7zzBkSEqLVxd19T6WvrFp+FClzITrOT6Pni6jIRspgZHktTaIcpXFIIo8qWPy9QkOyL5gcfyq1EX8S7m2hEpvTB6oDSNUdxBvJITBKUnV9IJRSzxZJiuu5JwKjVsoiTsJ6CCLOUCHiDlXoRurlv0jVR3lEHYN6ssezh6HCplLm3O7CPbZszKT3uMrPfa7qsFF4zRAWmKT5qDYDPy6ZMfj/AqDMvm6jjZ4P0SRrDDgdSxc7BdS1OJGoXumjjQpZ7iOBdYLGIuH0jQnniPrz1fevExFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734353608; c=relaxed/relaxed;
	bh=O+t8H2XJafDbltXMzJkoJcKKsEcat/SyJLn+cTobu2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD0oiYBtcQOYIWpAGm06Ikb/+wKOCw3l86ljXh2iRlcBXhD88uiAkRRuSESw0iAUV/2CVN90wIzmFNdFTgJ7BC1qaY8mEVehDnBpOfhEQkeOdzslWc+LlJDC/NOiYnY4qhxFP1XkAas7GEJM+bhJZBCPLviyRdKEJLtlIxzTL2+XgxMPtyHi34tWNznZEJS45zTeMO2J9RXBj5+nGjjJ71kYjj2HIj904whlC2cnFYsjFJesCBTnlh5s53bqxe8j4fmN+PWJYCHmJEqlrWAmgtIplpgNOxuiTIQUplJY6IsO6+sumTdI03c8DKgCjwVlNxC0+hKX1bZP8elNvSRiTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n3s8p9eU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n3s8p9eU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBfxx52Flz2yyT
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Dec 2024 23:53:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734353601; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=O+t8H2XJafDbltXMzJkoJcKKsEcat/SyJLn+cTobu2c=;
	b=n3s8p9eUacGlAd6v246D1bPSMzBcD5OVEt6RzrUXdRuyQtYSdcqKI+mFNk40GagA0A34w37UtcG/XSVDk6mD925oDDTx9W8o/WSzhny9PAPqvvCks6ygT7VQd97b2j6ZucT7nQNfHiUKtD1SIAq/TuDTiHabhowOogzG12cskv0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLcksMJ_1734353599 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Dec 2024 20:53:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 4/4] erofs: use buffered I/O for file-backed mounts by default
Date: Mon, 16 Dec 2024 20:53:10 +0800
Message-ID: <20241216125310.930933-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
References: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
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
Cc: Derek McGowan <derek@mcg.dev>, Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

For many use cases (e.g. container images are just fetched from remote),
performance will be impacted if underlay page cache is up-to-date but
direct i/o flushes dirty pages first.

Instead, let's use buffered I/O by default to keep in sync with loop
devices and add a (re)mount option to explicitly give a try to use
direct I/O if supported by the underlying files.

The container startup time is improved as below:
[workload] docker.io/library/workpress:latest
                                     unpack        1st run  non-1st runs
EROFS snapshotter buffered I/O file  4.586404265s  0.308s   0.198s
EROFS snapshotter direct I/O file    4.581742849s  2.238s   0.222s
EROFS snapshotter loop               4.596023152s  0.346s   0.201s
Overlayfs snapshotter                5.382851037s  0.206s   0.214s

Fixes: fb176750266a ("erofs: add file-backed mount support")
Cc: Derek McGowan <derek@mcg.dev>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fileio.c   |  7 +++++--
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 23 +++++++++++++++--------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index a61b8faec651..33f8539dda4a 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -9,6 +9,7 @@ struct erofs_fileio_rq {
 	struct bio_vec bvecs[BIO_MAX_VECS];
 	struct bio bio;
 	struct kiocb iocb;
+	struct super_block *sb;
 };
 
 struct erofs_fileio {
@@ -52,8 +53,9 @@ static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 	rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	rq->iocb.ki_ioprio = get_current_ioprio();
 	rq->iocb.ki_complete = erofs_fileio_ki_complete;
-	rq->iocb.ki_flags = (rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT) ?
-				IOCB_DIRECT : 0;
+	if (test_opt(&EROFS_SB(rq->sb)->opt, DIRECT_IO) &&
+	    rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT)
+		rq->iocb.ki_flags = IOCB_DIRECT;
 	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
 		      rq->bio.bi_iter.bi_size);
 	ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
@@ -68,6 +70,7 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 
 	bio_init(&rq->bio, NULL, rq->bvecs, BIO_MAX_VECS, REQ_OP_READ);
 	rq->iocb.ki_filp = mdev->m_dif->file;
+	rq->sb = mdev->m_sb;
 	return rq;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 7cc8e1be04e8..686d835eb533 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -176,6 +176,7 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_POSIX_ACL		0x00000020
 #define EROFS_MOUNT_DAX_ALWAYS		0x00000040
 #define EROFS_MOUNT_DAX_NEVER		0x00000080
+#define EROFS_MOUNT_DIRECT_IO		0x00000100
 
 #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9044907354e1..f5956474bfde 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -364,14 +364,8 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 }
 
 enum {
-	Opt_user_xattr,
-	Opt_acl,
-	Opt_cache_strategy,
-	Opt_dax,
-	Opt_dax_enum,
-	Opt_device,
-	Opt_fsid,
-	Opt_domain_id,
+	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
+	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
 	Opt_err
 };
 
@@ -398,6 +392,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_string("device",	Opt_device),
 	fsparam_string("fsid",		Opt_fsid),
 	fsparam_string("domain_id",	Opt_domain_id),
+	fsparam_flag_no("directio",	Opt_directio),
 	{}
 };
 
@@ -511,6 +506,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 		break;
 #endif
+	case Opt_directio:
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+		if (result.boolean)
+			set_opt(&sbi->opt, DIRECT_IO);
+		else
+			clear_opt(&sbi->opt, DIRECT_IO);
+#else
+		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
+#endif
+		break;
 	default:
 		return -ENOPARAM;
 	}
@@ -948,6 +953,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",dax=always");
 	if (test_opt(opt, DAX_NEVER))
 		seq_puts(seq, ",dax=never");
+	if (erofs_is_fileio_mode(sbi) && test_opt(opt, DIRECT_IO))
+		seq_puts(seq, ",directio");
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (sbi->fsid)
 		seq_printf(seq, ",fsid=%s", sbi->fsid);
-- 
2.43.5

