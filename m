Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79B8CDBC5
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 23:11:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1716498118;
	bh=D3TGBYS4I1uMWqtuBv6VS2lwGxgaWWfPy0VXsYNJ+Qg=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Qe/bGGFc/Jej6c2ROtUKNfvOO1vPD6U7whT57dYL3FYEh/y8xrmgqASqhyaOVSzTq
	 LgO9nBUGaaJcJZUuzlMzlFSwPIbPs54gkstoo8qqDu5wTr12dcKMvDa2hYBJJdzibx
	 7NgcGwFGVBKuohv6j/QZbcipdthYCVntopIYNImawKivV8G+ecKu1E7LURZzRi3Nwy
	 8Rrfjl7BdnhJcDhuz4b6nG+Fwjh7yaI7F9AapjkWst9SyP4LUIZUno10E5H5V4Hn4H
	 IQNdTqUhaYKtp3KYSm13uGANeei3b+iVmCIXqB/eH08FlTFwbysj/ihjf5CJtnpvkb
	 pS9i2FBXclUoQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VlgbB0G0sz87Rl
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 07:01:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=cEgiB+Kb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::114a; helo=mail-yw1-x114a.google.com; envelope-from=3tq5pzgckc4sswpap0tv33v0t.r310x29c-t63u70x787.3e0pq7.36v@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vlgb16qFzz3wRR
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 May 2024 07:01:48 +1000 (AEST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-627ecbeb30eso39469567b3.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 May 2024 14:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716498103; x=1717102903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3TGBYS4I1uMWqtuBv6VS2lwGxgaWWfPy0VXsYNJ+Qg=;
        b=tt/J+fw82n7ZbyZ3LYg5fw9iOrP/w+cJPRC7frwU4shXjoYfoVcWIqn9an3BGok5A0
         fAjmp9betHLWznRdmAR3OUDMcHAwoVaNLvxnZDylw5GADX9/yXgj5u0nlCXvrl74Oasg
         jQ3KpnXhMvS/YHRHh+9Ozeg+gn/9xKRSCZi/pTQPICOeySSs/aWyLJYSEjk3aaETruzI
         bYt+47TiwDXgx3LKRS7qfystiTnr8d4jxDfMrCy7LLHSCGMiatFT0Yui0RbRxd10dWLR
         +LI13o5kdSqZ6G8jrx8N4tGRkHo2n6et3XFA3mZf9s8wALMZqQeP+yNpBRR4+XtwUnSG
         zIwg==
X-Gm-Message-State: AOJu0YzMH0FYWmg00X8P0kiQ+ZmXdn2B5iflvPpv+kC/vNWvk38IS87x
	GooGNBEtzOPhnRh7QIBeCbm0s7nHuLIPMd+qeqdoELcKwIgsvM2gMkVEMUIRJcxcA8hyV1zZhLE
	2dHk5BEg2Nz2rlL5Z0o77VPBGS92GvXASVi+Rh88uH163THlTUnZHyFjznpz7SdQeOmItHoAYo/
	vtqbbm0pTqCvb3MyzxvmSlV2JP1MTV36YIGeZvIhrqIut3Qw==
X-Google-Smtp-Source: AGHT+IEOzrkL7uD4TRJSa159RRmQLvarDINzMp5CdkUGJT8Y/LTAZw/aJj3Zv2gIk+ObD6fbIXlXb4vxjqXB
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:a2ff:32db:ca12:f9f5])
 (user=dhavale job=sendgmr) by 2002:a05:6902:f85:b0:df4:a381:5cc9 with SMTP id
 3f1490d57ef6-df7721e4523mr89591276.8.1716498102961; Thu, 23 May 2024 14:01:42
 -0700 (PDT)
Date: Thu, 23 May 2024 14:01:30 -0700
In-Reply-To: <20240523210131.3126753-1-dhavale@google.com>
Mime-Version: 1.0
References: <20240523210131.3126753-1-dhavale@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523210131.3126753-2-dhavale@google.com>
Subject: [PATCH 1/2] erofs-utils: lib: provide helper to disable hashmap shrinking
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, junbeom.yeom@samsung.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This helper sets hasmap.shrink_at to 0. This is helpful to iterate over
hashmap using hashmap_iter_next() and use hashmap_remove() in single
pass efficeintly.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 include/erofs/hashmap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/erofs/hashmap.h b/include/erofs/hashmap.h
index d25092d..484948e 100644
--- a/include/erofs/hashmap.h
+++ b/include/erofs/hashmap.h
@@ -97,6 +97,10 @@ static inline void *hashmap_iter_first(struct hashmap *map,
 	return hashmap_iter_next(iter);
 }
 
+static inline void hashmap_disable_shrink(struct hashmap * map)
+{
+	map->shrink_at = 0;
+}
 /* string interning */
 const void *memintern(const void *data, size_t len);
 static inline const char *strintern(const char *string)
-- 
2.45.1.288.g0e0cd299f1-goog

