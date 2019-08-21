Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3496E27
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 02:19:16 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CpDx3VZMzDrFL
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 10:19:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=caitlynannefinn@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MH13mfy/"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CpDd2cqVzDqCW
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 10:18:54 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id i18so228611pgl.11
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2019 17:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=c3LQHcY3+YvhpAJ3SOOoCNwpGf42ZIdm9oft5Rg6R8E=;
 b=MH13mfy/rC2MWrFrghbk3ERrfOJ7Acc2V5PTmjiUJ2UNkoWSzaaCcQ+L1XS6wjV1NZ
 fnz/Qw3+jI0mJo5ZTwDo2D43ey6zMwlKjjFfvwWh95XuqfRYmFrLLfMos7MItV2S8S4r
 znUOap6+GdVm2fAzNACWW30Jy8d/tsw+kmVMyv6/B25kbodcxkaJo2wRykahpVFG8GUV
 dgOV2Ww4hpl5Ll8M+MI+YDNaYItpk3EPoFrpBOsm7F/Rsj+1E8WEStN6Mu2h0GQ82wrl
 9VzRMbOjLagbaCiurxsYGBiJDRP4OQ9MOCrslguAFBz+LQ5B8KmQZW2F1xZJapyuE3iy
 MMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=c3LQHcY3+YvhpAJ3SOOoCNwpGf42ZIdm9oft5Rg6R8E=;
 b=L7FGn378CddJvzgekfaTMjrM/tjtlKbkxY3l6GFbloL8yXYevbs8/GfgiTawg1+ezN
 GZbQwSKUWYiE8ARHOK4zHVXA2SSQDAuwMCqY3mFu0IQIl4w3ZAZSu6QU+TNx6B9mvZ/c
 dTV5FIi6TVKKL2an2HFDzC4VkWalN1bE8D3yxwH/aLxV8G2Lq8Cirr4fJeZPNLjKIXdc
 XiJTRTvn8FBHfeM5erdXzsAgiDiZ0ZPkHnCnxTilTFVvTEz4QCNE9D91xVaHaHTSguUI
 u7Aq2bv1Qy5TblBzcZJO0j6glcv3HptpC0tQu4R6XKGdAyUTiv6niReknbjgKNYmbc2R
 EzGw==
X-Gm-Message-State: APjAAAXW7Ps43dtGRwjvvhOEemP7oJ9wWhvelpl9lrZcEdo2iKP0iTOg
 39JMAfy94dVYWbzPdyj8KsE=
X-Google-Smtp-Source: APXvYqwwan2OY/ZV7PXfeMhMGdEvRd4vEiJuNjIlg98ZfD/In7j14ai4ajqEPw9W14GV2GUgiaRNmg==
X-Received: by 2002:a17:90a:9202:: with SMTP id
 m2mr2663705pjo.16.1566346730545; 
 Tue, 20 Aug 2019 17:18:50 -0700 (PDT)
Received: from localhost.localdomain (wsip-184-188-36-2.sd.sd.cox.net.
 [184.188.36.2])
 by smtp.googlemail.com with ESMTPSA id g2sm18806323pfm.32.2019.08.20.17.18.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 20 Aug 2019 17:18:50 -0700 (PDT)
From: Caitlyn <caitlynannefinn@gmail.com>
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] staging/erofs/xattr.h: Fixed misaligned function
 arguments.
Date: Tue, 20 Aug 2019 20:18:19 -0400
Message-Id: <1566346700-28536-2-git-send-email-caitlynannefinn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
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
Cc: devel@driverdev.osuosl.org, "Tobin C . Harding" <me@tobin.cc>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Caitlyn <caitlynannefinn@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Indented some function arguments to fix checkpath warnings.

Signed-off-by: Caitlyn <caitlynannefinn@gmail.com>
---
 drivers/staging/erofs/xattr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
index 35ba5ac..d86f5cd 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/drivers/staging/erofs/xattr.h
@@ -74,14 +74,14 @@ int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
 ssize_t erofs_listxattr(struct dentry *, char *, size_t);
 #else
 static int __maybe_unused erofs_getxattr(struct inode *inode, int index,
-	const char *name,
-	void *buffer, size_t buffer_size)
+					 const char *name, void *buffer,
+					 size_t buffer_size)
 {
 	return -ENOTSUPP;
 }
 
 static ssize_t __maybe_unused erofs_listxattr(struct dentry *dentry,
-	char *buffer, size_t buffer_size)
+					      char *buffer, size_t buffer_size)
 {
 	return -ENOTSUPP;
 }
-- 
2.7.4

