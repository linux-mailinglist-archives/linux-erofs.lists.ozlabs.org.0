Return-Path: <linux-erofs+bounces-1281-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2412BFEE47
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Oct 2025 04:10:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csTyd3TJjz306d;
	Thu, 23 Oct 2025 13:10:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761185433;
	cv=none; b=J1gucgWBrDfEPZ/A+5/mn7qwfJUJgzugWiqZAGr1htN0JRIwf1tf7eDF819PUCAxONr/pSBwnM8PF7yoGpGv0N2B+ySIxFIF0jn4tQOVRNVzuj08KSavj9L6yv1A69w3F0tsJw1pWY5bjY6ER1J6fJBHjhBjIOYqaumxUnKiHidZKlkDgeL53LyLoBHeqTibGEenNZWrSJGMAejpDs1/+4K9SMeQ6EaEQ6Egx0NMbbXYctIYqEukBxggXTpo7dStNqQiVxxLEADSkfzIR9d90kzTuT73p2ZSrpgG0RpQK4m6FSCgSeXCzX6WD2pKON9TXGJ7atNhdPlUQGaqY3JvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761185433; c=relaxed/relaxed;
	bh=D2NN9eTjgkMjmPkamCpI+ny7xeOxtq+fIBTmpSq86hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCCQCXMGqxfeCrIvwudmsv3gaLG14WEhiCK2hqjb0EgUlm7TL6/kY5zkLzS4diiT4Eu1lHF22hH1xjQi1G1fDh/I9hoCn8slSfl0s/UU0W5P6Gaz69BRjM2vrzrpWBSW2homWRIWGHJYJTYTlY8zNxJ166ldOiyLh+2YjvvDRNLPPJzKGAUhkjFl+lM7AnHLbPentG3fMXS0K1rgEFuB+EXwN3TOVzhiTt6JpdL4Yp+5zSYwpVha/E9EFZ2yQF9EnPr9xkyHaWLk50pI7XeaFd05/Y+8iZu2XujpmuAvjTUPcO24eqO81kV9vepNJaMc5Z32+YC0Wra9oiVmMw4PYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lf8iWBOf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lf8iWBOf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csTyb6SGBz304l
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Oct 2025 13:10:30 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761185426; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=D2NN9eTjgkMjmPkamCpI+ny7xeOxtq+fIBTmpSq86hQ=;
	b=lf8iWBOfr4SvooYQ6sa7OVjP0Gy2zh56mPUQc/YnTLC6IjkgJgSjqYMNuDVNkxxLus4YYaj7MZk7Z/katAOEDbtWhWg92eMdHYA8H+T/WGdIP+Nhvw79nUsL6Do24obx1+Neg0yqroBFm9tHty6VJeab7yAb4dCI7XuNTsaSuWw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqolAVc_1761185420 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 10:10:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH] erofs-utils: lib: fix build warning in ocierofs_encode_userpass()
Date: Thu, 23 Oct 2025 10:10:19 +0800
Message-ID: <20251023021019.958301-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

remotes/oci.c: In function 'ocierofs_encode_userpass':
remotes/oci.c:1567:20: warning: array subscript [-2147483648, -1] is outside array bounds of 'char[2147483648]' [-Warray-bounds]
 1567 |                 out[ret] = '\0';
      |                 ~~~^~~~~
remotes/oci.c:1560:15: note: at offset [-2147483648, -1] into object of size [0, 2147483648] allocated by 'malloc'
 1560 |         out = malloc(outlen + 1);
      |               ^~~~~~~~~~~~~~~~~~
remotes/oci.c:1567:20: warning: pointer 'out' used after 'free' [-Wuse-after-free]
 1567 |                 out[ret] = '\0';
      |                    ^
remotes/oci.c:1566:25: note: call to 'free' here
 1566 |                         free(out);
      |                         ^~~~~~~~~

Cc: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/remotes/oci.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 25f991d..38b3f01 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -1549,24 +1549,26 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
 
 char *ocierofs_encode_userpass(const char *username, const char *password)
 {
-	char *buf, *out;
-	int ret;
+	char *userpw, *out;
 	size_t outlen;
+	int ret;
 
-	ret = asprintf(&buf, "%s:%s", username ?: "", password ?: "");
-	if (ret == -1)
+	ret = asprintf(&userpw, "%s:%s", username ?: "", password ?: "");
+	if (ret < 0)
 		return ERR_PTR(-ENOMEM);
+
 	outlen = 4 * DIV_ROUND_UP(ret, 3);
 	out = malloc(outlen + 1);
 	if (!out) {
 		ret = -ENOMEM;
 	} else {
-		ret = erofs_base64_encode((unsigned char *)buf, ret, out);
+		ret = erofs_base64_encode((u8 *)userpw, ret, out);
 		if (ret < 0)
 			free(out);
-		out[ret] = '\0';
+		else
+			out[ret] = '\0';
 	}
-	free(buf);
+	free(userpw);
 	return ret < 0 ? ERR_PTR(ret) : out;
 }
 
-- 
2.39.5


