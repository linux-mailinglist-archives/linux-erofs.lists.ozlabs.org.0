Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08799FC803
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Dec 2024 05:58:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YJbxD4VTZz30Pp
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Dec 2024 15:58:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735189102;
	cv=none; b=cs9hLeUPdZqkqgX+A9o22YNuECG/teFMCM7XGaHCQJTb4Zugb3lQC8VLyA5DO7kg81ArHoZoblLZjsoEq8Do2AmCJIhVwTj1RRhy6hZS9VsP/mgMdgrD9+g5z8za33czlk9r5BMGsv03wyD9vkoECghNbB0J8D7phozMb/wR9trT2BYaJ8hgUppXHb2a9u992Cn9nZnQe+jVsStb+ua5YWh/dbFWY8Nw7dWklnn7YrYhYtq28LKk+PSwmCPzvZzEhrPct5h5iPp8/pqbJGOsKDRQz7KTJeUb53z2wAmLBCecKN/vJVKl0m7UVCqa758gZ/ZEI6EXO7JMxxEHIGNbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735189102; c=relaxed/relaxed;
	bh=eYRbAHUMFq4CXr5hgyiWZYetYUqJMslXD7u9ncjLzes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CdHq+8Ka9xUWk9YLNfZP3tze1tNM/D/SYXNnm5DC6OrUFh9YLJGTeyZMlFzFZJRaSiWG3wf6U61OM4FSGS4P9KCFj79/1EpQNJERyLJPvV3pv/52x3LuYOYOlVgkXtoCk1EaaTS0kZwoC8wdJNjBj7cG9RmALDUX9YhuZQxmViOiM6BFbn1g3kb0zXTG13exd0k32lCl894hKDEqVYNNbG49CyJ3+W+g9yh/kyG4dG6cav5xkQPhS3bV0qjzZ+q4XsPKVhBj64wQhgibC932TMBl0McpZ0JB4uiReCjK+FJD+sftSBf6A3cOl8WAUM5yyTFMBM6SewT5zqy62z74wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rx3TMRIg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rx3TMRIg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YJbx76pmjz2xsd
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Dec 2024 15:58:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735189093; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eYRbAHUMFq4CXr5hgyiWZYetYUqJMslXD7u9ncjLzes=;
	b=rx3TMRIgMZjOK30HHSQkN5sqwy2TGOqPLcVRl7OScp4hJj/dkwChOzx1vQdO9F/0mLkjiL1ka6VR9+DiGeTec/iAPN/ux1TXfODuww7aSn60Uhv9ZAZrapaGkqqiE65nqnF9BKm35uzY4tto9gEYtov5TzYhd212Wl5Sptf3ZvM=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMH.XvO_1735189091 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Dec 2024 12:58:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: lib: fix LIBARCHIVE.xattr base64 decoding
Date: Thu, 26 Dec 2024 12:58:07 +0800
Message-Id: <20241226045808.95101-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241226045808.95101-1-hsiangkao@linux.alibaba.com>
References: <20241226045808.95101-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Base64 is described in RFC1521 [1], except that LIBARCHIVE.xattr base64
may not have padding at the end of the data using the '=' character.

[1] https://datatracker.ietf.org/doc/html/rfc1521#section-5.2
Fixes: c0063a73b01b ("erofs-utils: lib: support importing xattrs from tarerofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 12bf595..9642e2e 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -399,25 +399,27 @@ int tarerofs_apply_xattrs(struct erofs_inode *inode, struct list_head *xattrs)
 }
 
 static const char lookup_table[65] =
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
 
 static int base64_decode(const char *src, int len, u8 *dst)
 {
 	int i, bits = 0, ac = 0;
 	const char *p;
 	u8 *cp = dst;
+	bool padding = false;
 
-	if(!(len % 4)) {
+	if(len && !(len % 4)) {
 		/* Check for and ignore any end padding */
 		if (src[len - 2] == '=' && src[len - 1] == '=')
 			len -= 2;
 		else if (src[len - 1] == '=')
 			--len;
+		padding = true;
 	}
 
 	for (i = 0; i < len; i++) {
 		p = strchr(lookup_table, src[i]);
-		if (p == NULL || src[i] == 0)
+		if (!p || !src[i])
 			return -2;
 		ac += (p - lookup_table) << bits;
 		bits += 6;
@@ -427,8 +429,12 @@ static int base64_decode(const char *src, int len, u8 *dst)
 			bits -= 8;
 		}
 	}
-	if (ac)
-		return -1;
+	if (ac) {
+		if (padding || ac > 0xff)
+			return -1;
+		else
+			*cp++ = ac & 0xff;
+	}
 	return cp - dst;
 }
 
-- 
2.39.3 (Apple Git-146)

