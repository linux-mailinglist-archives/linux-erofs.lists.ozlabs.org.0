Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B954000AF
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 15:41:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H1Jq026KRz2yNp
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 23:41:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZlxYoG6v;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d;
 helo=mail-pl1-x62d.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=ZlxYoG6v; dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H1Jpk12lgz2yLq
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 23:41:01 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id q21so3333053plq.3
 for <linux-erofs@lists.ozlabs.org>; Fri, 03 Sep 2021 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZmTTxCx4e1R3uH9AOCHqDfVf8lbrwp0dzDr0HVue2js=;
 b=ZlxYoG6vsUZs+NEVv3ZdarY7VUfzrctu7bt6KT17WInpdVArGQsBuJOlnp3rM504It
 /rIod4lrgd2aHLN0nDDtyjRGu/TY1dFa28qbU9Z5VzOHIxMFmvItoBOGvLC9x4WzCeGH
 xciLV8hbEp0sDdmeNZ0kg8/qCGEy9SRXkfCXfGBsuyvTi3R+KN6E/db2DIJqIPHySdVk
 u6F1/lWSbFokWMJgJL9NPhwFEFWxKbrv9QjjYr4oMDX42kWIXF8vd9cafrzQcvz65lsu
 wHrgvLb45GW50NQiDtA/WK6DnStpqBNCT8erNGG3gEZkvnWJXMTiWOOEss2Vm/25hyv6
 /tNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZmTTxCx4e1R3uH9AOCHqDfVf8lbrwp0dzDr0HVue2js=;
 b=KacGjhBqI5JXD3xB8KCvIZ51Tu6SM8HiXn1mpmhbsBWD4Ydx8dTepjR+isNYXa0aga
 HWX9WAn61bmOgbfjFHMho4uUwOpliEgJzwC9WNPKoOYFydGN0ItyZo4nb+neLev0r80L
 y4GI81ZaoOER4srTv/aBTY8kfx9LtjkY7K/ghuf+yrJxVXp17idLHqzlb8DdvZg3/wgf
 n9f3uoZJAUBdlLMWzac5KC7MqtQY01VqvdVqMxouFHO/lMI0TrPyraRmStensBF33rXg
 uAngCnBcUEeAkgKZ6EoSPia6yfkHtalbBbWaBGpjZK7vKGpbPrHxILXrM27GLAAs6Ki8
 S8Sg==
X-Gm-Message-State: AOAM532TZU4f3DmblM2w/lQ6cshtqOfzWavm0xKAT1S8rz+chIcSzrEB
 Ql+gGXbfZd6l7SLSG08d8jrC1ULjrcXvya96
X-Google-Smtp-Source: ABdhPJwJS7r2dgomN+7fKKvz+wFjWZBYRV+jknsavwUcZNnmi2SWdpz5Zl6MNWSULpUbpH6lZmVCFg==
X-Received: by 2002:a17:90a:1950:: with SMTP id
 16mr881682pjh.126.1630676459867; 
 Fri, 03 Sep 2021 06:40:59 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id o1sm5590948pjk.1.2021.09.03.06.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 06:40:59 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V2 6/6] erofs-utils: add missing /* fallthrough */
Date: Fri,  3 Sep 2021 21:40:35 +0800
Message-Id: <20210903134035.12507-7-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210903134035.12507-1-jnhuang95@gmail.com>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
 <20210903134035.12507-1-jnhuang95@gmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 lib/zmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/zmap.c b/lib/zmap.c
index ce79601..458030b 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -360,6 +360,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		return z_erofs_extent_lookback(m, m->delta[0]);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		map->m_flags &= ~EROFS_MAP_ZIPPED;
+		/* fallthrough */
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		map->m_la = (lcn << lclusterbits) | m->clusterofs;
 		break;
@@ -479,6 +480,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		if (endoff >= m.clusterofs)
 			map->m_flags &= ~EROFS_MAP_ZIPPED;
+		/* fallthrough */
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		if (endoff >= m.clusterofs) {
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
@@ -494,6 +496,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 		end = (m.lcn << lclusterbits) | m.clusterofs;
 		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
+		/* fallthrough */
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
-- 
2.25.1

