Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9BB96EE54
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 10:39:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0V560zY0z306S
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 18:39:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725611944;
	cv=none; b=X49L+0L2OMhlTbAvMDQXWSmi+wCcIfuz3uV8QXpoRExmifD14DE6nd/IMtOCS/tfxvlSxUzsDh89AZHMHHOY/m9hmkAL78PyNzY1Pward8RhWip28UCMe3FbyxDSvSq033MrU47ebnmEwfXKw+Uysgee0pfm1WOrUI40eeE7FAWUQhJ6QhB5W7un1sF6m9JQZGbXeMHxWyAsLeS40WxgcmJeZax5agUDcWUnCasuwabG3c5AW/xel2o++OElg5+s51St7Zghb8TAg8ElBoHl8ESunRE2iMoZK8uouaHcI3VUyg74r9SMCSRs58stMBAtgfsDdjc8xOf/fFBfqm89VA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725611944; c=relaxed/relaxed;
	bh=jKubk8DV3ptbtB5UlHsxlm3ylGc7vJxR32SLoEguG7s=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=EuswN+Yr+VKBa8Th/PC7D5DsP0397P+wMQKlrPZoMMNsAWA8Lir4eKhf5sgmMWrZRe2wLRVrnSWz1frAFBcBEGwO0QYHa8pEuJjSYud4RNKewN/7Q7snMM0My1WOJuGPWhJukWwyfXXGUaPZUelv7AT5UoY4ue6TO2syPQ9xERebJN7HPb+u4RD7yMa92fpG0ZWwkh1SXOLvXyaRAZhOKSX26D4gRUAL3858Sd41HUMSrh6tAVrvsOd0pQnFjv4dZ+UWMNbmlGx1C2nKMU9YJSX/6QxuKauo4m0Ua/8bGZyhQCyQILPeABCWOesgkhR/QZUi1ar7IBPtQXy3JrBAmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jvu6/ADx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jvu6/ADx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0V540YT1z2yvj
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Sep 2024 18:39:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725611940; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jKubk8DV3ptbtB5UlHsxlm3ylGc7vJxR32SLoEguG7s=;
	b=Jvu6/ADxfttA/6GQSKjcepE7RKO3D1tugyFm1G+rYDRTsHBV1g00Toet88WV4U7R/Fn7tMO8F/hAELFroeLc7Uj2xpDgT+ihYroUv7FWXNErmrmg1VInLgvD8KGpOPjo5/4y5ty7rxhFkvjIeL3IDXs01tg/XaXCRTT+bJBGqz8=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEOxFKx_1725611938)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 16:38:59 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 1/2] erofs-utils: lib: introduce erofs_xattr_prefix_index()
Date: Fri,  6 Sep 2024 16:38:48 +0800
Message-ID: <20240906083849.3090392-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Prepare for the feature of exporting extended attributes for
`fsck.erofs`, which requires obtaining the index based on the
name of the extended attribute.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 include/erofs/xattr.h | 2 ++
 lib/xattr.c           | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 7643611..7848fe7 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -61,6 +61,8 @@ void erofs_clear_opaque_xattr(struct erofs_inode *inode);
 int erofs_set_origin_xattr(struct erofs_inode *inode);
 int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
 
+int erofs_xattr_prefix_index(const char *key);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/xattr.c b/lib/xattr.c
index 9f31f2d..1fed7c0 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1681,3 +1681,10 @@ out:
 		erofs_xattr_prefixes_cleanup(sbi);
 	return ret;
 }
+
+int erofs_xattr_prefix_index(const char *key)
+{
+	unsigned int index, len;
+
+	return match_prefix(key, &index, &len) ? index : -EINVAL;
+}
-- 
2.43.5

