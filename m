Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A001D607259
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 10:32:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtyQG3lgKz3drV
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 19:32:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SQLfosJ0;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=SQLfosJ0;
	dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtyQ71VK2z3c7V
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 19:32:29 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso4621082pjq.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUhUf8tD5P9UtY7kvr1O4iHq3ocdqCg7p3bMwN8zrt4=;
        b=SQLfosJ00IIaQWaztjwBMmwEMk2b/3/oJ1NnBipOaC+XOHnQRX+9CmqfOdvo3fCRl0
         n3vIk9R5MCtn/iXYYLrWHXlXYecIMGvuyt93PTOcDa5xCS52bFtcHH6vMI5kge6/udx1
         P2undt15ogyw2MiL1e3SeYyPZ4HQ4dsJrB54xL0ys+uG0A7Rv5OVnb6RvJEWKTya4OHd
         ZTFgBHFll4j5hdLMLCTxGl344rzT9Ab77+DbuTJmSXBFyz+7uYGtEZ+4qA+DWECLt5F8
         hMan3jzzD3INwa8sZdelPDOLHS2qXKPV/5tm2TshM3tgDlYonvnsbWFNXAqdpHs/eQ6w
         o9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUhUf8tD5P9UtY7kvr1O4iHq3ocdqCg7p3bMwN8zrt4=;
        b=Ind3V11/qQnpov4ygLple2fHRH6ATRfVZ4lsxHb+gw48eR9ycp5GYo9gIo3XgbfUWr
         lvGdINXgZVYsFln5avzMqfIGZzbba0YuDslpPHaxKmaQUz6BZs0UMAdO6fvo6cz7JabX
         TkN2nKu8RogblP5DJv37SIsmEros8C3D+M0K7GoOgfJoUFafkHGxJnmjrt8TM23BosrC
         OcDhlP/gefsSDUub9FkU9/EOujboAmgO6GREOz7ARTThhbTtU5iE2K+k2uIDZpIDmTAj
         WNniUpQhq0Yl0kQJ3Y5DGKCAyW3tI/i1aSazeq6kfxlYXHC6Vt+4IzoopxwL2sSDNUfX
         O8pA==
X-Gm-Message-State: ACrzQf12X6nfx7vZZ2rLFoadg4DmgJP0NyEbCCBYOYG9HA+O/prS/JQv
	WvDz5PVYF4qOBvnDWBl3a5c=
X-Google-Smtp-Source: AMsMyM71jJ7gDgk17Qb+d6fmhl6HWAVPYZLi9r4XOtM3m+aM3RfKluid6P6DtU51uQGlUgqwpgispQ==
X-Received: by 2002:a17:90b:1d4c:b0:20a:8db1:da52 with SMTP id ok12-20020a17090b1d4c00b0020a8db1da52mr55567602pjb.98.1666341146252;
        Fri, 21 Oct 2022 01:32:26 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090a650500b002009db534d1sm1098630pjj.24.2022.10.21.01.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:32:24 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: fix general protection fault when reading fragment
Date: Fri, 21 Oct 2022 16:31:16 +0800
Message-Id: <20221021083116.20048-1-zbestahu@gmail.com>
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
 fs/erofs/zdata.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cce56dde135c..310f6916787a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -659,6 +659,9 @@ static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
 	u8 *src, *dst;
 	unsigned int i, cnt;
 
+	if (!packed_inode)
+		return -EFAULT;
+
 	pos += EROFS_I(inode)->z_fragmentoff;
 	for (i = 0; i < len; i += cnt) {
 		cnt = min_t(unsigned int, len - i,
-- 
2.17.1

