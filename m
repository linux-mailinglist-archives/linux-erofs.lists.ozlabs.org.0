Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D6E57B94
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2019 07:37:39 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Z7vj00BpzDqM0
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2019 15:37:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=shobhitkukreti@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ui/C/1jW"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Z7mk2tqRzDqTP
 for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2019 15:31:28 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id a93so622902pla.7
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2019 22:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=ZuaoxV6GFyHn1z3cUmAY4w/28b2Z9JWZtyy2oaYwZV0=;
 b=Ui/C/1jW2tAyjlERjPxj5KBpk0NUGMy49X0L/pPVQuzjU8BfeZdX2qOctJXWp85hsJ
 Hylc83Duxbi0aKB5IOXRG+M+FnVhCSQPbrKL0C3Yhzb8yqfMTNGmGLiskfvy5Y0sl3sz
 YnAtbQ9+dQD4jHZEKo4PwC1m3DaP3C94LNkrt9YubjZ2MtlyJ3n9pY6EjzsCGDXBfSlK
 sGxfx6eqLldGHHRfghSOZ1ySZISHXqHd1iddKygu3fa6ltg3RLN99SUVQwFojL3Pzcfy
 3gFaBvDH8ielB2PY6xb4dndhoKD7fBe8gyHT++0wZ07+IkEid82x4CW2KhEa8u+O0gpl
 XLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=ZuaoxV6GFyHn1z3cUmAY4w/28b2Z9JWZtyy2oaYwZV0=;
 b=cCQTqb96dpaL1VEw0Kg+WYI8hGpWIVljLAjcGAvXuEdByyvwVIK4wMOyUWax0QGyP9
 XidT/rv9hQWjG2PyGQh6OdGuhdGhxK7/xLAL2IcsBW971Sm+leBzPGkiMmgq9sdRwJtG
 py/PAc+s2l6qn/7DxHH4q+fSkY7s/ySnxDMoQtPvK1ek2RC3/jnKQTDmFA7SA+/+n6gR
 W7osbu3yyjrJFYaWFNhWKqX3T6J4tGz18yylVWJ4BeEirjsn/7VCiL5eK3wcfqiyBKii
 n+SfmrwZhoTSVOLNVbeF4s9RI/hp+vYAkv4ZU9MeUe4EDHlcM/PtqI1fR+BhnT5/kWUG
 6J5A==
X-Gm-Message-State: APjAAAUAf9EArykLG0ennvz0aLzpSy3XhCTWlbm/yy6LDDvkS9ES4aQK
 OqKDC1U25uJsU+MtrB2B2s6raCyaOO8=
X-Google-Smtp-Source: APXvYqxnhXnZFImM5GGWNkxcHT8l3tnYeTBzQSOemzbaM3kER/CO4J4Bh09kDG6hg7HxoylOVFIBLA==
X-Received: by 2002:a17:902:6947:: with SMTP id
 k7mr2406187plt.321.1561613484363; 
 Wed, 26 Jun 2019 22:31:24 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
 by smtp.gmail.com with ESMTPSA id y22sm1145165pfo.39.2019.06.26.22.31.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 22:31:23 -0700 (PDT)
Date: Wed, 26 Jun 2019 22:31:18 -0700
From: Shobhit Kukreti <shobhitkukreti@gmail.com>
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH] staging: erofs: Replace kzalloc(struct ..) with kzalloc(*ptr)
Message-ID: <20190627053115.GA20942@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: shobhitkukreti@gmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Resolve checkpatch warning:
Prefer kzalloc(sizeof(*ptr)...) over kzalloc(sizeof(struct ..)

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/erofs/super.c     | 2 +-
 drivers/staging/erofs/unzip_vle.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index cadbcc1..5449441 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -383,7 +383,7 @@ static int erofs_read_super(struct super_block *sb,
 		goto err;
 	}
 
-	sbi = kzalloc(sizeof(struct erofs_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (unlikely(!sbi)) {
 		err = -ENOMEM;
 		goto err;
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 316382d..f0dab81f 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1263,8 +1263,7 @@ jobqueue_init(struct super_block *sb,
 		goto out;
 	}
 
-	iosb = kvzalloc(sizeof(struct z_erofs_vle_unzip_io_sb),
-			GFP_KERNEL | __GFP_NOFAIL);
+	iosb = kvzalloc(sizeof(*iosb), GFP_KERNEL | __GFP_NOFAIL);
 	DBG_BUGON(!iosb);
 
 	/* initialize fields in the allocated descriptor */
-- 
2.7.4

