Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1B96E8E0B
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Apr 2023 11:28:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q2C4j090mz3f6s
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Apr 2023 19:28:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=b5DUlyei;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=o451686892@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=b5DUlyei;
	dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q2C4d4jXTz3cdy
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Apr 2023 19:28:00 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b73203e0aso5503040b3a.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 20 Apr 2023 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681982878; x=1684574878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYHx4JsUWQhWjYuqwXWR+ZooH1obN72TBF62XXnSNsU=;
        b=b5DUlyeiLdnaAe3SMhxJMr66IxaPEAEZ1YRZk/ed7pHz3ehCdSuPgKDnLEggQwJ+0D
         HEtR6cUFygGgXHyo1tc9IDOPyxK1UmktWwR04My8JVDFDsGAQkBP5Z9jswr8v+PKeFTA
         7iwY4UwCSdaSq3bCaTZOruSdm7uRM+HsPQsfVk+DcbuJ99hKJmgJJh/2k2loiuS123aJ
         xN5jCxess0Sa2AwYJIJTiWHTf4qO917uUhQcOVbuQcZS9Jdf5bZR67hJ5GPxhnIgtV8c
         F0tLd+JipWFjP/Ky4nMs/i18f3zoUq45cepuYRyKkDFOdQYM+NeOdG1+1Zqc9jLKWwf6
         MDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681982878; x=1684574878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYHx4JsUWQhWjYuqwXWR+ZooH1obN72TBF62XXnSNsU=;
        b=KAVqphYG59uqx6zZSQYlEsBd+L7LXVCWhFrpNqeouYBK30lLkj+GTYAiQrchaNwpDf
         5S9DrjPpDhKQy7tOax3da5fnSYRsaoHpFUqQ4CtEGF1YpbbOeU5HDdX+BsiWt3F36j47
         0vW+6MWOntNPiY9Km07RBx/kyQas2pnokd4CINrRUT69tS+F3+52aJ9aqED2atFrDZCs
         uWo/r5DgiFmpLlX/TpBqSjXhsHi8LiLRs6U39W27ibJsiK7AwgQg47nbIedRP6nlkjAo
         y0P6LixM+TNSECisphoXBlQoJViazGKw0rA4829bSQw7dI26jPUmTltl2OlNlM6rnBd9
         BE8Q==
X-Gm-Message-State: AAQBX9dIxoPeNeNZuCtfKEyK0iX+6cHWmUqQ1Ojn8hR+gmynmPEEbHwZ
	ex9q5rr3cgSlGb3QJMKn11k=
X-Google-Smtp-Source: AKy350YNvOJi/h5WTSlZhCHAcJEtfOgAcuq3MI7WdER8ZQa/p2t1PN/mUOxEabLxOJd6toKR8HdGqg==
X-Received: by 2002:a05:6a00:3017:b0:63d:32a3:b5f7 with SMTP id ay23-20020a056a00301700b0063d32a3b5f7mr5267623pfb.12.1681982878341;
        Thu, 20 Apr 2023 02:27:58 -0700 (PDT)
Received: from localhost.localdomain ([103.117.248.198])
        by smtp.gmail.com with ESMTPSA id j6-20020a654286000000b004fb8732a2f9sm755856pgp.88.2023.04.20.02.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 02:27:57 -0700 (PDT)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: xattr: skip xattrs with unidentified "system." prefix
Date: Thu, 20 Apr 2023 17:27:39 +0800
Message-Id: <20230420092739.75464-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.25.1
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
Cc: Weizhao Ouyang <o451686892@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Skip xattrs with unidentified "system." prefix to avoid ENODATA error.
Such as building AOSP on NFSv4 servers.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 include/erofs/xattr.h |  6 ++++++
 lib/xattr.c           | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 9efadc5e5e80..de078a5eb08a 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -41,6 +41,12 @@ static inline unsigned int xattrblock_offset(unsigned int xattr_id)
 	(_size - sizeof(struct erofs_xattr_ibody_header)) / \
 	sizeof(struct erofs_xattr_entry) + 1; })
 
+#ifndef XATTR_SYSTEM_PREFIX
+#define XATTR_SYSTEM_PREFIX	"system."
+#endif
+#ifndef XATTR_SYSTEM_PREFIX_LEN
+#define XATTR_SYSTEM_PREFIX_LEN (sizeof(XATTR_SYSTEM_PREFIX) - 1)
+#endif
 #ifndef XATTR_USER_PREFIX
 #define XATTR_USER_PREFIX	"user."
 #endif
diff --git a/lib/xattr.c b/lib/xattr.c
index 6034e7b6b4eb..7c776330bdaa 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -288,6 +288,18 @@ static bool erofs_is_skipped_xattr(const char *key)
 	if (cfg.sehnd && !strcmp(key, XATTR_SECURITY_PREFIX "selinux"))
 		return true;
 #endif
+
+	/* skip xattrs with unidentified "system." prefix */
+	if (!strncmp(key, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN)) {
+		if (!strcmp(key, XATTR_NAME_POSIX_ACL_ACCESS) ||
+		    !strcmp(key, XATTR_NAME_POSIX_ACL_DEFAULT)) {
+			return false;
+		} else {
+			erofs_warn("skip unidentified xattr: %s", key);
+			return true;
+		}
+	}
+
 	return false;
 }
 
-- 
2.25.1

