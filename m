Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753EB9FC805
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Dec 2024 05:58:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YJbxG3J4pz3bSb
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Dec 2024 15:58:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735189103;
	cv=none; b=XF4e/LuDyuVeNw3wSM09pYoUAZH09IImORrWhu1pcqF1cjGB9Uq0j4jXCkHVwOfraJ/mb/hrj2i47reSRKDfZv0K64p5Hx0scsdfLWh/b/EJsKazdmtpsUVTgydb59YVx+A87+Tz0qz2J2gBMN4aw59MdN87ZEKm38IId5SRF7cN2V6upwtAQwWcpiMh1xU0Knng7i2dYDhghNnrivmU67DPikI/WhWXP9fofbYjWkJl8SOdXimr0aalzU7/EELv3Vh5duu8ZPidaFNpxXFobpt9tNsn8STkd5sza1VVHhOOoTYQA3JAiH8fm0+CNkijYDvB7Zy23lSnB4y4PpSXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735189103; c=relaxed/relaxed;
	bh=t6wStyV3t9PJnQEyjgfzlexPCpmvC8qsRCzaVUJjTiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgGGH7EqS0+G98lEsx7avYQv8mOYWQYEyPV0JnnmQ/atntA22x9IbZnD36Eid2IfrZui3/lHh5rWpFyrBJbxtAKTIOMoYR5j4VCpgvZWTZq5+Ky+B7jplUQH0PkORe59tfJCzTCnt4JCmD+BuTXIGGD4r5q5oj7PFRaEwk+3FLjpcn/siJCj+NdYrk31wwUOd0Ze097+/EXvQ5CikEBQ/vB4E9xoiddPs26+ik7d9kY4/sqcvC5mQZl6fUolgScTd9mIfWbzRd0XhbvBhMgIV3qRUV0Flg1uwm13D852tK2N+GM64ApIHN2KvULdA4lKPWLyIQT/xkfZ/VwQiF6rsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wDeWy5qW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wDeWy5qW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YJbx952nRz2yb9
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Dec 2024 15:58:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735189097; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=t6wStyV3t9PJnQEyjgfzlexPCpmvC8qsRCzaVUJjTiI=;
	b=wDeWy5qWN86M/7ctumHei9MFEpGxvMQypRpqDPlTIKx6bvzKISWt6uscrHWGk7ECO5hBTKMaTEF2to1xwJzo6pFEc3+gg71bb3plj1QUAF3nKxHE2KiJAP6ZiG8GNP6RNwrWQrIloCaoNqiXo9gQPNFhT+B2v0+KViWjZ+/hm44=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMH.Xvn_1735189092 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Dec 2024 12:58:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: lib: fix LIBARCHIVE.xattr URL-encoded keys
Date: Thu, 26 Dec 2024 12:58:08 +0800
Message-Id: <20241226045808.95101-3-hsiangkao@linux.alibaba.com>
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

As tar(5) [1] mentioned: `The key value is URL-encoded: All non-ASCII
characters and the two special characters "=" and "%" are encoded as
"%" followed by two uppercase hexadecimal digits.`

Fix it now.

[1] https://man.freebsd.org/cgi/man.cgi?tar(5)
Fixes: c0063a73b01b ("erofs-utils: lib: support importing xattrs from tarerofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 9642e2e..2ea3858 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -438,6 +438,47 @@ static int base64_decode(const char *src, int len, u8 *dst)
 	return cp - dst;
 }
 
+static int tohex(int c)
+{
+	if (c >= '0' && c <= '9')
+		return c - '0';
+	else if (c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+	else if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	return -1;
+}
+
+static unsigned int url_decode(char *str, unsigned int len)
+{
+	const char *s = str;
+	char *d = str;
+	int d1, d2;
+
+	for (; len && *s != '\0' && *s != '%'; ++d, ++s, --len);
+	if (!len || *s == '\0')
+		return d - str;
+
+	while (len && *s != '\0') {
+		if (*s == '%' && len > 2) {
+			/* Try to convert % escape */
+			d1 = tohex(s[1]), d2 = tohex(s[2]);
+
+			/* Look good, consume three chars */
+			if (d1 >= 0 && d2 >= 0) {
+				s += 3;
+				len -= 3;
+				*d++ = (d1 << 4) | d2;
+				continue;
+			}
+			/* Otherwise, treat '%' as normal char */
+		}
+		*d++ = *s++;
+		--len;
+	}
+	return d - str;
+}
+
 int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 			      struct erofs_pax_header *eh, u32 size)
 {
@@ -454,7 +495,7 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 		goto out;
 
 	while (p < buf + size) {
-		char *kv, *value;
+		char *kv, *key, *value;
 		int len, n;
 		/* extended records are of the format: "LEN NAME=VALUE\n" */
 		ret = sscanf(p, "%d %n", &len, &n);
@@ -537,8 +578,7 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 				eh->use_gid = true;
 			} else if (!strncmp(kv, "SCHILY.xattr.",
 				   sizeof("SCHILY.xattr.") - 1)) {
-				char *key = kv + sizeof("SCHILY.xattr.") - 1;
-
+				key = kv + sizeof("SCHILY.xattr.") - 1;
 				--len; /* p[-1] == '\0' */
 				ret = tarerofs_insert_xattr(&eh->xattrs, key,
 						value - key - 1,
@@ -547,9 +587,10 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 					goto out;
 			} else if (!strncmp(kv, "LIBARCHIVE.xattr.",
 				   sizeof("LIBARCHIVE.xattr.") - 1)) {
-				char *key;
-				key = kv + sizeof("LIBARCHIVE.xattr.") - 1;
+				int namelen;
 
+				key = kv + sizeof("LIBARCHIVE.xattr.") - 1;
+				namelen = url_decode(key, value - key - 1);
 				--len; /* p[-1] == '\0' */
 				ret = base64_decode(value, len - (value - kv),
 						    (u8 *)value);
@@ -558,9 +599,13 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 					goto out;
 				}
 
+				if (namelen != value - key - 1) {
+					key[namelen] = '=';
+					memmove(key + namelen + 1, value, ret);
+					value = key + namelen + 1;
+				}
 				ret = tarerofs_insert_xattr(&eh->xattrs, key,
-						value - key - 1,
-						value - key + ret, false);
+						namelen, namelen + 1 + ret, false);
 				if (ret)
 					goto out;
 			} else {
-- 
2.39.3 (Apple Git-146)

