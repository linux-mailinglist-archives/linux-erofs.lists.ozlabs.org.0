Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B1AA039CD
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Jan 2025 09:28:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YS42P5cV4z3by8
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Jan 2025 19:28:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736238523;
	cv=none; b=NDkkZSEL0u1zCjGIHAjfrEzKeZpUM0H5xVZv4dByYhZJWmVrYwOFV1lpV6BdTU/OcOfXkFh242scX5d381DlD9zUoyQvpJ9vHd8qWs4AcKGfoIZVasPT6igKdmf0diHE9QSaXzcozpdiDwxAeDJT1i5J6m3nkkBrCvz2CHS2tP/oT5D1PP2cHZW934Jhuz9QGEsa+Kxro9ypRZ9O7OfnbtU1eNgcB+/+1gtKwDQl0uc4/g+JGz8yTMIKLw8ICDN30vYlongEJwLyfZkI3jqaIUDzuHgtocvl26nFPWEKHVDonTzOlCqYzGb+8EtOO97053tjgeYyRHRPMSmzZTfDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736238523; c=relaxed/relaxed;
	bh=DfBJpSrl9oJXWPx5aFxJyiA8n3Wju7yxjpoh7g4Ono8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfKcqBj1Z7OQn+A4c4JrjwAzjEEceBaLNy9SKrYNpatY/AmdRf+AAY3aF5mbLBodQyKtoXS/EJSDByIxiHe16l3IeOcTHDZadrienPwiXpKuflpYaCoWwWftWLt8fFM+uk8OI6plaZp6FjOpGqt8JWkdG8P5uVswUWwHJNWAx9EF8XPUTZQAWfmANnZ2IcfxIJZRK2w/iwwsYk8TYq2171Y8uBjyRcCbSRVcfmBkEzEGZpjVbHh3J5KzpYRRsLXk5riWBqabQ1OBJ8qFuNm7XaPresvdj+Q5X1y3JLcWWHCRr8OQGxhPkaV1yTiHWgxq11Ix5TLpYcG0N4yHsa3QCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F29yYxI+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=F29yYxI+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YS42J6SF4z2y8p
	for <linux-erofs@lists.ozlabs.org>; Tue,  7 Jan 2025 19:28:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736238512; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DfBJpSrl9oJXWPx5aFxJyiA8n3Wju7yxjpoh7g4Ono8=;
	b=F29yYxI+cloSH8CIwfnUDB5HJ2wAtFMGkmTd7gGkl9oWLRubqDgKN3Fs38MZfvXSkwEofJQU5pT1Avb+MilcJ1rtG962i0qTfS+q2HaptwTdTDBtCRvBeePVGwBYoSAyMaXjExz0JtDwqIlznbhG8ySFGbTi8NPzPaXlmlGOZ7I=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNA-Fid_1736238506 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jan 2025 16:28:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: shorten bvecs[] for file-backed mounts
Date: Tue,  7 Jan 2025 16:28:25 +0800
Message-ID: <20250107082825.74242-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

BIO_MAX_VECS is too large for __GFP_NOFAIL allocation. We could use
a mempool (since BIO can always proceed), but it seems overly
complicated for now.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fileio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 33f8539dda4a..0ffd1c63beeb 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -6,7 +6,7 @@
 #include <trace/events/erofs.h>
 
 struct erofs_fileio_rq {
-	struct bio_vec bvecs[BIO_MAX_VECS];
+	struct bio_vec bvecs[16];
 	struct bio bio;
 	struct kiocb iocb;
 	struct super_block *sb;
@@ -68,7 +68,7 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 	struct erofs_fileio_rq *rq = kzalloc(sizeof(*rq),
 					     GFP_KERNEL | __GFP_NOFAIL);
 
-	bio_init(&rq->bio, NULL, rq->bvecs, BIO_MAX_VECS, REQ_OP_READ);
+	bio_init(&rq->bio, NULL, rq->bvecs, ARRAY_SIZE(rq->bvecs), REQ_OP_READ);
 	rq->iocb.ki_filp = mdev->m_dif->file;
 	rq->sb = mdev->m_sb;
 	return rq;
-- 
2.43.5

