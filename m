Return-Path: <linux-erofs+bounces-497-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E9AEB023
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Jun 2025 09:33:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bT6jq660nz3069;
	Fri, 27 Jun 2025 17:33:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751009615;
	cv=none; b=CQM5JzdfQpCJsVvb47jnYVcxdBHXApc2k+0HvbN0ybrJMLlIE7Ef1QawPbgByuBxs92qyV0REBT4FQ45XhQCWk2RxutNtdza2jYYD6oHPGhLJGIDHRrBDho6JJL8Q5QDyoPCaGiwAUoAJlFwDPnrdvFHNrPDuh0ixvMg8kDdv9parEO+y0VV8WkQxww85cYYCOyha9nI+HQGo71rKoALekVYaNJwg54gvmzaFFuO/POnZsObkE/tfCNMHau0eb7JfJO6rJeTgTwF2aTbIj06OeIMiirxd9aFSS6ro1ox2YBeWw275YKrfGFtXmTP1huQWeMLZNXX+q1a6V3Udo7Y0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751009615; c=relaxed/relaxed;
	bh=t97HhkoAcWsfQDAiEgh0n/2ynbBPbBjIHI/TBpN94cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Upg2uGZmh3n27/OcdCKqkAFxhZ/oB3O55TwB58Jtm9pFIMXPZh9qEFRZNXj4AvdKz3rs8P5NJyTbRw1ivAn0c2klk2WLwXs5DEYpTRAeTelHg4kmnwS6dgYOFkS6sj1Aa+nQ6AyQiyfHxETC5hM8bXfixlaeFeVW46Vxrn9AK0l11ioGbauz9nfU2MF0MlgGx6tSVaTXBsbHBRRM8rTqiYV7nWrI1zPmVXO49LjixssO7ChW167y25tcNXVjojn5aE8++b1ceGT+cG4jNUk3QpwiFXmrj2XFYu67SQ9XiBFMHcTOUL1Vu1uC9dpati9bzkbxJV02diyVQUSj/TPxyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qF5IAbt7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qF5IAbt7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bT6jn68SCz2xsW
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Jun 2025 17:33:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751009605; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=t97HhkoAcWsfQDAiEgh0n/2ynbBPbBjIHI/TBpN94cU=;
	b=qF5IAbt7S69tKI591HxIlRjFrguZJHpw+fPrG+3BR/N8aJf9JsuwTK2aIuj8jJIt0fPurxogv8d0Z0ejsvaAS9kIbPvt5hQTIu1dPAcQTBVleybwk8qBSmZWHwcZf3DX9y6bR5rIYyr7pWK5OkHh7u/szeTaaJWQ4QgjQiYkH8Q=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WfQ3hqj_1751009600 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Jun 2025 15:33:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: fix missing getrandom() on some macOS platforms
Date: Fri, 27 Jun 2025 15:33:19 +0800
Message-ID: <20250627073319.1833442-1-hsiangkao@linux.alibaba.com>
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

It has <sys/random.h> but not getrandom().

Fixes: 5de439566bc5 ("erofs-utils: Provide identical functionality without libuuid")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac | 1 +
 lib/uuid.c   | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5c2737c8..2d42b1f2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -266,6 +266,7 @@ AC_CHECK_FUNCS(m4_flatten([
 	backtrace
 	copy_file_range
 	fallocate
+	getrandom
 	getrlimit
 	gettimeofday
 	lgetxattr
diff --git a/lib/uuid.c b/lib/uuid.c
index 3fb88a3c..1fae857f 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -41,9 +41,9 @@ static int s_getrandom(void *out, unsigned size, bool insecure)
 		ssize_t r;
 		int err;
 
-#ifdef HAVE_SYS_RANDOM_H
+#if defined(HAVE_SYS_RANDOM_H) && defined(HAVE_GETRANDOM)
 		r = getrandom(out, size, flags);
-#elif defined(__NR_getrandom)
+#elif defined(__linux__) && defined(__NR_getrandom)
 		r = (ssize_t)syscall(__NR_getrandom, out, size, flags);
 #else
 		r = -1;
-- 
2.43.5


