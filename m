Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C566E75CE
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Apr 2023 10:57:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q1ZS33xfrz3fTq
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Apr 2023 18:57:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=FnOPZkRg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=o451686892@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=FnOPZkRg;
	dkim-atps=neutral
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q1ZRt1D3kz3fSN
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Apr 2023 18:57:29 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so2575338b3a.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 19 Apr 2023 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681894644; x=1684486644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUepY7MEzKwLZ0N5aO68OC2gQrugtPu/NBhwfSVKmMU=;
        b=FnOPZkRgKTy4l9WxP3StSav9iWCN6rP6NGiCk8mcEuEZvo78TWACsYwCsZdAoA71Ya
         cv1j87dMlZS9TdvXUUAwzVMatwOWyoeSlIZ/44wU9IhFAU+5u9XDq2Jd3rxs2/mxjfad
         4Y56E9MvWQNxrc7qmyY9t68jMW8SEs8oOKywMQ1xLCFSd6vLj8IWaS0k+QMcgmz/Gj/X
         jCN8y+faZhs7H1n+9XW9aHLP4xrCkVbi3rB3aCgV58PcECx/DZ5ZJyWNSzX1ryK/5v5R
         9pB6xmKAx2DjZty2MvXaT/Bn54/ERYhv+994fqPApdiw+k43q6QsPlbIHqXek7RWvldC
         FdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681894644; x=1684486644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUepY7MEzKwLZ0N5aO68OC2gQrugtPu/NBhwfSVKmMU=;
        b=kgNce6gQxSPw4L+AOrUEJzlYwNXIw8c9t/gSoyap/mmns8J6nDNazAuVamyHVZh0Hz
         z0zTkO+EJZcTrNju2cGldA9UGEnjHVpYGP4j6x2ibPx2XIWNptgP/QPSMXtrVZMgwdZt
         01vVdBCMdS0l6yEhwwDVYT5/ZAJUCoqaveyZiE5uCqHzLq9tC06+GFQrHwDCer19SYXr
         qKVNvAs2yff3GbWFUZYKQkb3ouhMbA+ovFSUGGHyWjl1007v5QO4Bttx7G6PSite3hX8
         UBkHnlfmGDs29vHsgeuaIzjdYjeZGYuRgWolUTEhV4xqRI5lt2++rXB807REDvpdCFu9
         rpVw==
X-Gm-Message-State: AAQBX9fEgXJobgHvULBTB7ThZj7SznW1ZCcYlHbeNurmA56q72tbH20a
	LSllkI/rxkkaTjMH8w7IhDTyD28FhynDzCig
X-Google-Smtp-Source: AKy350aHtWv/QNfg0amk5dUnuWBlMhAj0uk8RCo7QDzyKzFqk0YPr9ZQtUThtyfqVNAWWzmLkKxvww==
X-Received: by 2002:a17:903:187:b0:1a6:87e3:db50 with SMTP id z7-20020a170903018700b001a687e3db50mr5623669plg.1.1681894644454;
        Wed, 19 Apr 2023 01:57:24 -0700 (PDT)
Received: from localhost.localdomain ([103.117.248.198])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170903279200b001a6d4ffc760sm5596290plb.244.2023.04.19.01.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:57:24 -0700 (PDT)
From: Weizhao Ouyang <o451686892@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: xattr: skip NFSv4 xattrs building
Date: Wed, 19 Apr 2023 16:56:09 +0800
Message-Id: <20230419085609.6601-1-o451686892@gmail.com>
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

Skip NFSv4 xattrs(system.nfs4_acl/dacl/sacl) to avoid ENODATA error when
compiling AOSP on NFSv4 servers.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 lib/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/xattr.c b/lib/xattr.c
index 6034e7b6b4eb..748bf2e13408 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -288,6 +288,9 @@ static bool erofs_is_skipped_xattr(const char *key)
 	if (cfg.sehnd && !strcmp(key, XATTR_SECURITY_PREFIX "selinux"))
 		return true;
 #endif
+	/* skip xattr nfs4_acl/dacl/sacl */
+	if (!strncmp(key, "system.nfs4_", strlen("system.nfs4_")))
+		return true;
 	return false;
 }
 
-- 
2.25.1

