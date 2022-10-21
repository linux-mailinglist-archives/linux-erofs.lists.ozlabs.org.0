Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0876072F5
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 10:54:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mtyv31jJyz3drS
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 19:54:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mE/t/bt4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mE/t/bt4;
	dkim-atps=neutral
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mtyty6d52z2xH6
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 19:54:02 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d10so1988590pfh.6
        for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiebFKtnsrtXianXD3JL4DWupXndbhs034Yj5s+RxrE=;
        b=mE/t/bt4w+oJh8KFnimQ8O2wcibAG6Lq3MlVWFEZkbXium8WqHvJK8sRDFWRd2L56i
         Vww8d7O6Y+mXOTNtkt5RsIINWwXUrmRcqWwtFr+9RtjrLh7MVAqU6AsUt42/xnn8P8P2
         Z2eem93rUGdCRpOZ924FyFlwYXcNzfPJOiaOWxIsB3Q1PMcUvL/WVcVAjHceHCQR+e49
         b8/dOE3JfEktAlN6cTb8MVewHWDPk7XAIbRhsxoFnMJcb+4EESvvy/tjxQ94eJGxVfNs
         yT6C0fKFi57J9cjZl5Kv2BAwMxF3KEJqdIqD15JSWZmIy+iDgR3d/FT2k0AqofMHi//0
         +T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiebFKtnsrtXianXD3JL4DWupXndbhs034Yj5s+RxrE=;
        b=dhG/wofDWtOex5bgrZLgj/XI0WESfYi/GEeU+xsLfYjwtpAxgGhQdKKEbZuiR5lncK
         gh65/7XnlUD2bNrKykvB1XMDa+D3sqITBG2rN6pYJ2RdIgETKPYbSn3DTtO/iaeZh69M
         ELChAWd+kjC1iOSwJ+rP16SafgfHOCVaD8oAzNBwZuX3ddrapcnrFsv9yQWyhl8EH+Cm
         E3b7LnYhHZUkHT/tcoVowymEP0Iv7IPZh4TPwe5k1RjfXBcbKq6/oxNaG1wCVl6k66pj
         x/TxEIf3Zsd2tKnzsL8mijofjVkp8F1a2j/uV7LnXIKOVZNV3Rz8yEIIL/eep8QoHNdC
         uHkA==
X-Gm-Message-State: ACrzQf3LCbFKeBFeoCm9PV5+6jeCHdfzgl84E/eHW/oulFB6m+VFPgpj
	IvLG+vc/VkvOuUur7HbN2E4=
X-Google-Smtp-Source: AMsMyM7PkyURCraVtdQN1vKJbNHZyc1INbLu985EFIkNQGDGKtTVTHPeVmw+aT7qtdfly+b0bTaxwA==
X-Received: by 2002:a63:1c47:0:b0:44c:2476:12ff with SMTP id c7-20020a631c47000000b0044c247612ffmr15899522pgm.50.1666342439140;
        Fri, 21 Oct 2022 01:53:59 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id o16-20020a634e50000000b0046ae5cfc3d5sm12658609pgl.61.2022.10.21.01.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:53:58 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v2] erofs: fix general protection fault when reading fragment
Date: Fri, 21 Oct 2022 16:53:25 +0800
Message-Id: <20221021085325.25788-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

As syzbot reported [1], the fragment feature sb flag is not set, so
packed_inode != NULL needs to be checked in z_erofs_read_fragment().

[1] https://lore.kernel.org/all/0000000000002e7a8905eb841ddd@google.com/

Reported-by: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com
Fixes: 08a0c9ef3e7e ("erofs: support on-disk compressed fragments data")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2: fix return value to -EFSCURRUPTED (Xiang)

 fs/erofs/zdata.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cce56dde135c..55c13cd6934b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -659,6 +659,9 @@ static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
 	u8 *src, *dst;
 	unsigned int i, cnt;
 
+	if (!packed_inode)
+		return -EFSCORRUPTED;
+
 	pos += EROFS_I(inode)->z_fragmentoff;
 	for (i = 0; i < len; i += cnt) {
 		cnt = min_t(unsigned int, len - i,
-- 
2.17.1

