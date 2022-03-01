Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F454C81F9
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 05:10:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K73hH5vr8z3bmP
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 15:10:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1646107855;
	bh=b7afmnSTT0v0CCVJJPCoTsIqU8i3KZE9sRR0NQh5Rp8=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=OlcL9bff+OQ+M8ZlAoweLJzkVCY83SAhCHsAvpp+r8ct5qx8hRScauuWhjXvpwzfc
	 kSAoy7bCUJ5fNsB83LnxgU7wC2Xz5JVFiR0wEt9dcPT6ufkMjqTy97yLiuAl/x7UIf
	 TbvD0ujbJ08RiNuX1Ip/aVYSQZ28pFoV3B7E+SZ8n9UUwz3V0kRktZlMoqTm2ODjxv
	 6NVAkguEIPeXfWjkwaUU6/tgQPa1+2cKzhmtzksw9aMnM1mgbSjCnn0BRTmY3ZHFYR
	 m8cVrlyO6JgJvi+EPwQP0mpLunNysNMDokE52qWBxQPMX3OkTLkQ6ZHnfDipMPAE9a
	 IcIc81KwDABjA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--dvander.bounces.google.com
 (client-ip=2607:f8b0:4864:20::94a; helo=mail-ua1-x94a.google.com;
 envelope-from=3xjwdygckc4ssap2st6v33v0t.r310x29c-t63u70x787.3e0pq7.36v@flex--dvander.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=eXZEoaGx; dkim-atps=neutral
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com
 [IPv6:2607:f8b0:4864:20::94a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K73h95GkVz3bdP
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Mar 2022 15:10:47 +1100 (AEDT)
Received: by mail-ua1-x94a.google.com with SMTP id
 q20-20020ab02654000000b00342cd7ac756so7395139uao.22
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Feb 2022 20:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=b7afmnSTT0v0CCVJJPCoTsIqU8i3KZE9sRR0NQh5Rp8=;
 b=pDGPIgERNAn18PGYcvWU+X50DVE9jEFI2Zp4rktUaJo5gBEDQsuh5TYnoXfFXq8y9s
 s9/rtPN3Snm2OnTT/NiIUWbnLNb7tEgDQd3ggdw6gb0paALAlRvjE3dLHYFncSJtlsR9
 VgDmWB8RD9IEMPN8MDjXQ2D+vSWh38AKx/2IeBJYsDXplrkBhiS5yCor8GaDppqeqs2R
 AoSJqk1PS1BNdTQgY9L3VctBPB2N7rmT93+KRVRCJfS9ZQ5OGODDhrKcZx59h98lzoP8
 XFkOO6UC7vbKJgDKRawuW3iKu+HlOFRA/S3fDr8V4LidFnMwZ0UnXvEKV2y79eAx9cJz
 Dr6Q==
X-Gm-Message-State: AOAM531YlDiVLZBJZFkQej1OUk6DDmOlhrzem5jKx9/ZGEPiSdTYTh+q
 FJZEYVzm20QnF4RS/pPn5gEnXiqXjv5zPNKbCdIvPYwPAsQ+HdPPHqgBOvOxQG1onPKJ0We8k3i
 sulkwcGluoIvNuUMrMaFgFiX3/6WufbohmxjRKd6nQu3/EwWTZbw8M4obUlhZQo0cfMZ/mEmY
X-Google-Smtp-Source: ABdhPJwUa8beXwwDaF6stTLoKd6S7YhZginIlepgUlSVoMD+fFD4x4wTrAbvLfX+ezJH+Pdc97MTSErpTVq3
X-Received: from dvandertop.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:2862])
 (user=dvander job=sendgmr) by 2002:a9f:3089:0:b0:33c:5975:30db with SMTP id
 j9-20020a9f3089000000b0033c597530dbmr8631440uab.70.1646107844744; Mon, 28 Feb
 2022 20:10:44 -0800 (PST)
Date: Tue,  1 Mar 2022 04:10:37 +0000
Message-Id: <20220301041037.2271718-1-dvander@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] erofs-utils: mkfs: Use extended inodes when ctime is set
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
From: David Anderson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: David Anderson <dvander@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently ctime is effectively ignored because most inodes are compact.
If ctime was set, and it's different from the build time, then extended
inodes should be used instead.

To guarantee that timestamps do not cause extended inodes, a fixed
timestamp should be used (-T).

Change-Id: I3d2e5c5ffe2bdcabea6791b5def5973b507aa316
Signed-off-by: David Anderson <dvander@google.com>
---
 lib/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/inode.c b/lib/inode.c
index f0a71a8..6f36c09 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -730,6 +730,10 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 		return true;
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
+	if (inode->i_ctime != sbi.build_time ||
+	    inode->i_ctime_nsec != sbi.build_time_nsec) {
+		return true;
+	}
 	return false;
 }
 
-- 
2.35.1.574.g5d30c73bfb-goog

