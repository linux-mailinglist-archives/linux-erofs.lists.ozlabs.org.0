Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F3396536FD0
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 07:56:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L9nq26W6Fz3blR
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 15:56:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gXUTrQO6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gXUTrQO6;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L9npv3J3yz2yhD
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 May 2022 15:56:23 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 92B5860DD6;
	Sun, 29 May 2022 05:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D742C3411C;
	Sun, 29 May 2022 05:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653803781;
	bh=IJu+gkphhFylVDsQzhP8KOtGyF6aW9neo4uSaI2lipk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXUTrQO6ZFLlgIQrh39yuohMijrv1AGoz4cZf4mzpmJgJNKBlnTG1oFJ7gNnRkKGL
	 +Ls9+4ziGmn3YWT+tngfnuZxDnRk9IkOZcDigGgivbo9yRCd7Ea/bFEAW7wwY5XISi
	 DtFlDDC5lJM3B+4R+esdPxurYgqs5L+cnDdjB8d9ztAlbSYALIHgBNW7Fv4FU6Edcf
	 k/tEMelO8S/J0kl19Yq5xMh5xSZ4dJBarecR2BREdvz/4fd9L5YAEo2z2UZ5jDkpGf
	 zZSNozKaVsc72uFiFG+Drn2Vtd0OLKE4ONw0zf1mHuhkqf39awJrEOCnJlwK0oeDm6
	 3M1jT8Ud4GB9A==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] erofs: simplify z_erofs_pcluster_readmore()
Date: Sun, 29 May 2022 13:54:25 +0800
Message-Id: <20220529055425.226363-4-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220529055425.226363-1-xiang@kernel.org>
References: <20220529055425.226363-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Get rid of unnecessary label `skip'. No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6dd858f94e44..b33fb64b3393 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1436,22 +1436,19 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 		struct page *page;
 
 		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
-		if (!page)
-			goto skip;
-
-		if (PageUptodate(page)) {
-			unlock_page(page);
+		if (page) {
+			if (PageUptodate(page)) {
+				unlock_page(page);
+			} else {
+				err = z_erofs_do_read_page(f, page, pagepool);
+				if (err)
+					erofs_err(inode->i_sb,
+						  "readmore error at page %lu @ nid %llu",
+						  index, EROFS_I(inode)->nid);
+			}
 			put_page(page);
-			goto skip;
 		}
 
-		err = z_erofs_do_read_page(f, page, pagepool);
-		if (err)
-			erofs_err(inode->i_sb,
-				  "readmore error at page %lu @ nid %llu",
-				  index, EROFS_I(inode)->nid);
-		put_page(page);
-skip:
 		if (cur < PAGE_SIZE)
 			break;
 		cur = (index << PAGE_SHIFT) - 1;
-- 
2.30.2

