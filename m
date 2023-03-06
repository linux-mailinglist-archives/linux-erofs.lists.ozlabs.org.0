Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67756AB8E0
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 09:55:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVXTy4kp5z3cLr
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 19:55:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZFdpI7Eh;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZFdpI7Eh;
	dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVXTl6GHrz3c6R
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 19:55:23 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so7111933pjb.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 06 Mar 2023 00:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678092921;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVn9cH5VyUuoVkqURZFnblD07dc8FnaUKEqFLNWRsAM=;
        b=ZFdpI7Eh14Rlc6LJGmx+yRDUs1lv3ms9XMLd7qq0oeY3iTIv3lxMnmeijbQsGGRuHB
         SzJ0ZDrZ70xV7bwOKrsRT9XUqFPkAIBlgvZZqWBypF9JU3lmrflGjnzaiEXoZt8f44Yn
         q2y63Lm8xFZq5oIEy5U0mbVIajeBcxPNRhFHzNueG79SiwrGMWlJpqdlnYqNA0IJ1fKg
         RgofHWkjAYfhbkt2FNjClHVM6wu2vTlKu/pIk+CAQ3BZmOpJwax9baRkSemU7jk0mIdH
         VIeqTH1YVpsbl7Ov2FlJWdUX278a7ar/Jx3hW25XP+v0pPBKSjGTLgGWbbkQ6DG2wf7T
         GFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678092921;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVn9cH5VyUuoVkqURZFnblD07dc8FnaUKEqFLNWRsAM=;
        b=kC+0CEo2DOX2mhnXyvtx+pdlnJRM/uSkRDZTUAmWWUDlrEdlmuf9yuEERVsgpYMGVS
         H1GvGJgKJW0oqDoKcO65qcjeVgm7UfRVtKCdAB8e8kUdoLo81RS9b6V4uroyMH3TGxVG
         WvmK2kkL7sSjDwmjWhZlpmiMhSr/q/bSZJODZzb5dmjNNW1OKV05HHlBNV+u48jQmnXu
         mIY79oiTjhzZdW6g9rnFNqF5RqRKYOymxU+Rmqp8P+TViWQ7bzuMeH9VTYu8xLKntLFV
         E5CDUy4iK/IDPcLcqn6liIBIKkRiCiJyRePG+qxBRDG4APJ0zIT7+nrBeTjy2gtBXji8
         6Q3Q==
X-Gm-Message-State: AO0yUKXdqLYzoGBICEF2oVifADnnszhPlbetMaZ4GvcAEXusJVFw5cO9
	WD5+MuCTFp6MRMUqaMPs/TGQa4Qasyc=
X-Google-Smtp-Source: AK7set8le3LEFy3e+N3K1mDJsjwI/8y8STo63B6eFm3K/90wi542wiMKmUAClyBgP0n5b/E63djxeA==
X-Received: by 2002:a17:90b:1d88:b0:237:c52f:a54d with SMTP id pf8-20020a17090b1d8800b00237c52fa54dmr14329047pjb.21.1678092921150;
        Mon, 06 Mar 2023 00:55:21 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a4e4a00b002371e2ac56csm5315013pjl.32.2023.03.06.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:55:20 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: get rid of erofs_iget_by_nid()
Date: Mon,  6 Mar 2023 16:54:59 +0800
Message-Id: <b002a8bf98b9b9a69c94faccd5e672aabfc5bffb.1678092797.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e90f4dc828bb45b1a3ccbd1769a590410f3a82da.1678092797.git.huyue2@coolpad.com>
References: <e90f4dc828bb45b1a3ccbd1769a590410f3a82da.1678092797.git.huyue2@coolpad.com>
In-Reply-To: <e90f4dc828bb45b1a3ccbd1769a590410f3a82da.1678092797.git.huyue2@coolpad.com>
References: <e90f4dc828bb45b1a3ccbd1769a590410f3a82da.1678092797.git.huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

No users for this helper.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/inode.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index bcb0986..b508c73 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -94,18 +94,6 @@ struct erofs_inode *erofs_iget(dev_t dev, ino_t ino)
 	return NULL;
 }
 
-struct erofs_inode *erofs_iget_by_nid(erofs_nid_t nid)
-{
-	struct list_head *head =
-		&inode_hashtable[nid % NR_INODE_HASHTABLE];
-	struct erofs_inode *inode;
-
-	list_for_each_entry(inode, head, i_hash)
-		if (inode->nid == nid)
-			return erofs_igrab(inode);
-	return NULL;
-}
-
 unsigned int erofs_iput(struct erofs_inode *inode)
 {
 	struct erofs_dentry *d, *t;
-- 
2.17.1

