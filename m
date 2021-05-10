Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BF6377D0A
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 09:23:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FdswY2dN7z301D
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 17:23:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZG6E1rA6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZG6E1rA6; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FdswV6yMNz301J
 for <linux-erofs@lists.ozlabs.org>; Mon, 10 May 2021 17:23:22 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF10461432;
 Mon, 10 May 2021 07:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620631401;
 bh=eoJBH3jjsIafTkNJCvU77OrNOJTMKY1NxSp4l/pAoFU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZG6E1rA6X8vSzIbz/bG9FQoOdcJ7LEnKybTnXCRskibjJfhCjF6WpwAnUrqE7ja+3
 Gmpnzdvn142Jw7/GYxP++Jt3rV4JWrYZWbskRgg4I7XSeENZVIc/IjiGWWljMeoj6c
 0UmojHUaB5HKZsFgl4K1uRRJdODwvipJc+hBzO/4L9r3ZwNLFcR68VSmYnD5jktWh/
 uFV8iZzQ1xGZ9RbbrZsqlCcnp9RDRtJz3YjuSNouImvek4h1IvgnJqGNXUGB0VGiMH
 OF5DorJU6DrAAfiuTRTEtOu311llN/ZDj5apxVeqnhdH+nlaVDn3bzf/oAKhem5SFA
 M83/pVH6tWmfA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH 2/4] erofs-utils: reserve physical_clusterbits[]
Date: Mon, 10 May 2021 15:23:01 +0800
Message-Id: <20210510072303.4628-3-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510072303.4628-1-xiang@kernel.org>
References: <20210510072303.4628-1-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Sync up with kernel commit
54e0b6c873dc ("erofs: reserve physical_clusterbits[]")

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs/internal.h |  1 -
 lib/zmap.c               | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 1339341a0792..da7be569d8ee 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -164,7 +164,6 @@ struct erofs_inode {
 			uint16_t z_advise;
 			uint8_t  z_algorithmtype[2];
 			uint8_t  z_logical_clusterbits;
-			uint8_t  z_physical_clusterbits[2];
 		};
 	};
 #ifdef WITH_ANDROID
diff --git a/lib/zmap.c b/lib/zmap.c
index e2a54b937b7c..0c5c4f52bbd0 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -20,8 +20,6 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
 		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
-		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
-		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
 
 		vi->flags |= EROFS_I_Z_INITED;
 	}
@@ -66,17 +64,6 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 			  vi->nid * 1ULL);
 		return -EFSCORRUPTED;
 	}
-	vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits +
-					((h->h_clusterbits >> 3) & 3);
-
-	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
-		erofs_err("unsupported physical clusterbits %u for nid %llu",
-			  vi->z_physical_clusterbits[0], (unsigned long long)vi->nid);
-		return -EOPNOTSUPP;
-	}
-
-	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
-					((h->h_clusterbits >> 5) & 7);
 	vi->flags |= EROFS_I_Z_INITED;
 	return 0;
 }
-- 
2.20.1

