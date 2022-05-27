Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A94535E07
	for <lists+linux-erofs@lfdr.de>; Fri, 27 May 2022 12:18:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L8gkT5qtqz3bl2
	for <lists+linux-erofs@lfdr.de>; Fri, 27 May 2022 20:18:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=uBfTPlik;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=yinxin.x@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=uBfTPlik;
	dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L8gkL4Cw7z3bdY
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 May 2022 20:18:29 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso3950520pjb.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 27 May 2022 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IePfBH/nuuLygiCbsIKPQDRgXfSovp7fw2Vz5Vg6Rc=;
        b=uBfTPlik9pNsJETeSCIcD95mgxMFm8yBf61D5mLAbihKVR3gfoclBA1Db2x3zDJHnO
         PbAkqeLt5MqkR9ovKeXLz1pIEdW6KzXOwvixmD5QZj7vzmhN4EHQX3jQNYehjuHecVja
         gE/vz+3GhMUyEZl7pVXfl2DbmWwTG27D1bULV2VtWWowuhfKYZmwn6HNI1t0RCRP3Iag
         UZQRqsfPZud7hoB567gqoS7WfKcuUKnDe+4DhwBvvXVW2/djgEPItrszw8Pnsyftyfou
         S8n3IHbv7EeoQxv4Ms2ZLf+ts2JNe2MM/aBW48iiuiiogk3ODxpvWnenSAlcEAYTEIcs
         p0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IePfBH/nuuLygiCbsIKPQDRgXfSovp7fw2Vz5Vg6Rc=;
        b=2Fo/iuQqYpzD6Bu2kwYQcLXYoYdi3svyCzErH0WIxNLQcYkSKgZVjIZvRFHxKQsjjj
         Fk29HZ8osUKBf3EycVp2wql8L0um+i1K5eTf1HcFzoYhFfvN1FdIWocU7CBoAj+7UdW2
         3FFXtCQIcNYn2WTvjEYjbGxG8wGeVY8XEVM1ppEhYtvLmiBt5l4IIpRNd3Gk2qL1gG9Y
         MiGfHun+b0m9QWBsm1vdd4gB0vC5ZWEEsiEpDkbqjrEusDlZJvdXamc34/0XrajindyC
         EQUz2USO9bwi6oOEC+deMSGxbF0cC6mXAbn4RoFatWD39mLopMxzLfZqbgjwX2bc4VG1
         KOsA==
X-Gm-Message-State: AOAM533Y/z937KgzlyOUtwN3N5t8E7yH4kvOUf5PyjWO6xPmy0rAvO5U
	8lJ5ruYlfZhjyUdw/FBgfm1jHA==
X-Google-Smtp-Source: ABdhPJz2PbqQPOjqL7yYJqZ1jXjHOQJ8j6JBiLJt5OMAn74L4NP7q/728TexgqF4/jTOmS0JuyoEew==
X-Received: by 2002:a17:90b:1c87:b0:1ca:f4e:4fbe with SMTP id oo7-20020a17090b1c8700b001ca0f4e4fbemr7515970pjb.159.1653646703587;
        Fri, 27 May 2022 03:18:23 -0700 (PDT)
Received: from yinxin.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090adc8200b001df3a251cc2sm1255083pjv.4.2022.05.27.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:18:23 -0700 (PDT)
From: Xin Yin <yinxin.x@bytedance.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH] erofs: fix crash when enable tracepoint cachefiles_prep_read
Date: Fri, 27 May 2022 18:18:00 +0800
Message-Id: <20220527101800.22360-1-yinxin.x@bytedance.com>
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
Cc: linux-erofs@lists.ozlabs.org, Xin Yin <yinxin.x@bytedance.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

RIP: 0010:trace_event_raw_event_cachefiles_prep_read+0x88/0xe0
[cachefiles]
Call Trace:
  <TASK>
  cachefiles_prepare_read+0x1d7/0x3a0 [cachefiles]
  erofs_fscache_read_folios+0x188/0x220 [erofs]
  erofs_fscache_meta_readpage+0x106/0x160 [erofs]
  do_read_cache_folio+0x42a/0x590
  ? bdi_register_va.part.14+0x1a7/0x210
  ? super_setup_bdi_name+0x76/0xe0
  erofs_bread+0x5b/0x170 [erofs]
  erofs_fc_fill_super+0x12b/0xc50 [erofs]

This tracepoint uses rreq->inode, should set it when allocating.

Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache
readpage/readahead")
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/erofs/fscache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index a5cc4ed2cd0d..8e01d89c3319 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -17,6 +17,7 @@ static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space
 	rreq->start	= start;
 	rreq->len	= len;
 	rreq->mapping	= mapping;
+	rreq->inode	= mapping->host;
 	INIT_LIST_HEAD(&rreq->subrequests);
 	refcount_set(&rreq->ref, 1);
 	return rreq;
-- 
2.25.1

