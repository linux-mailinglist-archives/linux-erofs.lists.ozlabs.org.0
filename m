Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D8447CB23
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 02:54:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJbwl1l2Mz2x9g
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 12:54:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1640138071;
	bh=DkT1DIxWSEK+IbPoO8EjD24RH82e5udaoLLtm83dCzE=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZqADjrv916r05kdp2/jYPO3m04MI64AGvJkZwVBnjLYFDdABqt0zPizyWxvGV+XYQ
	 7NFVjvrcVM1Sv6UR1RS5+YQXb4FfgAuU/7ecHgKHPQlpYMIU604CLGTKph5TD2TDiE
	 g1uh2mABgFNWIKchHfm1InIWoGKJxqAbcx6R3WphAGf8Q3TGly+A4TYmaXyc6o2Wga
	 9cLttnzRmAJ2areGfzNB8Pi/ubNYGwi6n3VRhKhwauZxBS+r2tz4AEOnKx2p5vWRjI
	 XfHirUXIY+f+HKRHujZ51p4anRl2EA+WVk08EXT1fcvZI3yIm8RB7RiFdguQbNEZVG
	 H4brE/Txb0qTA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::94a; helo=mail-ua1-x94a.google.com;
 envelope-from=3t4xcyqskc3gvdwjcgahrejckkcha.ykihejqt-ankboheopo.kvhwxo.knc@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Iij1l1vl; dkim-atps=neutral
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com
 [IPv6:2607:f8b0:4864:20::94a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJbwg6pBBz2x9g
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 12:54:26 +1100 (AEDT)
Received: by mail-ua1-x94a.google.com with SMTP id
 y28-20020ab05e9c000000b002c9e6c618c9so420151uag.14
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 17:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=DkT1DIxWSEK+IbPoO8EjD24RH82e5udaoLLtm83dCzE=;
 b=z9M492fbJNfLqrnScqhUBQINKhwVVcZWpoBO1QdsXFsc1ZCxBF90iBdRdRo2UUSo8F
 n3W0Q5DpSy81fd3g6xN2zH61slh8vzRH4GdvJwkV870Qq0hMEbGAt//XCsfnuq7BR33k
 BhSnCs+53aCH0MJP22SkHzd1rwswUGajlv8CcLrJlN0QiBVbr+GfdtTY1En/B9d6EOxv
 izavJFX5kcdyYN1HNzOV59kaj83pD5qRUjGKvN2YLApGtBSoNbvzKj0y3+xeNKillJKQ
 OxZ/k9EGGKdfLcvfheB8Mc1HcHzWH9QI8ZWnxeGxKgsOtWkWhDGX1LWkdRPXmLbasJtx
 30Fw==
X-Gm-Message-State: AOAM532MsheqdldAhD8k92rsmXSEr6xu3bD4pSZn5Z7qRkgRMbZEziXG
 krNNFOhxWzwyjGvqwPOQ94A4cVzWJnhrYIFOmJLvmjxi6URl/E9nDcOU58nkfwejj7rgLV06jmr
 ryypuGheF1zyvWBdX/7n4kW31EUlXJRzl/3mOo/IWou63WSyQUtytEEapi9PQJNzxg7+XgO/zCr
 WA8cF6cY0=
X-Google-Smtp-Source: ABdhPJxmaLGOoDXW0nTq92LUczecjP5HcwNKLLC95fkDRNVF196hV2qOgB1lvsg7+kO+69a0Sfz2IAFI373NU+7E2w==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:6122:a29:: with SMTP id
 41mr366681vkn.25.1640138063833; Tue, 21 Dec 2021 17:54:23 -0800 (PST)
Date: Tue, 21 Dec 2021 17:54:18 -0800
In-Reply-To: <YcKEafQ+nJJ/xQYZ@B-P7TQMD6M-0146.local>
Message-Id: <20211222015419.268586-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YcKEafQ+nJJ/xQYZ@B-P7TQMD6M-0146.local>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 1/2] erofs-utils: lib: Add some comments about const-ness
 around iterate API
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The new iterate dir API has non-trivial const correctness requirements.
Document them in comment.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 include/erofs/dir.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/erofs/dir.h b/include/erofs/dir.h
index 77656ca..59bd40d 100644
--- a/include/erofs/dir.h
+++ b/include/erofs/dir.h
@@ -39,6 +39,14 @@ typedef int (*erofs_readdir_cb)(struct erofs_dir_context *);
  * the callback context. |de_namelen| is the exact dirent name length.
  */
 struct erofs_dir_context {
+	/* During execution of |erofs_iterate_dir|, the function needs
+	 * to read the values inside |erofs_inode* dir|. So it is important
+	 * that the callback function does not modify stuct pointed by
+	 * |dir|. It is OK to repoint |dir| to other objects.
+	 * Unfortunately, it's not possible to enforce this restriction
+	 * with const keyword, as |erofs_iterate_dir| needs to modify
+	 * struct pointed by |dir|.
+	 */
 	struct erofs_inode *dir;
 	erofs_readdir_cb cb;
 	erofs_nid_t pnid;		/* optional */
-- 
2.34.1.448.ga2b2bfdf31-goog

