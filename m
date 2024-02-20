Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F137985C466
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 20:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1708456338;
	bh=bU90kCEdhdXywfoVlc2lzAzGm8wFNOTBAuo+9ULMyJM=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=A+OwZbr1V3iK/mGfVlYY7bk5sUpZdV1rBcQI+srlqgyRJdzCIkbkxF+ef2NuMeI9O
	 yaUwv0She1ExCVmhk/Uag/nlsn7SNl8FEOhWQncpdiPC9BsT235MA/AQIUiMAVnBiZ
	 +m5g5vw3Zz0yeeV2CaN90fBP5307C/EtBpiKnwT+W8Img5mJ9iIi0+PAm+Nx4WdZ+N
	 NHKJ+9z9m0km8Ou+SOFwxbOir+zSnnj5Cl5uvKDU5zpSyFZlMaBvlkEaJGMY8/QpBo
	 nS70zeHt55tjF5EywZHNxlSEO78nh9b01+T7ILhpAApYoT69nv1T7THFW//wXNritD
	 15LllzsiASfEA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TfTYZ4cDNz3cCb
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Feb 2024 06:12:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=rtSPVDZX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com; envelope-from=3hvnuzqckcwmgkdydohjrrjoh.frpolqx0-hurivolvwv.r2odev.ruj@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TfTYV1NQ9z3br5
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Feb 2024 06:12:12 +1100 (AEDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so6928707276.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 20 Feb 2024 11:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456327; x=1709061127;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bU90kCEdhdXywfoVlc2lzAzGm8wFNOTBAuo+9ULMyJM=;
        b=KJUviEifGHfF4WrTiMybMK4Sp+kUQo8MYLBuebZm/pDANA2UxY8cd0V2J0yY8ApJCh
         1my/C+Ej+ikCkr9iJ5lSxxlRnXxUit+iC/BRSiCkwsfj7hKfDs+fW1SYXYyqZhrxXX3o
         EFKnadV7l2WC0ZrTtzOe03nB88W6obP1J2eyXFev8b5MMMq/coJBU/RgI6rHYaAMEpA0
         G7Xa52CzZ4V8i6/ZCQmIrpDTqqqKwv1VhExUF4oSJ37fo6p9mBS0LasbHEWiIO4AYUv8
         x05ArpCDfJHtUm3VWOC821dS6sq3/5yWBNROOvJ8RzpfBHye7PTfPNicWjiE56vJHUCz
         oXqw==
X-Forwarded-Encrypted: i=1; AJvYcCVcOqTe34kikvZsV/9c6XowmVJ2JuZgK+RrIAzTeugYQQqNtM72HSnYazLmLbnDyjRZe0ae7pYsXsjP6XogLoXp6XvZrWduhru8ojQc
X-Gm-Message-State: AOJu0YwEX769mZEIS6AkMusswy9n+N4msa6YMYpYNjPUuZz/tJr6RSbQ
	c2qTKxwApBX4j8pruYHvcM3pAMJOVXwfObTrO/0/Fqk3Ry6KBL4QFkTqCDsnsCZPzrCzz88yevy
	/FDnATw==
X-Google-Smtp-Source: AGHT+IFgWEyzh6gqAlMtSgK/wXXqU4pIoql4Z5IpkPLY2RoDnc1t6RBLCmFcVpYqnlcf+nvulgO8DKFOkeQR
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:e64d:5a86:7ce2:3f59])
 (user=dhavale job=sendgmr) by 2002:a81:fe07:0:b0:608:22c7:1269 with SMTP id
 j7-20020a81fe07000000b0060822c71269mr1506123ywn.0.1708456326859; Tue, 20 Feb
 2024 11:12:06 -0800 (PST)
Date: Tue, 20 Feb 2024 11:11:13 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220191114.3272126-1-dhavale@google.com>
Subject: [PATCH v1] erofs: fix refcount on the metabuf used for inode lookup
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, quic_wenjieli@quicinc.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
we do not assign the target metabuf. This causes the caller
erofs_namei()'s erofs_put_metabuf() at the end to be not effective
leaving the refcount on the page.
As the page from metabuf (buf->page) is never put, such page cannot be
migrated or reclaimed. Fix it now by putting the metabuf from
previous loop and assigning the current metabuf to target before
returning so caller erofs_namei() can do the final put as it was
intended.

Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
Cc: stable@vger.kernel.org
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fs/erofs/namei.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index d4f631d39f0f..bfe1c926436b 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -132,7 +132,10 @@ static void *erofs_find_target_block(struct erofs_buf *target,
 
 			if (!diff) {
 				*_ndirents = 0;
-				goto out;
+				if (!IS_ERR(candidate))
+					erofs_put_metabuf(target);
+				*target = buf;
+				return de;
 			} else if (diff > 0) {
 				head = mid + 1;
 				startprfx = matched;
-- 
2.44.0.rc0.258.g7320e95886-goog

