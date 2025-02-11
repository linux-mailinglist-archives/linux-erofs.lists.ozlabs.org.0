Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B30A30D58
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2025 14:54:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739282069;
	bh=zBNCqqnG5FiBPTAwtdHNGzPHYSpHVjfI63qrDUVotRU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=k6+onNAT9o4aWHTFBs4JePwawVYKX/7zoPbZUn/DdPj0FGhcnaXNlrakLQt7b/Q+k
	 4p5HW7BcLW88OTArW5rp3z7kJ8g5L/+elN6zaaIdamuGSS1WtMSuOQf/x6bITx5MAx
	 +UF/37WWDALhrmWNzIWJXUfEsXY4OMLOvRH0cHvNMUjeAsI6a+t9El5pin91G/IBaO
	 zR5+RDhzOKxu2Qvaq4lSP7xxPNNISKNacEBTC0CcnUTHEZ/HypVsSWG1/5+Nyi/QT4
	 vDd6Nuz9sT5KzxMesLzVPWGonJhm0nHGsQYcK8Ou1X9NHHf0ubE/TlhQW9LKMt5cbq
	 NSpKyksSUWqgw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ysjc52n6vz3cX4
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 00:54:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739282064;
	cv=none; b=OslfyYoHOsQPsxsInB3txlWJ1Iv/tck1TyzEhXsLeuwsLRynIQ5/QTJEC7qglmEvKjEXPffKPb/OYJ+sECLXlLu7udgqDLoFbwWwBcU5lEj5+aS0EUlDHYVHPqaPbsMpDKOq8xLsS6fwBDuDWvTgJ/aSDa1v0Eq5XL22m/KMjlcfhu9tvx5KE3fzo0Ty8LQvQvNRjjwCzEDWl0MahVgIYBffcQuaLO4QHFvzCb/4UuQ/zTujxfmliNF/VDO+XhU1QcQO4CB2yhkGCTuoJzYc0jyUff+DKoeDcIyQuKUAOS6UOAsFyF0L0bWHSQ5BewMDfqijCYlxGr8+uuSc6Vco6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739282064; c=relaxed/relaxed;
	bh=zBNCqqnG5FiBPTAwtdHNGzPHYSpHVjfI63qrDUVotRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIFQcFzR5LaFSYtsRKKQT2JBkSy9V5IgJE59jcflIdMpolUyeHOlOq3iGu0U2Cw7vpH8yLYJzuFYfYcNTx4daQX/7bPOYeCgGEcmwU5jak/BxCW40sQ191MCoooEGd+/RT8QTBkMzLQ6NS36T0kNH93BJ4tCx8SeaQ7nNnfP4UbAKDaug6xbbPmJq8ynAqZMVUynIwkbUqNhSOf2kx1PcuK353gtevaQNA5PRbEszr/k9QgEuI8J4HuNrFC5o8fPlMTkDilNJrA0+ImkbuppsVNzIY46pOhga0zJPwL/d0DDpFcHs3D94RUv13nP03Kxg6nrNiWOJLu1UqHs+TdoZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ysjby5bKrz305v
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 00:54:22 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YsjZ00GZ1zrSvn;
	Tue, 11 Feb 2025 21:52:40 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 034001802D0;
	Tue, 11 Feb 2025 21:54:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Feb
 2025 21:54:14 +0800
To: <xiang@kernel.org>, <chao@kernel.org>
Subject: [PATCH v2 2/4] erofs: decouple callback action for fileio bio
Date: Tue, 11 Feb 2025 21:53:29 +0800
Message-ID: <20250211135331.933681-3-lihongbo22@huawei.com>
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

Introduce erofs_fileio_end_folio as the .bi_end_io callback for fileio
bio.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/fileio.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 616dc93c0dc5..cdd432ec266c 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -11,6 +11,7 @@ struct erofs_fileio_rq {
 	struct bio bio;
 	struct kiocb iocb;
 	struct super_block *sb;
+	ssize_t ret;
 };
 
 typedef void (fileio_rq_split_t)(void *data);
@@ -22,14 +23,15 @@ struct erofs_fileio {
 	struct inode *inode;
 	fileio_rq_split_t *split;
 	void *private;
+	bio_end_io_t *end;
 };
 
 static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 {
 	struct erofs_fileio_rq *rq =
 			container_of(iocb, struct erofs_fileio_rq, iocb);
-	struct folio_iter fi;
 
+	rq->ret = ret;
 	if (ret > 0) {
 		if (ret != rq->bio.bi_iter.bi_size) {
 			bio_advance(&rq->bio, ret);
@@ -37,14 +39,8 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 		}
 		ret = 0;
 	}
-	if (rq->bio.bi_end_io) {
+	if (rq->bio.bi_end_io)
 		rq->bio.bi_end_io(&rq->bio);
-	} else {
-		bio_for_each_folio_all(fi, &rq->bio) {
-			DBG_BUGON(folio_test_uptodate(fi.folio));
-			erofs_onlinefolio_end(fi.folio, ret);
-		}
-	}
 	bio_uninit(&rq->bio);
 	kfree(rq);
 }
@@ -54,6 +50,18 @@ static void erofs_folio_split(void *data)
 	erofs_onlinefolio_split((struct folio *)data);
 }
 
+static void erofs_fileio_end_folio(struct bio *bio)
+{
+	struct erofs_fileio_rq *rq =
+			container_of(bio, struct erofs_fileio_rq, bio);
+	struct folio_iter fi;
+
+	bio_for_each_folio_all(fi, &rq->bio) {
+		DBG_BUGON(folio_test_uptodate(fi.folio));
+		erofs_onlinefolio_end(fi.folio, rq->ret >= 0 ? 0 : rq->ret);
+	}
+}
+
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 {
 	struct iov_iter iter;
@@ -151,6 +159,7 @@ static int erofs_fileio_scan(struct erofs_fileio *io,
 					break;
 				io->rq = erofs_fileio_rq_alloc(&io->dev);
 				io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
+				io->rq->bio.bi_end_io = io->end;
 				attached = 0;
 			}
 			if (bio_iov_iter_get_pages(&io->rq->bio, iter)) {
@@ -177,6 +186,7 @@ static int erofs_fileio_read_folio(struct file *file, struct folio *folio)
 	folioq_append(&folioq, folio);
 	iov_iter_folio_queue(&iter, ITER_DEST, &folioq, 0, 0, folio_size(folio));
 	io.inode = folio_inode(folio);
+	io.end = erofs_fileio_end_folio;
 	io.split = erofs_folio_split;
 	io.private = folio;
 
@@ -199,6 +209,7 @@ static void erofs_fileio_readahead(struct readahead_control *rac)
 	int err;
 
 	io.inode = inode;
+	io.end = erofs_fileio_end_folio;
 	io.split = erofs_folio_split;
 	trace_erofs_readpages(inode, readahead_index(rac),
 			      readahead_count(rac), true);
-- 
2.34.1

