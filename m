Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE4347CAEB
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 02:49:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJbpw5DXpz2ypV
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 12:49:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1640137768;
	bh=DkT1DIxWSEK+IbPoO8EjD24RH82e5udaoLLtm83dCzE=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=esxQSXuB9+lWEK+PBrvQaSkogSjI+lQN8mS5MK+eIgfdzDEswJ/Yhc/u5SKoBhM3y
	 kQxANNpOJJreRsjfivToi0DeOmTZWbYt7hakeF09WVajKD5U+T4R0uGEpXeCUgk8st
	 JKoJ/GOfQqxKuI7TFRqnmkfyXXAawttZDm4gLsAl25X8LjR264WzEGnJxjTMzLrIj3
	 cRkZi8Ukt8MmqDxhevGetXxfCwgSQ++2jPGz/svHcQlVHElkayxXyZ/UeVKqJqFZy8
	 vV7rbKHDWOMd8X6jHDtekF++5I8l2B1Ei1aBgtNNCILcyrjf5Jk62QPSZ1wO2ypsdU
	 56JC7jwNuKlDw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::949; helo=mail-ua1-x949.google.com;
 envelope-from=3iitcyqskc0c8qjwptnu4rwpxxpun.lxvurw36-n0xo1ur121.x8ujk1.x0p@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Jc+tkjHH; dkim-atps=neutral
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com
 [IPv6:2607:f8b0:4864:20::949])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJbps0ytNz2xrP
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 12:49:23 +1100 (AEDT)
Received: by mail-ua1-x949.google.com with SMTP id
 y5-20020ab05b85000000b002fa1b6d2430so488395uae.0
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 17:49:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=DkT1DIxWSEK+IbPoO8EjD24RH82e5udaoLLtm83dCzE=;
 b=kCB8KlO+mQeURTbYzamlzaZ5dAvUcFI93d88fKrnoAfM/rAUW0WD4v/KI2AlB5tUTQ
 7+cfRfF4NX0z/6Nt/wfATvshDAMix0SWnni+3yyDqV3nIz+Q/nEcMR5hQZt3O6lNUlhq
 EqiOrYNo4EhWFkgy+fuMmWGwpRH529eCY3AsDuuooSPsC2+CqKLPs8gIwYwrD4Y9KijS
 esmsiCnSoLXIInk73AQt/WNEfjA8bLto8sv+W2I8ifS0u4u8StvEp4zCs7FdKcW+e1Wz
 gcaKbemrfrj+ezOFbNexEYsZ4HR5B54ac67I+Jo5GKCtykJS/i/3uqwB0ZpHZakCN/TV
 xisQ==
X-Gm-Message-State: AOAM5315EH+TqXOx/bkJNJlzhY90XLikY6YJOrr6aCjHH8PNg5OxtUeH
 q+GKXjbrcWzbXQpGniUwgxZW9N+NKRq1ap0VpvzL7irfxZFPGasUe0MX2SJVF7Bta7lH/OLLEZl
 XjGG0ODEmLKfG5MnmIhub5w0CeV2HTCrYqOUCyK8jIguZuAHSXVYULnCk3zUdAlYxr82FrVneyn
 EC0IQM4TQ=
X-Google-Smtp-Source: ABdhPJwRuBuRFYXx4lcfUkmHrJV/GzikaO1KN54whaoLeS15Cb6sftiaCcjYCMXjZDN5avqS6aqJzqidj6pm2s1YIw==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:ab0:2b96:: with SMTP id
 q22mr305590uar.87.1640137760193; Tue, 21 Dec 2021 17:49:20 -0800 (PST)
Date: Tue, 21 Dec 2021 17:49:16 -0800
In-Reply-To: <YcKDAILGEoYFE7K0@B-P7TQMD6M-0146.local>
Message-Id: <20211222014917.265476-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YcKDAILGEoYFE7K0@B-P7TQMD6M-0146.local>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 1/3] erofs-utils: lib: Add some comments about const-ness
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

