Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C688128F382
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Oct 2020 15:41:21 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CBr664SS6zDqQv
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Oct 2020 00:41:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rDesFcQA; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CBr516kBDzDqLK
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Oct 2020 00:40:21 +1100 (AEDT)
Received: by mail-pj1-x1044.google.com with SMTP id p21so1879225pju.0
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Oct 2020 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zZawlM96nh4rdHU4Espov3IpB9ummwtKNC5q/YuNaSw=;
 b=rDesFcQAZ8UwkDUhwX/F21x9ZXox2zT/hH72rj7ZzflMUl3OXfI9A/K1mk/Shk5Ys9
 yj69Ad2X0rqpVdvhbdTEU83JPsb9YGIaUzhHs9AWGQuR7QsQLhhQw2bNlmMFNtDDcEFr
 kolZqRv9s9DXxu/AclXO2wPHO3b54k630IEdSYbf6bGvsR9UFACwGFLrqeZ2Ijjm29Bm
 5rwoIf+38UAkiQY0oOHR2QNi4XC0Y3cvlzNuhTMDfQutBYOvzM1p1FHQiDCdyKqLX+Fb
 4X3p/zHHDuvQFrcL9CEaFVc2TLYAZ1EP++KBp3TbsC6K11DErsNnCCOZ8nfpjxayyLmG
 t8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zZawlM96nh4rdHU4Espov3IpB9ummwtKNC5q/YuNaSw=;
 b=RndYN8sDaU2wDfJt8wdT+RIzWbxUBVBg22PhGwwyLs2i9HrB6eJ1t7bHo4MNjDIDBS
 AX2B26jGMp9EEemai5AAg6bJwMlOqbyLrFuDhLjV/CAIFiKhA0JnOg147ihWryoZCuBt
 MBU9hDVGkK1Cze2A+/OcUGqxKBL6FPWQbqXeBY6798OvjzFZiSXQDPSgDUQsT7lqTx9l
 MKPdsOz4h7+8Z5R98P4lFJTcdI1+NPjd1r03XCN2/qPWSdJoIxryCehGpA8hwJjK/bF4
 puE/ojRBzo/w3yYHUO7MtkcIaL0cj1Yf0KEzd7gDnfCJkVikY807HoUsPQAh0mmTAk4S
 yOGQ==
X-Gm-Message-State: AOAM530e46ORPXhZOz98ClreuZ7xpAjHjFW5dKdzvC9xSHA3DhYvWmKe
 iYpWK3uqE8DVV6b95Ah+vL8Oy9cii13V4SEJ
X-Google-Smtp-Source: ABdhPJwtB5vOfnzVwprY7tGpNpyl/d8TjOckI4APvpxvA0I0JSDq5LJbLeCZP1EOWTHFTIrsWmEh/A==
X-Received: by 2002:a17:902:be0d:b029:d2:8084:cb19 with SMTP id
 r13-20020a170902be0db02900d28084cb19mr3944728pls.45.1602769219041; 
 Thu, 15 Oct 2020 06:40:19 -0700 (PDT)
Received: from localhost.localdomain (69-172-89-151.static.imsbiz.com.
 [69.172.89.151])
 by smtp.gmail.com with ESMTPSA id a19sm3426058pjq.29.2020.10.15.06.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 06:40:18 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
X-Google-Original-From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/5] erofs-utils: fix the wrong address of inline dir content.
Date: Thu, 15 Oct 2020 21:39:57 +0800
Message-Id: <20201015133959.61007-3-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015133959.61007-1-huangjianan@oppo.com>
References: <20201015133959.61007-1-huangjianan@oppo.com>
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fuse/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fuse/namei.c b/fuse/namei.c
index 21e6ba0..3503a8d 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -158,7 +158,7 @@ struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
 	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
 		uint32_t dir_off = erofs_blkoff(dirsize);
 		off_t dir_addr = nid2addr(dcache_get_nid(parent))
-			+ sizeof(struct erofs_inode_compact);
+			+ sizeof(struct erofs_inode_compact) + v.xattr_isize;
 
 		memset(buf, 0, sizeof(buf));
 		ret = dev_read(buf, dir_off, dir_addr);
-- 
2.25.1

