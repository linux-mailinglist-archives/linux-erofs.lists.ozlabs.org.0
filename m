Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E8A6A922D
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 09:08:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSgZl675gz3cdb
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 19:08:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=hI9qMn4T;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=hI9qMn4T;
	dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSgZg6qlxz3cJK
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 19:08:09 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id fa28so1016410pfb.12
        for <linux-erofs@lists.ozlabs.org>; Fri, 03 Mar 2023 00:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677830887;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoRqpQibDwb9oUpvtysPchQslDsCFyIvCUT4fTR3zSw=;
        b=hI9qMn4T1lO1zRBKgR4akSX8DbCxFKD6xQFWht+tQpFA1zzDidpz5rYhKSYa3W0Ade
         7Mb6Rs+nFlqB4VMCBMr7yjTgR2cagYGotyVH+6fz4hU/kTF1W1S560g5L/C6ew2lxFkm
         0wFumXygda0SBQHDwo5e5CGvuuyjcU/ItMDAj7F/7I3Ip25AohFrEewV9pgaBos14NLE
         pInj1hhhx6y7b8p6cdB/3cwahyaLzLKHMUnUBUqSa7Col18dVPXlBCxPZvO19vXpoVx+
         QdGpXh2ZruhIHe196kzBFVPlKSzGbv55gLWnmT0ad6BMG60kUAw9w7u+cMZeIdvuH3ba
         0uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677830887;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoRqpQibDwb9oUpvtysPchQslDsCFyIvCUT4fTR3zSw=;
        b=am0X+VfGoDVMGr53VlT20HT8gHtHS/6wVdSW9fri/oFqWm9eUZwILa9sl80WMND3ne
         3EjddPYDrT6db8kWLLpphrZaDsmx43V7z5U5kxrZZNqiTDnSbA28V2bWFP94AsEQQOm2
         +bTMTopZLXMXzkT9eNEJEKkiDT/w1jAaPKdWEO3IRjmc4npo62G51FmBZduOS/cwT/TS
         eSzJ9SeroZYyjknHJOFhcH2oxPpiZhQZBo1TcTiE4osQO3FmxKmwAFERWNm/Wh4f4gqZ
         yhDNUJqMOB0oV9dk1/7ceaJzchfMMU1kQ2Udk6BlPk4jllO/O8a2LgEMHW+eGQx7OO9o
         eUKQ==
X-Gm-Message-State: AO0yUKWMG+rbk5BB4wAoL3cpEUyO0k0rZ2FY2EQmJck0WOGN7inmh1tE
	JlCZSs41wMuSDHEVOGAekIKD9mS2FWE=
X-Google-Smtp-Source: AK7set8pBOxk4Dp/Nqj0Ce+IGxN5jUs8FY1HCTW25fJeRH9CS7ugU0sYz8NJINSm75W0186s71cLlA==
X-Received: by 2002:a62:1acb:0:b0:5a8:51a3:7f69 with SMTP id a194-20020a621acb000000b005a851a37f69mr856554pfa.2.1677830886830;
        Fri, 03 Mar 2023 00:08:06 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id f6-20020aa782c6000000b0059416691b64sm1010438pfn.19.2023.03.03.00.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 00:08:06 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: validate the extent length for uncompressed pclusters
Date: Fri,  3 Mar 2023 16:07:43 +0800
Message-Id: <20230303080743.25713-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Keep in sync with the kernel commit c505feba4c0d ("erofs: validate the
extent length for uncompressed pclusters"), so that we can catch the
issue as well in fuse.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/zmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/zmap.c b/lib/zmap.c
index 89e9da1..69b468d 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -647,6 +647,11 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 	}
 
 	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
+		if (map->m_llen > map->m_plen) {
+			DBG_BUGON(1);
+			err = -EFSCORRUPTED;
+			goto out;
+		}
 		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
 			map->m_algorithmformat =
 				Z_EROFS_COMPRESSION_INTERLACED;
-- 
2.17.1

