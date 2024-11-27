Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA949DA4BF
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 10:28:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XyvJZ01DPz2ysb
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 20:28:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732699723;
	cv=none; b=DFddqJ4/IQwNTYZUjJ/KslLIfdPMpGpzXd70cjlr5+hSQyBOyDqQhIfUkq4TM1UHtKjJy93khRNaJhDMFAOkIco7ruzPmIlqnccFUciD+4PILevmTqMKBq1t5OZnPNlXhkse0hzD7psX6Q80j88cmLd2FKIkFF3YyE9vn9MVVCUxltr82huQBUnmrad5aJ3I/03yW0xucWeSTpXLFvTg/SbRHllrqYvTAK2iaz6zj9+TlzU33Xlr4Ml1wiCxU2dHUmoyAScLDxV2oHx4/09GqIZrf2vhhlSSd/k5azKjNNNzcZqwqWMuIeMZOeAa5zKmOdJti1OWQqGazeCy4ZiRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732699723; c=relaxed/relaxed;
	bh=pJYOx35HQOVs4Y0+8XUJvIJst89wgbIH/MQa+hIlBZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cBsfMGYnkShg3ks33mtamcj7hc1UXvf1PGhvqZT8qJRDBBfGaWKDA1EfL9qklIBTouh2AA9Ox/HfGrj1+be4RYhfLBQh7eeBYG6XqKX33yD+QQ2w5GMg6Ty3sfb/XSnWoTj2EGSLYigb/sqmWBiHt7HCf26sOwCZZMHHKpqIVgTahDEsPf0iqlMVRd3cGf7dRV5/VZt+C3nsllxdtWH3/zU//d7swg//C8JMrQB+0vYV2Lg8PzTZaFDLbPCGXBITylBRbDK9biJcq41Cd3rBDQMvu12d4mHU74w7dAqOCFTJxenkd4AMwVOYz3vZCdjVJHr16Wk4uY6goDK5wbz7xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LbR8qe+j; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LbR8qe+j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XyvJN0QzWz2y8X
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Nov 2024 20:28:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732699709; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pJYOx35HQOVs4Y0+8XUJvIJst89wgbIH/MQa+hIlBZY=;
	b=LbR8qe+jBPRVWiiM1ZGqLBBr34mvTINF5LuHqiUqdCsZtGuCoXGh7HhyAPk1CWUz3T1tzAOAoUVBmox2K1qBU/wsT9H1vBvKXhspY5Zb+95HNxMUP00LRIqiX6PTDflnOeLkNJvmpuXDWXoEIefkctxa/U+AYI+19EUR0KXViLQ=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WKMA4eD_1732699706 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 17:28:27 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: avoid silent corruption caused by `c_root_xattr_isize`
Date: Wed, 27 Nov 2024 17:28:25 +0800
Message-ID: <20241127092825.4105724-1-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When `c_root_xattr_isize` is too large, `i_xattr_icount` will overflow,
resulting in silent corruption of the filesystem image. This patch performs
checks in advance and reports errors.

Fixes: 8f93c2f83962 ("erofs-utils: mkfs: support inline xattr reservation for rootdirs")
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 lib/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/inode.c b/lib/inode.c
index f553becb0be0..e2888a439484 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1717,6 +1717,12 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 		list_del(&root->i_hash);
 		erofs_insert_ihash(root);
 	} else if (cfg.c_root_xattr_isize) {
+		if (cfg.c_root_xattr_isize > EROFS_XATTR_ALIGN(
+				UINT16_MAX - sizeof(struct erofs_xattr_entry))) {
+			erofs_err("Invalid configuration for c_root_xattr_isize: %u (too large)",
+				  cfg.c_root_xattr_isize);
+			return -EINVAL;
+		}
 		root->xattr_isize = cfg.c_root_xattr_isize;
 	}
 
-- 
2.43.5

