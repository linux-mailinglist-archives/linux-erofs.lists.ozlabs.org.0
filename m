Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BF96A914A
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 07:56:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSdzz57DJz3cdb
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 17:56:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20210112.gappssmtp.com header.i=@sijam-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=mSw/P+mB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=asai@sijam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20210112.gappssmtp.com header.i=@sijam-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=mSw/P+mB;
	dkim-atps=neutral
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSdzt18wvz3bnP
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 17:56:25 +1100 (AEDT)
Received: by mail-pg1-x52e.google.com with SMTP id s17so903809pgv.4
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Mar 2023 22:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20210112.gappssmtp.com; s=20210112; t=1677826584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnJ/eO5x+Gxz37drEFqQBzho8O/aCeUhQQUc6O+h04g=;
        b=mSw/P+mB/rW7bLr5ciwJMXag3nhO2AGn6Cm5/vZRMdWMGAA0jWjc/wm36A7V8ZRTqi
         6Zuw/DFrbmWa0iIVIOhm71xHWo1Pb028hXA0uK/iIo2hbvUiebCU5QUGh15PlN/7nAyv
         /P0QDZ2DsgTJqpDh6KoBbiL2ZsBnx3AJFhv/xqDB1MmWvMimJGqsAdb/PpfY+nH6w1LD
         vu9ssVcvsg44vRLhRC/M5ZubYwKXZ2PiRKq/aTYmMgx77HXvW3jRngUFz1lRAQ20LJY9
         FXmKDj05i6LH5H3rrK/kNbd76i6XQ74dgumbk32NljJJRUKw5oZSvMzMfVEeLO0BlAKI
         bDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677826584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnJ/eO5x+Gxz37drEFqQBzho8O/aCeUhQQUc6O+h04g=;
        b=gdMAVxI/qKrF+JW/41Uee4FyA2IwX/8G6yqcv6nbpZo+DC5FzrDnrNISYXZKOgHVU6
         Mqd75sXVcnUFb68R294X9n/FR9IJrY/tZE7pOO4UlYwWJGeq27d2Fz8+DaaFS1au3mct
         s1SbUdefEGEKit2lQcpEL9zWBzYnulyNkgGRgVFUyaeY+pCbpzRrcZlI8iMIut0S9GJ1
         BXrztAbAQCQONJu4W5MTCsTx3lSJnl8bz1C3DDGRfdau/cBnHWybMQ+/OFtdLSklYl19
         rV3u8SLVzO6OK1MVREWoZsVa/AWq6JsRJVNRr7nwYpUCWOdW3/XeoWn6AYri1KqAt0AB
         dmLA==
X-Gm-Message-State: AO0yUKXwLY7x+TjzW03X0KRfALP8K0ltDh69kpfy5CqwYx30dasFg5H/
	M5JJTt/mNUjDlph8lIXEorNAaA==
X-Google-Smtp-Source: AK7set+/PjMASX/+gbBGP9KeMJHxtPHSWCk7Ngpmd5a/0puDKnesoFId18LeCQEK9TQHjeJMIj7vgQ==
X-Received: by 2002:a05:6a00:cd:b0:5a8:cbcc:4b58 with SMTP id e13-20020a056a0000cd00b005a8cbcc4b58mr1274330pfj.12.1677826584112;
        Thu, 02 Mar 2023 22:56:24 -0800 (PST)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id p3-20020a62ab03000000b005a9cb8edee3sm807054pff.85.2023.03.02.22.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 22:56:23 -0800 (PST)
From: Noboru Asai <asai@sijam.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com
Subject: [PATCH] erofs: fix validation in z_erofs_do_map_blocks()
Date: Fri,  3 Mar 2023 15:52:28 +0900
Message-Id: <20230303065228.662722-1-asai@sijam.com>
X-Mailer: git-send-email 2.39.2
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In case of reading fragment data, map->m_plen is invalid.

Fixes: c505feba4c0d ("erofs: validate the extent length for uncompressed pclusters")
Signed-off-by: Noboru Asai <asai@sijam.com>
---
 fs/erofs/zmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 8bf6d30518b6..902b166a5a5e 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -572,7 +572,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	}
 
 	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
-		if (map->m_llen > map->m_plen) {
+		if (!(map->m_flags & EROFS_MAP_FRAGMENT) && (map->m_llen > map->m_plen) {
 			DBG_BUGON(1);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
-- 
2.39.2

