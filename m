Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500C5A30D54
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2025 14:54:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739282065;
	bh=aDo82in/U0UpoTuoJgujYWiAbI8aNNOmQ0+3zUIpggM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Chc4CvJdg4r9jDjOw+2UWvIfd7CyXceXquiTrMPqagLNyOq/DQDxrwOVnQrANTlyB
	 COEqo+iI7vbi27Qs9xUs6FDPGZxwwph10S8bo71WLKqDM5EietrvmRbw6BoTW0av/g
	 5tk2zWGOuyjOlgmmjhqMTjT455EfgUYMRvbzoblvKyMDjygMQpGFmgKFH7x4izPd/5
	 /cG/JD9FcY5ziTcCf4tc6yh+HmMbt5nfSJwmWzzxCFM0/kNzbKgSI+HmNjIphg0l2L
	 xbOAjoLlu2PuNnLM9W8Fm1FqLAT631ih4co3CUltqZcmqwRbLvWvtSVqn/fYS7jqAj
	 KVjUbkzz3zR1A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ysjc15Y0Kz30VZ
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 00:54:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.255
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739282063;
	cv=none; b=PWXZbN34lg6jR/z/Aa/Uy/GVsnzSWS6236y3/7jBNIWmFSncEUMDTbI1d6iO40WAyQ15XI79IrW/eg8mYYg/oQZw5Fg5sbev8Joq+FOr4j/IFpYtFgyrleiYqs/XSTMo/fdRn+d4YmDouPGOYqiLdh4fkfuQAh89PDvpTugDypN0XQ2WOPNmxmiZ3eVKsxfH8lZkUy+6Jn6qLfu2DkDobB+OkacdKg5/0xwgWQPxSxrV8Q7kKNFKsfjfU58jR0+VN7J9OicERs0kHZYwJCVRlsusHpkgEIX0WRvYGxzksvXBeZVKhiw6xHjIpjbFkZ8G8aFcuNuvOeJz/A3V6AOa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739282063; c=relaxed/relaxed;
	bh=aDo82in/U0UpoTuoJgujYWiAbI8aNNOmQ0+3zUIpggM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EM4bhEcalDfn+pX4z4c0jvaV1EuYtBkSYsspuRj6srG513QFWuQPmi3oL2kHFvs61sZLl6J5XQJ3gscgifJuPgLhBl0tf2NNdyx5lGAMfzulgESfxJglp8o+i7D5+FkvFExa0nGg0H389lZHo2B0Ip/LS0fkykzVLPWp/Uv6A8pHfA1IHbvp1IiUjJOSEO3JRt5y2xYBy4s/QyZnlZb8boZMSfyRuQ7WlELGcOz0vxdXFcE2b7j014wOsMJhgz8FCDxQ7F+Kue875rLCqZi6c1CBHX321/zjqPSSRqwPJWivgS0p8ReycSRLctTFfLDW1crmOxOEx8c89hoqqSn3ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ysjby33Wrz305G
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 00:54:20 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YsjVj3jsBz1W5Zn;
	Tue, 11 Feb 2025 21:49:49 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 609B51402C3;
	Tue, 11 Feb 2025 21:54:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Feb
 2025 21:54:14 +0800
To: <xiang@kernel.org>, <chao@kernel.org>
Subject: [PATCH v2 3/4] erofs: add erofs_fileio_direct_io helper to handle direct io
Date: Tue, 11 Feb 2025 21:53:30 +0800
Message-ID: <20250211135331.933681-4-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211135331.933681-1-lihongbo22@huawei.com>
References: <20250211135331.933681-1-lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

erofs has add file-backed mount support. In this scenario, only buffer
io is allowed. So we enhance the io mode by implementing the direct
io. Also, this can make the iov_iter (user buffer) interact with the
backed file's page cache directly.

To be mentioned, the direct io is atomic, if the part of the iov_iter
of direct io failed, the whole direct io also fails.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/fileio.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index cdd432ec266c..b652e3df050c 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -12,6 +12,7 @@ struct erofs_fileio_rq {
 	struct kiocb iocb;
 	struct super_block *sb;
 	ssize_t ret;
+	void *private;
 };
 
 typedef void (fileio_rq_split_t)(void *data);
@@ -24,6 +25,11 @@ struct erofs_fileio {
 	fileio_rq_split_t *split;
 	void *private;
 	bio_end_io_t *end;
+	/* the following members control the sync call */
+	struct completion ctr;
+	refcount_t ref;
+	size_t total;
+	size_t done;
 };
 
 static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
@@ -50,6 +56,13 @@ static void erofs_folio_split(void *data)
 	erofs_onlinefolio_split((struct folio *)data);
 }
 
+static void erofs_iter_split(void *data)
+{
+	struct erofs_fileio *io = (struct erofs_fileio *)data;
+
+	refcount_inc(&io->ref);
+}
+
 static void erofs_fileio_end_folio(struct bio *bio)
 {
 	struct erofs_fileio_rq *rq =
@@ -62,6 +75,25 @@ static void erofs_fileio_end_folio(struct bio *bio)
 	}
 }
 
+static void erofs_fileio_iter_complete(struct erofs_fileio *io)
+{
+	if (!refcount_dec_and_test(&io->ref))
+		return;
+	complete(&io->ctr);
+}
+
+static void erofs_fileio_end_iter(struct bio *bio)
+{
+	struct erofs_fileio_rq *rq =
+			container_of(bio, struct erofs_fileio_rq, bio);
+	struct erofs_fileio *io = (struct erofs_fileio *)rq->private;
+
+	if (rq->ret > 0)
+		io->done += rq->ret;
+
+	erofs_fileio_iter_complete(io);
+}
+
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 {
 	struct iov_iter iter;
@@ -158,6 +190,7 @@ static int erofs_fileio_scan(struct erofs_fileio *io,
 				if (err)
 					break;
 				io->rq = erofs_fileio_rq_alloc(&io->dev);
+				io->rq->private = io;
 				io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
 				io->rq->bio.bi_end_io = io->end;
 				attached = 0;
@@ -230,7 +263,45 @@ static void erofs_fileio_readahead(struct readahead_control *rac)
 	erofs_fileio_rq_submit(io.rq);
 }
 
+static ssize_t erofs_fileio_direct_io(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	size_t i_size = i_size_read(inode);
+	struct erofs_fileio io = {};
+	int err;
+
+	if (unlikely(iocb->ki_pos >= i_size))
+		return 0;
+
+	iter->count = min_t(size_t, iter->count,
+			    max_t(size_t, 0, i_size - iocb->ki_pos));
+	io.total = iter->count;
+	if (!io.total)
+		return 0;
+
+	io.inode = inode;
+	io.done = 0;
+	io.split = erofs_iter_split;
+	io.private = &io;
+	io.end = erofs_fileio_end_iter;
+	init_completion(&io.ctr);
+	refcount_set(&io.ref, 1);
+	err = erofs_fileio_scan(&io, iocb->ki_pos, iter);
+	erofs_fileio_rq_submit(io.rq);
+
+	erofs_fileio_iter_complete(&io);
+	wait_for_completion(&io.ctr);
+	if (io.total != io.done) {
+		iov_iter_revert(iter, io.done);
+		return err ?: -EIO;
+	}
+
+	return io.done;
+}
+
 const struct address_space_operations erofs_fileio_aops = {
 	.read_folio = erofs_fileio_read_folio,
 	.readahead = erofs_fileio_readahead,
+	.direct_IO = erofs_fileio_direct_io,
 };
-- 
2.34.1

