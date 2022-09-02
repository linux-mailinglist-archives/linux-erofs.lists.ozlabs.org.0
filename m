Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 858AB5AA68C
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 05:48:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJkQx35YSz30DP
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 13:48:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3ABmY31N;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3ABmY31N;
	dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJkQs6bdBz30Bl
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 13:48:21 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id x80so929656pgx.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Sep 2022 20:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=3ABmY31NCtPUK9+d/tEAiUK1Sw5n0PbCBRGKhZIiWLQozhGHRFk5d1ZbZAv7HW0e94
         qj6LLPcP0RLVr3Lxe2Vg3yZyHRrsKEumnCGkXHpdDdgPZFb6O3BPlwrXgOWJwDitJ3H4
         PQ6EeKpWHEU8O3M50XZCT8yBKE9rzr2h/bzIoZW44Spga5UTqeCH2eMZcHTL3f6WhH4Q
         mAZKmwn6WtZgc3ftU8Dwlhpx9+72E4iXoZUd4QbrY4iXMJQJlAhyCOUkO8JMUYPQHqTJ
         eiOD3DVVkMWK3tI0AJ0q+sTjCRH/RM5yPgsZ0XlZiYoAyJNVLyd4Mb0QRmopGcau6G5F
         JJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=5zbG6Pj/eHazv9b5ghwK/3i/Zjf887YyyHMYR/4P/1CAs2gtqKvKb3Y74q84UCDuu1
         5mYE81qnwmQyLr0MLtP6tyUenn3sLOC9jV4MwUpAnT/cYI5wLKsQA5pKP/fJrH8NlK8M
         ejvgtC+JAF0XX14gxdvYm4UqVvt6rt3BBeK51DNZbFJi+yBGuyrqzhiLtkun7xDBSj38
         /aZ+PIrTcwJWhoXh+UNMXKwyuDWbZiaj5pEHy/3VSUEUCt+Dsv443K3EwOpM339scOYj
         DX0fkL7gX+ezqtRUtJ/nRZpNpSeWBIzdLkEwnjT3CizYhUYkxsKS6MLW6ZFGEOaWFJNH
         Denw==
X-Gm-Message-State: ACgBeo0fXGO1GFi5hK6Nw8pkPFEiHhe1zLUK1bVzi6wK5eFWAN+gX/wZ
	nSJUvORVl/7TyoM80zl3LguBHCgcW6u9tQ==
X-Google-Smtp-Source: AA6agR6H1cxQnoOXHM2ER5sKinUb9hmkg3InKS5W80qghzWeHrK3nt3kYIKXJVHuFnBwjRiKLdGdzg==
X-Received: by 2002:a65:620c:0:b0:431:25fe:277 with SMTP id d12-20020a65620c000000b0043125fe0277mr15252pgv.413.1662090499304;
        Thu, 01 Sep 2022 20:48:19 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0016c4546fbf9sm376152plg.128.2022.09.01.20.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:48:19 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V1 3/5] erofs: add 'domain_id' prefix when register sysfs
Date: Fri,  2 Sep 2022 11:47:46 +0800
Message-Id: <20220902034748.60868-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902034748.60868-1-zhujia.zj@bytedance.com>
References: <20220902034748.60868-1-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-fsdevel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In shared domain mount procedure, add 'domain_id' prefix to register
sysfs entry. Thus we could distinguish mounts that don't use shared
domain.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/sysfs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index c1383e508bbe..c0031d7bd817 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -201,12 +201,21 @@ static struct kobject erofs_feat = {
 int erofs_register_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	char *name = NULL;
 	int err;
 
+	if (erofs_is_fscache_mode(sb)) {
+		name = kasprintf(GFP_KERNEL, "%s%s%s", sbi->opt.domain_id ?
+				sbi->opt.domain_id : "", sbi->opt.domain_id ? "," : "",
+				sbi->opt.fsid);
+		if (!name)
+			return -ENOMEM;
+	}
 	sbi->s_kobj.kset = &erofs_root;
 	init_completion(&sbi->s_kobj_unregister);
 	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
-			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
+			name ? name : sb->s_id);
+	kfree(name);
 	if (err)
 		goto put_sb_kobj;
 	return 0;
-- 
2.20.1

