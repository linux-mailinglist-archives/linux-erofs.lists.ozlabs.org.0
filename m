Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ED741972C
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Sep 2021 17:05:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJ5Xd02fjz2yLJ
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 01:05:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=USgMLJTD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=USgMLJTD; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJ5XZ6XKMz2yHT
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Sep 2021 01:05:02 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5F4460F39;
 Mon, 27 Sep 2021 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632755100;
 bh=1w1TsuyroXmZ3maoxPYqxUTXBvM2Qlfcn/0n3rSewbo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=USgMLJTD7jCB+Fy0BFryvKrhTSN/sJMyZfSe/+UsLF4Luc7GyfAidMwdGEMNK34wi
 hFr7/RsJSdCAO4SIHF/1WJ4ys7ME2J1bsNqwkEWfnU4nutzDS07Av3R3DNFg4OjRlI
 9szIA4jMVu7akUxRqzqPyNr69uoXuE6MqP+OKNNQBmtLcJAwXcnphrSrFap2fJHapJ
 B8JOKxZR8/DIC7a0WH+WVh71TNJgpmg6YWRqaBIQV5gjicssEWl/QsqCzki7QJSCUF
 gd9g3ZnQYZEBamDIPrajar3N44AYoz9rRdPprl5IilFVM/MrFnxQtzHdG5PAorJzIC
 T2IdMrV99kxyw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: erofs_drop_directly_bhops for blob remapping
Date: Mon, 27 Sep 2021 23:04:00 +0800
Message-Id: <20210927150401.14305-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210927150401.14305-1-xiang@kernel.org>
References: <20210927150401.14305-1-xiang@kernel.org>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Easier to understand, no real impact.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/blobchunk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 725b5173a598..661c5d0121a8 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -193,7 +193,7 @@ int erofs_blob_remap(void)
 	remapped_base = erofs_blknr(pos_out);
 	ret = erofs_copy_file_range(fileno(blobfile), &pos_in,
 				    erofs_devfd, &pos_out, length);
-	bh->op = &erofs_skip_write_bhops;
+	bh->op = &erofs_drop_directly_bhops;
 	erofs_bdrop(bh, false);
 	return ret < length ? -EIO : 0;
 }
-- 
2.20.1

