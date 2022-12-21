Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C6E652E15
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Dec 2022 09:49:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NcRv73YBHz3c63
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Dec 2022 19:49:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=IVvQuMqO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=IVvQuMqO;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NcRtz0RXmz2xHH
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Dec 2022 19:48:58 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so1528235pjj.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 21 Dec 2022 00:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lt+Sd6EcIu7GPJkueUhUrq7DKSFn+eyAltb4vFMz4U=;
        b=IVvQuMqO87THkbiZK395LfTvRuNYrZkc77qHVgYVGxXMk+Z4/Rc4afAKPIfliZAqGF
         /gBijXgqpl4TbmgRZSLNKteo7yODI2kqrAhFVp5cwaBvQfbjl+s80AkDrLkL0Ytp40Qa
         duFSmPH8SPgxX4X/MKCcLmRchpO2mTLv+GG4Jd8assdTdxL7Lkr0U/b9H07FaWMOutgW
         vhCk/ryvcSUchpewrTOTeG0Z9FQAFIkFQd69uLa0CTxpNWnnWY6+/lW0xUwFA1xdPGIH
         EIam6x4SAtxq0Tv5iESG7Osg8KmvZ0Z3z5Kn7bzSe0UtOUBRQPgHqgwOxFOfh4sSgEBO
         hk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lt+Sd6EcIu7GPJkueUhUrq7DKSFn+eyAltb4vFMz4U=;
        b=5MNGBfxyDo3OWMGTyz2cbOgvtDn+LA/O17boB2MXIKSI3n5xXyBjaKxbl7a1EC71Nm
         7y3oXY4vR2T8FkiYQmwgERvXCMe+F8h8238HnfMuvzuQlsdfP4JVNgvjxbg1kPchM+Bt
         m9qZPiMZXJP3E1/4rW/ItigSWgFi8tcYgOTduwvw81zpCvfxqRvG0sO7Hohxt3hTx82y
         RxjajHAVsxZappEvo/EEUl4vwryozv9yq+DRyPFdBZt0g3kYJUo9r0oBSmjaPRbdyxDU
         xTo3hLQ5k+9WtOPgseHy64QS5K2YxWrgqRY4rS0zB/qmEPmpKaq/dNS5XXuTgXOOWLbz
         Qrig==
X-Gm-Message-State: AFqh2kqL10FmBIlN6Hpan9udkeD0wu8DV9Niku2GUx8i+UqAtH2ojnU+
	71PHhiI51HqkhwGS9VMc2Sw4ZJ82qCI=
X-Google-Smtp-Source: AMrXdXttBQq1iF56hrW3c7d+GQZba5avQCW9XVOhyMH9+YcsJnbb2y7TyM6u72IQVxSrpt5bSzzF6g==
X-Received: by 2002:a17:902:6805:b0:191:1545:a652 with SMTP id h5-20020a170902680500b001911545a652mr616572plk.31.1671612534657;
        Wed, 21 Dec 2022 00:48:54 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709027e4b00b00189a7fbfd44sm10769548pln.211.2022.12.21.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 00:48:54 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fsck: support interlaced uncompressed pcluster
Date: Wed, 21 Dec 2022 16:48:42 +0800
Message-Id: <20221221084842.28196-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Support uncompressed data layout with on-disk interlaced offset in
compression mode for fsck.erofs.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2: remove if and use ternary expression instead

 fsck/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index 410e756..2a9c501 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -458,6 +458,9 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 				.in = raw,
 				.out = buffer,
 				.decodedskip = 0,
+				.interlaced_offset =
+					map.m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
+						erofs_blkoff(map.m_la) : 0,
 				.inputsize = map.m_plen,
 				.decodedlength = map.m_llen,
 				.alg = map.m_algorithmformat,
-- 
2.17.1

