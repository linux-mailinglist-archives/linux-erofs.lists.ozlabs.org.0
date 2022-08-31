Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D97885A7D5F
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Aug 2022 14:32:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MHk8L61sgz3c1S
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Aug 2022 22:32:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=a69A5kXx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=a69A5kXx;
	dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MHk8G5ts8z3c2s
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Aug 2022 22:32:14 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id mj6so8944805pjb.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 31 Aug 2022 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=a69A5kXxCghZWvwb8YYV75Ozfttgowwd2GDPhnjFzjz+qEazPSR4vukwVjDh7QBPgG
         DsLfR21QtnFhVcOQEysq6Jco6goRw3OWeI6cA9DjxyCyRfdB2zDiWvyPyUcdLZ9EqD5M
         BvK5D6hByMcgaMRQh8s+I8VAX7SBzNISEkj7LjHvVxqShxdTkSOliOrFpfd66IHbD2IR
         j7w1+shnZDMc09iyr44+fiP6fribUX1dqpgfXPeZ1gkiFj2SsRf6i5ZcrElH/Ghz+Ehs
         v9WVDFy4uzKb1PAENyZNriVppdLqadwA31b+PFWbJtON6+TGleh3Evc+QEJhagIG1OpF
         X5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=iyN8QHQt5M+cIgzIMYL0sxiWyZCr+FOeQ/fA6DfTzYAVeEVN5WB4SsrZyHtr49dEKS
         veesNzrzAai+cht+Xb6NshVFlLBW9nvoNjDqcW8zTfaA/OT8gmakppE2MS0Iiq3XbXYR
         q2XXBXJNh20udn++BZbtmqBUTN+uqmGqD4+IjLQVzed/3Y2EjJLTAcXEVFUsmD5SErUW
         mxFRU8DMax6y6ruimVSUCWXj+7ZR02GiVZQ42ZBhE2k/RB/WVFYMFrCOSFGNNRGKlBXj
         CbqC2mBcHgaO9IPIIPb48t+/gHdh8b6H/gqZX/bGlEEF772qTNVPancRIJlta5Z9wPHm
         4yzQ==
X-Gm-Message-State: ACgBeo0Xj5Gl0irpWxjvtP/LXMKCgJxHlN9IqX7Sk3pXJ/U2IZZrp3Fz
	Go3xKglZa/aCU8n6jrtyEd2ozPFTHApxmw==
X-Google-Smtp-Source: AA6agR5OOzG/6F5Jtqz0Vb/Nb6BOsK8fByctobqC4HoDomtr9xupaeVXSDCFYbQS7FmbcNB0s5JZWw==
X-Received: by 2002:a17:90b:35c3:b0:1fe:10c4:cfb7 with SMTP id nb3-20020a17090b35c300b001fe10c4cfb7mr3056865pjb.60.1661949132226;
        Wed, 31 Aug 2022 05:32:12 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0016efad0a63csm11769896plf.100.2022.08.31.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:32:11 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH 3/5] erofs: add 'domain_id' prefix when register sysfs
Date: Wed, 31 Aug 2022 20:31:23 +0800
Message-Id: <20220831123125.68693-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220831123125.68693-1-zhujia.zj@bytedance.com>
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
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

