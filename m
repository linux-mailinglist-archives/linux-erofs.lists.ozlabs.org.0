Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC74A97A332
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495004;
	bh=wrfeI6c5Fy2/wr4QW/RT84D3Z/gYFwXLPq/0MCJKzS4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TGcj9G3icOiq/AHxFCA9fRiMeztaovMx56Gilf1C4IisW1jE1f3fc7zNO6VDOS2zA
	 /sjhVraNWRpDAWn+trVn9tEiOwci5trELQV+S+DvOjbxtd0Ves95/mPvLvfDdA4GPX
	 qgL6pinawK/C+6cc+5HUn3mRsnc5QloUw7dx3UiXo5/Oc2/9gIE2KdGiJDSeY3CSak
	 lUmeBwC5E9LkE5C2kwRHGSiZFiB9GNXsgq9RZuTXKcAvi0QNIekILNgUM0P2HieTzB
	 KufHH3eh47yoMuGP1GvV76tV20uRjvjH0ov+s0L02st7hPIf1oOpw6vfEl9oMNPz5s
	 NfW4ZEgpVoHcg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mg06KVhz3089
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495003;
	cv=none; b=XiAxK7O438IQ4E9YyIWZObCUD3zov6opXUl8ciuShhbSYA/4vwHqeX9r7lUZhgZZQ7OuV5kIvFUX5RjKVWh+wdkfS8d/jXDQNZCWaf/TUrzGL32U60qD2uXV5bRg8zusztDhWWw0njDlaA7DDkdCc6ml1sPrLj08W6vGQrqpi/8Ra5JWguhjzdQRcOOAbdRmhoyHlSRSCpv3KWlgAjMjpuWvzzl/uTvxlCmleGnFRSun/l8QnEBHpPN9iVchSsY/BA3rsbGn4qKfyoVT3Le5a/rZpWOr2+Zf80btVhkF2fvrMb10V+MxTQICt3OWn/GwA7ZWmIodPxztqX/IqxAsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495003; c=relaxed/relaxed;
	bh=wrfeI6c5Fy2/wr4QW/RT84D3Z/gYFwXLPq/0MCJKzS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZ9dbYeBFtVCnsB9Sr9uGqNMbbElorecgnpYLb88PSumIPXFg80Xn2HE+mtUzj7DPNz0VwocdZv2qLQH6jr2AkyOSf2Hpx7sCarGgEEYRlRUjFeMJLAwDoIsCEixf3Jyc60KBBiSrz9KtM7k7GDrbil8vnjTF/Z3Ac0mM8rG+B2M/hI4VTu5wghCfSicNIxyJXu8BmjaYrFOcbJPQBUQS/kzKGiDlg1ziLkAG2TFl8jSZA1xOP394vp5XcS5ynn0IMpDqxgzH61RxfJW9bvIJsHRkCZ7m7Cm5Jslo/pd/X4XWbBE1uOnsJ9jpWmZsFSVBXg2uY9o3NkmRbH7lnz7bA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=b/wTow6m; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=b/wTow6m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfz18Jyz2yVv
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:43 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B2F069839;
	Mon, 16 Sep 2024 09:56:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495000; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wrfeI6c5Fy2/wr4QW/RT84D3Z/gYFwXLPq/0MCJKzS4=;
	b=b/wTow6mW0pOJ3SLs4zdqnSvHOdwRM0/wdgLDvfxyE4lsB8GyguL7sAgA+xYYDLNTmQihH
	7ygxxN4fyFCXoJ+tUXTs4fVSdbyr0AqIv60ObsXlONL5RpEblVyzOlurHAcuGYpXMIPBnF
	XO/4Gk/f1Ptz3jGeS+dkc0aoqHc1RGiNYM6z5Tesui+jAGQLiGFs3Y+EHQCBSnq88FHD4c
	oOxVuvXQwUMfkOK3DTv4FbdHv+Cxmzv+c/7abQbrqbHDAbqRSglrwuRcUJwWO/Gi5S6GFT
	wzL8ysO2z7HjFBxJOG4sRxcCPECdkMxop4zKibbhekbjBeCxhuqNcLH9oGGRNw==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 01/24] erofs: lift up erofs_fill_inode to global
Date: Mon, 16 Sep 2024 21:56:11 +0800
Message-ID: <20240916135634.98554-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916135634.98554-1-toolmanp@tlmp.cc>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Lift up erofs_fill_inode as a global symbol so that
rust_helpers can use it for better compatibility.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode.c    | 2 +-
 fs/erofs/internal.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index db29190656eb..d2fd51fcebd2 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -196,7 +196,7 @@ static int erofs_read_inode(struct inode *inode)
 	return err;
 }
 
-static int erofs_fill_inode(struct inode *inode)
+int erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	int err;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..8674a4cb9d39 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -416,6 +416,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
 void erofs_onlinefolio_init(struct folio *folio);
 void erofs_onlinefolio_split(struct folio *folio);
 void erofs_onlinefolio_end(struct folio *folio, int err);
+int erofs_fill_inode(struct inode *inode);
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
-- 
2.46.0

