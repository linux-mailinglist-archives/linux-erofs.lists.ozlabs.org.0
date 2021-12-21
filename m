Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE18047C179
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Dec 2021 15:28:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJJjV3cjwz2yLJ
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 01:28:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1640096926;
	bh=8R/YZNx5T0lGVJ/lTtulFUVMJuZmEza15lfVi4DdwHM=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=OCVG9I8iHEwwLvbNGx+s6nu+1Mt43knGav4U1cJQIqTtlZ1oBw0oiGUW4tCpKNGss
	 lxqLPD8n4QXjxHmuT+1fSldJx4W8OyfNVFmiaA3bjZOPAna8yUC0wOP5kKPVAQOrn9
	 X7IqLb9L9Wb7MZPpDQXZxtS1dE7q6K2qN/pMN3WpfDUy+ysOWdpu2QL0d7lXwzZVEL
	 vI8xvNw0YLcvrPpmqAHWl2XCtIG7gBqhiKhm5oALn3fl//HyaYctV35hhKT5EvSVd1
	 RAcGKv4C75bujN6k2X34xvEHIZVJk0JzQunwBjQPvZtYej/tNohuluo4Cf1jsfl2XE
	 2mcg/z3zRBRYA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::a49; helo=mail-vk1-xa49.google.com;
 envelope-from=3ketbyqskc3ytbuhaeyfpchaiiafy.wigfchor-ylizmfcmnm.itfuvm.ila@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=TUMxsUvw; dkim-atps=neutral
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com
 [IPv6:2607:f8b0:4864:20::a49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJJjN47vcz2xsj
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 01:28:39 +1100 (AEDT)
Received: by mail-vk1-xa49.google.com with SMTP id
 g4-20020ac5c1c4000000b00312a2a1de20so2413984vkk.12
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 06:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=8R/YZNx5T0lGVJ/lTtulFUVMJuZmEza15lfVi4DdwHM=;
 b=bNkMOXtmbCrBN0qTcfRUluqXS61n0rjd6PQ0Q9cT2+/yj0dkYCsPY0rzifmK9rGvet
 27qAfuokSNZ3lthzgeWbGe989H58NTahtpEtyEj1pkhW5nWlKffHGIVVx8Dkj/tbTedD
 YQGujw95dAiVFcU7WCD2hOHcZeV3+6s07oAbVAXV1ElpE1yYYuEbz804eeyY225LdQ0y
 dQSO5L+EfWK2JLKpki7sjCFPScIGSZS6erO/ImSuf5Y4eabTXRsv5ngi1sapKqauJmPy
 V8RdgKJca58RxhMENsRTAP0RM9F9PPByreJBvKL8ASOF2KBtRhSL8NPEbzM788eusVbG
 hl1Q==
X-Gm-Message-State: AOAM5337OSpLSFBAIx5jkBCDxmSQWap6qx+BvITMKGEmUJWEQt0u+jt+
 vLwTFywq50MyPW4rIsnP+nu9wVGBGia0Q4rhkLPnGqEbJjv63KkIGZP9Kg6LMPN8wpadyaXg+7P
 ImaSIhXwlzA/kzMxp0xm/fhQc7jGbXcM9wSqUCAgjqziq2vwAD65jdL4Ho1tJKTuJBxC61+9jMX
 9+eVeoW0g=
X-Google-Smtp-Source: ABdhPJxYZ/AG6IdrENotBMq3aJhMKQrFgwmjP7QyT/mAFfxW35qv87Qxv4h58y0KmK0tSWJua1/5EvF4eGi7hsDlkA==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:6122:50e:: with SMTP id
 x14mr1339573vko.7.1640096913683; Tue, 21 Dec 2021 06:28:33 -0800 (PST)
Date: Tue, 21 Dec 2021 06:28:28 -0800
Message-Id: <20211221142829.4123631-1-zhangkelvin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v1 1/2] Add some comments about const-ness around iterate API
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

Change-Id: I297a56ba14a37ef5eced95330a5b09109378ca44
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
2.34.1.307.g9b7440fafd-goog

