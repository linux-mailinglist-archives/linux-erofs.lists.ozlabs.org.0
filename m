Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2144DF80
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 06:08:39 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45VQCk3F9czDqcl
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 14:08:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qVkq3zNd"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VQCd4TpqzDqRx
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2019 14:08:28 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id e5so2311364pls.13
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2019 21:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=yxJMq8nyXU/zoL219lXLyqvfOfYap6nbgESKvdujGUc=;
 b=qVkq3zNd5hBP13B3SdWx3rUknEb99xRpn9AMfEwpSwY1YK0vW7VjSdv26/0JqG7d0+
 Z1XlxxYrK3SBzVBF4ica2uczn1e0tcGLquouDH0P6NT2E7XEKuunDQnGVGDp9849CWpf
 l2Dht9AmGan6CTgDrVTZAPYZ6XC2JSdRefRjAf8aGec6whC1NQaUwSSM4hrzfgrVqyLi
 BAimZS21qnBLWXKZSyFpFSr3ghsTE7W1ZO6gvZWfsYM+6ubhi66eVbJ+MzJs0Yf2sVcj
 psPhQFfmmiTuuPY4r4RfzOufmbCak5BcO8KJzWBtjiHPWh5GTmFxquRVe7oFhcmUO989
 TuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yxJMq8nyXU/zoL219lXLyqvfOfYap6nbgESKvdujGUc=;
 b=tR5iYVe1Ouq284FnBtm+ugebO9oa8AO9jZxV/QizCniURtCgdE+qShqzVJXbz95nCS
 47HlEyUxSP0P+7HuPS/i1zZV6f2jPZaft1bS+F9mzPMyCdWp0YhD2m9hIrs+3rpz5abb
 feTucJzfTY6uGoueQjH0EA15ca5OgWRqaV5PIjL5styBcKFdIoBt27JLfPWO72kSntzy
 At58boDnpV/RrM5CTNGI4bLNpdHrkCqTIj5ax2jcr4+jYoGVMeG7e0lhSsvGCPm7GUYR
 VOYrgrqSbmVChezl3TPQ+LRga70E11XBceHP8qPnPaoJfMk2GXStYejnM0Pf3TIG/YQ0
 qJ3g==
X-Gm-Message-State: APjAAAUFX33KK8++DLkEsmlPwvUIkofng4z4lOpzKrfXTRpOsFh/Ntbb
 czwDHsuQzVYaecMpYGpiTQk=
X-Google-Smtp-Source: APXvYqzF9J1LgtDUsgvypYQEzLcToGMElrhFovvNdgsxr13rNJGz8yEpHOyhT4d0pPd4Uv16PyXN4w==
X-Received: by 2002:a17:902:720a:: with SMTP id
 ba10mr18925630plb.329.1561090105770; 
 Thu, 20 Jun 2019 21:08:25 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id 25sm1002946pfp.76.2019.06.20.21.08.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 21:08:24 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: gaoxiang25@huawei.com,
	yuchao0@huawei.com,
	gregkh@linuxfoundation.org
Subject: [PATCH] staging: erofs: remove needless dummy functions of erofs_{get,
 list}xattr
Date: Fri, 21 Jun 2019 12:08:08 +0800
Message-Id: <20190621040808.3708-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

The two dummy functions of erofs_getxattr()/erofs_listxattr() will never
be used if disable CONFIG_EROFS_FS_XATTR.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/staging/erofs/xattr.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
index 35ba5ac..2c1e46f 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/drivers/staging/erofs/xattr.h
@@ -72,19 +72,6 @@ static inline const struct xattr_handler *erofs_xattr_handler(unsigned index)
 
 int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
 ssize_t erofs_listxattr(struct dentry *, char *, size_t);
-#else
-static int __maybe_unused erofs_getxattr(struct inode *inode, int index,
-	const char *name,
-	void *buffer, size_t buffer_size)
-{
-	return -ENOTSUPP;
-}
-
-static ssize_t __maybe_unused erofs_listxattr(struct dentry *dentry,
-	char *buffer, size_t buffer_size)
-{
-	return -ENOTSUPP;
-}
 #endif
 
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-- 
1.9.1

