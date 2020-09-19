Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBF3270B6F
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Sep 2020 09:28:37 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Btj424fLTzDqsw
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Sep 2020 17:28:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=DxInGp9D; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ibc2T1xt; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Btj3r2MKMzDqm6
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Sep 2020 17:28:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600500501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=xApC2kZG8EcnsErnZQz6jR2tMYwegUZKMG/mP3N+5Ys=;
 b=DxInGp9DY+5t2HVQNOPadybzXfQCEggARNZFQvszQ3/Dmqe7LTJtAKz+1MSy8wHu+y5ack
 x2py9H2W4wL9uO/O3r/YBldgYPgNNEFd8+2/fkmrHWwpDhi+IaUN2aGhsKfUSTn7bIBsqJ
 K5vz+heeJT500bDej6eVudPd3CHfnOA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600500502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=xApC2kZG8EcnsErnZQz6jR2tMYwegUZKMG/mP3N+5Ys=;
 b=Ibc2T1xtk+ho/OwAeZw0qPvMP6iTxR4fbNIf89SQe5G4jK77LHe7FT4ufj56A4fM395XSK
 3Af9+FsYITWL5Hw45w0T2fHh0wv0Yq0dWJnJsYhnC3Zd337tlglNF5xqfLUAv4zJ+xLtuq
 2yD2Ji60bsrRb2Lgfal6l/URPdLveuw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-u_gbR8qbMTO2ICpgFP5fCQ-1; Sat, 19 Sep 2020 03:28:20 -0400
X-MC-Unique: u_gbR8qbMTO2ICpgFP5fCQ-1
Received: by mail-pf1-f199.google.com with SMTP id h15so5102759pfr.3
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Sep 2020 00:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xApC2kZG8EcnsErnZQz6jR2tMYwegUZKMG/mP3N+5Ys=;
 b=hAvnrpZC3Q5MRC3ELSiJT71cM4UVBD7zau9noAxGNiuldXVUhOh+2DnRnFURu/AcFw
 DLD0ixuxnzSTtZSIhjMmJ+1wZLPR8Cy/TTBqUlUB854H2C7cwlYulA0NA4RnQ+qfR47W
 TdWWnxnRibdd03iKADrXDHG5F7UpratnlgzZdPwdTrKQMjnWa6OVCIi979cVO8jlKQq6
 Xvc7uR2thdyvBjQhBBfoy6B9elgdvar8GxKW3uhpLfGuk2NDdrvqSNnkoY8nedhgF+4N
 CK01amHw0rRnKN7jc5bOVSYLAFanbIZU82nEpPpQOznnuk1cL5M4bIOK30K05NrKgOYo
 rNBw==
X-Gm-Message-State: AOAM530cAzePEdwy858MD2Vt94oyEZo0Oxw3LuBYi+4xszAph1NKgjDi
 ACeHXO7O55wR/ssVvSqCZkR2Hmc4jUCIVSUbDgXqzDdUFS1X+KvHhdE9lQ3TAdyCo6V2U+uniLD
 I64RCosdtdmDwzPtAstWwfdPJ
X-Received: by 2002:a17:902:b591:b029:d1:e598:740a with SMTP id
 a17-20020a170902b591b02900d1e598740amr18712751pls.61.1600500498737; 
 Sat, 19 Sep 2020 00:28:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgH359QIQRd5hI5pfwvsaJgzRNMzTB3Y/mwN8BxuqR/YT5E+surSi5i6c5ZEg3h2BdrgyJRg==
X-Received: by 2002:a17:902:b591:b029:d1:e598:740a with SMTP id
 a17-20020a170902b591b02900d1e598740amr18712739pls.61.1600500498497; 
 Sat, 19 Sep 2020 00:28:18 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s3sm5407381pfe.116.2020.09.19.00.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2020 00:28:18 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 2/3] erofs: fold in should_decompress_synchronously()
Date: Sat, 19 Sep 2020 15:27:29 +0800
Message-Id: <20200919072730.24989-2-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200919072730.24989-1-hsiangkao@redhat.com>
References: <20200919072730.24989-1-hsiangkao@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

should_decompress_synchronously() has one single condition
for now, so fold it instead.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
no change since v1.

 fs/erofs/zdata.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index e43684b23fdd..bee6ce783c64 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1294,24 +1294,18 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	return err;
 }
 
-static bool should_decompress_synchronously(struct erofs_sb_info *sbi,
-					    unsigned int nr)
-{
-	return nr <= sbi->ctx.max_sync_decompress_pages;
-}
-
 static void z_erofs_readahead(struct readahead_control *rac)
 {
 	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
-	bool sync = should_decompress_synchronously(sbi, readahead_count(rac));
+	unsigned int nr_pages = readahead_count(rac);
+	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
 	LIST_HEAD(pagepool);
 
-	trace_erofs_readpages(inode, readahead_index(rac),
-			readahead_count(rac), false);
+	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
 	f.headoffset = readahead_pos(rac);
 
-- 
2.18.1

