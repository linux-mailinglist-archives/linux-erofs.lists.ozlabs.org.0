Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0184E292200
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 06:49:53 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CF4723ZMyzDqNx
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 15:49:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=JbXHUA7E; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CF46t5s5mzDqM1
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Oct 2020 15:49:41 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so5259701pfa.10
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Oct 2020 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+Ln7EJ1JCl0aJ5sXUv6hjWT8ahSAGF1tktFbBWr+eSQ=;
 b=JbXHUA7EfSHGxN/Z/HnQl8PatQct0FuX8/UdlZljO11sjLqw9tphma8biaD+YMHkdN
 ti0Uufv7/2f+ZDkDxUeB+Wg+kkbS+zPFEsDW9krhTlnMxLxn+njMPa0FkwogPxB2Idxu
 6b4zONrmoXIYLDdUhR27F3ebGipn2Lw49eM9/c+rkMMN30fvV9+hpvxo1pqSsQVGXnV4
 BL+rmOuf0F/QpLSXa3XAqqkyoPYESu3Ec+C1XIar+WrcNXDJi8fzABH62Umhs/SZB8eH
 0dkbR9yNxe6Lc+xJcKPf71cubKLzHscFXCRITABoyiO+G49NhVY7oaMFMM2vjYsw7G8T
 epkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+Ln7EJ1JCl0aJ5sXUv6hjWT8ahSAGF1tktFbBWr+eSQ=;
 b=KHzceLJJMqyHgv52jtR/2u8cUkZLGc5cwU6t5X4SWl7D/X+nCs0Ok/Qw9PoQ9AIApA
 5/yhQzpeC1u1qk01wwYPEZQm3iyyexljUdy9Jk3tFfgrLiaqxZF9GcDDmaJix2vwdJLK
 dSDcRdoLBQHrdrVh8gYZRQht8Qwuz1R6TVpmzOC+ZXJrhakwU9n5JY2Ahk7vZo1+ks1d
 vHMeIQ6kdCv+R1O7AzcHRSD4RcjT++blPZ6daGINwS+9mfzMJ9I6gwu0244bGMDfz14p
 PGwNKymIIG0T8/MfvWQk0KkBwMqzsU3BVLHpVOrXhjpENBwB7L2eBy+aL19d+Ry41YM3
 cKjQ==
X-Gm-Message-State: AOAM533sxKtLiEnkEcxPjq2m+QdXexzS/CsudbEbdxhurzaAo2luo22j
 UuNJGbBRtE/cw+HAz5xyHWar5wbEmPisbg66
X-Google-Smtp-Source: ABdhPJyvTcZrWwfgoycvDx2o6J2AYPbifXqwn8SWF0Bh4bkN1TcfDvvQJgVV0m/OvTx2pW1W40ypvQ==
X-Received: by 2002:a62:6dc3:0:b029:13c:1611:658d with SMTP id
 i186-20020a626dc30000b029013c1611658dmr15057272pfc.10.1603082977636; 
 Sun, 18 Oct 2020 21:49:37 -0700 (PDT)
Received: from localhost.localdomain (69-172-89-151.static.imsbiz.com.
 [69.172.89.151])
 by smtp.gmail.com with ESMTPSA id f66sm10542376pfa.59.2020.10.18.21.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 21:49:36 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
X-Google-Original-From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fuse: fix the clerical error in ASSERT
Date: Mon, 19 Oct 2020 12:49:21 +0800
Message-Id: <20201019044921.124654-1-huangjianan@oppo.com>
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 fuse/read.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fuse/read.c b/fuse/read.c
index fd70a2a..e2f967a 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -120,7 +120,7 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
 			length = end - map.m_la;
 			partial = true;
 		} else {
-			ASSERT(end == map.m_la + map_m_llen);
+			ASSERT(end == map.m_la + map.m_llen);
 			length = map.m_llen;
 			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
 		}
-- 
2.25.1

