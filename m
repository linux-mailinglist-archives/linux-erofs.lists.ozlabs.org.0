Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B23479E148F
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 08:45:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733211950;
	bh=EOWEfzvF8BjNRtXspH5PP7JyMv1ZiT9CTaBHiMWfkos=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ClZ9EL7qaHP03x1dq5yZ9bJxTwye1CgrhKtYcnf8VYcBu21IgRhzghz5ZkQbkBzH4
	 YNlyk4yEfAgbKSIlssi7AimGmr7kSCLWhiYJVTSZRqrUNUGmEaE+ScdRNpAl7b0AAy
	 qKhEZaz7JlUpM7hFLtvSz3Ms676YpgGr0PkSYyf8vNIC0hFcn3r3RQian2sMPgiZlC
	 0Plx9PTCqO0i1nVJVmvDJ56SMJm3dUXFymOHrPwLQO320GRJbJkrL0YYCLrZGzYBRe
	 bNec5qYwBw6hbUfHvbrCMKSkyFwIpv5dihO7AMqGHUBvx3PVsbObFZrLdBiT0pKkTw
	 5xpfAE3wHvtOQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2Xl242Z8z302W
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 18:45:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733211949;
	cv=none; b=m7GFD3eCUYayeVJziSptR4YgasYF4VTQu8SviaNE/x92YMJ/iFJzPJCL4ek/FPK6uMupR/nz7PDJtRuMmNm1Sc2jPUl7cVACof8nCtVa50NQ40AhhZNVvILN8deAyEySCb1NsUUooMscZ7vo/mbzB0/2v4HruU54HsylH7pcNVqj5UO3dhDZxs+xUNjiqG0WGna1brnQZyBRMG3LhZO515v1z8lc7UWIbEkJetU4LUYUVELOMjQP2wbAhu0+9LkwJo2j355UPafX8y8gYsudNwDicKsnJtwk8kr0Qe9PvHciJcMefu1RRZN8VKmSmiOL4M1OiJWywqre3DiED7A3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733211949; c=relaxed/relaxed;
	bh=EOWEfzvF8BjNRtXspH5PP7JyMv1ZiT9CTaBHiMWfkos=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M98VLbUa/e/l5uIdmN626nh4iz7RdUMUfg5qXhKN1g2Ns+N1Ca5XFesMSZpHS5Mq3cr5vdWdYpKUYXbg63c+iI1TisUVblhJwyCzj4bW/Gcs0NCir4W8hIUbZSU++/SB6vk+p5muT/hsVre4OSy0T/ieCpY3kba9xPDDrmPyMgbQNqECqebPyp/9CbiJGobv7Lgli3yOM9ofY/V6nojhg/HvHNf+te2pbR7ROmlIJy4wiHXKGVkSnyiDJjj9Fq9uOhEdpwhGnqautM9LPB5LJGSPfDpoy22YZ9CupqbDC1OD77aJ56oA3X/6bjEkwXqmT+YZG0JgCvcYasAdFSJSNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=2MbpfX7+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3jbdozwckcxaz44ea3ww44w1u.s421y3ad-u74v81y898.4f1qr8.47w@flex--jooyung.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--jooyung.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=2MbpfX7+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--jooyung.bounces.google.com (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3jbdozwckcxaz44ea3ww44w1u.s421y3ad-u74v81y898.4f1qr8.47w@flex--jooyung.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2Xky5k06z2yNP
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 18:45:45 +1100 (AEDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-7254237c888so4826877b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Dec 2024 23:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733211942; x=1733816742; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EOWEfzvF8BjNRtXspH5PP7JyMv1ZiT9CTaBHiMWfkos=;
        b=2MbpfX7+0mFVhWoJMi9a8YdAwj+Of+3E3vUI2K6qNHrSnobUVxhiWapW4xjOYGLhzU
         nqtJuWik49xrkcBNP2GcK54HwxM5A/6rnxmKDJIHkQQM3Oq94agsrtZeVo1e3oFZhfQA
         ySIP/5tDDPl2uzBuNg0mxog/nMH/4IVplXfOUj9pu2BhL14OVUUS6C+vJkgKFUTYWpf7
         lfLoDGa9h6CTN4dA5U2heh8EXia25Y77+aghNB8xLcFbTai/58xirBiUUNQEqwJ6vRG3
         8yqMaE8AEiWcVtqvVXaUrF4Jq9Cl/IqREEGWFhef5FbaadwxsagbVgMcz/s5y239wgjC
         JnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211942; x=1733816742;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOWEfzvF8BjNRtXspH5PP7JyMv1ZiT9CTaBHiMWfkos=;
        b=O6bx2ZIr3dlMoUKUPTgpgX6k8xyCeYBSV/uaSKQgF7j0IChTa51kaYch4uDXoGZBG8
         XBJU3OEzDuonJaEWSuu3nvmfq+DJ5RmnhmykEaClP88Vx+/Z//ObI//Aph0WMGZX45r7
         7ur3bRjXabF7Vn+a4kFkxv4xTfpK/LosjrNcWfhPj4bsr2GrKzE3sl+7jckm89kqVusl
         eWH9jt/sArl7czXhRG0atK7LHws2WehsYxVdBWRtpa7k1azNJBw/v/i7LC3qlmrUzmdx
         Vh9qa9HgxzA4VhfA9/GhUkFcgqxC8FIWbd72lchWD71fuW8kzxr88hsr8b11pGvXtWL7
         YRFw==
X-Gm-Message-State: AOJu0YzBpAKXaJpo9d4QimmW5YRomrCK6JXJpEDSS5qb33d8cV2y0ll/
	7OFmZg4eGecpSq/DJSbjIcHTOBrr5rkd/xuEVYSZjgf3hG+h5tOY4ES3s4rhsTx8tmo0xy2iPxN
	ap6Ultj2h9cDVID7+Nn5+h4/20zKyFO3uVHu2UpK5a02LVsjEQy0DU9Rk4QwRmfjqJtkzEaH7jA
	6xVZ7jd8tdv1upGNQWr7CTMeswhDOPYuzM3s1P2Ch2FBAQ/Q==
X-Google-Smtp-Source: AGHT+IGsvaE9AiSQJh9K9Q1bGiX8oxgKUfbdSzTWqhZTMZT4n/fYwRYsXfGywFLVjQwDRcKfuahc2jOXyf+5
X-Received: from plez16.prod.google.com ([2002:a17:902:ccd0:b0:215:8dd3:abd0])
 (user=jooyung job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea07:b0:215:2ecf:92ac
 with SMTP id d9443c01a7336-215bd111e0fmr17406745ad.30.1733211941911; Mon, 02
 Dec 2024 23:45:41 -0800 (PST)
Date: Tue,  3 Dec 2024 16:45:31 +0900
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203074531.3728133-1-jooyung@google.com>
Subject: [PATCH] erofs-utils: mkfs: make output stable
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Jooyung Han via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jooyung Han <jooyung@google.com>
Cc: hsiangkao@linux.alibaba.com, Jooyung Han <jooyung@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The iteration order of opendir/readdir depends on filesystem
implementation. Initializng inode->i_ino[0] in the loop causes the
output unstable even though the entries are sorted in
erofs_prepare_dir_file().

In this change,  inode->i_ino[0] is initialized in
erofs_prepare_inode_buffer() instead to make the output stable. (not
affected by readdir())

Test: mkfs.erofs ... inputdir(ext3)
Test: mkfs.erofs ... inputdir(tmpfs)
  # should generate the same output
Change-Id: I41bb8d5487a77b83dfa69d3d085e38223ab17f87
Signed-off-by: Jooyung Han <jooyung@google.com>
---
 lib/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/inode.c b/lib/inode.c
index e2888a4..7e5c581 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -821,6 +821,7 @@ noinline:
 	bh->fsprivate = erofs_igrab(inode);
 	bh->op = &erofs_write_inode_bhops;
 	inode->bh = bh;
+	inode->i_ino[0] = ++inode->sbi->inos;  /* inode serial number */
 	return 0;
 }
 
@@ -1114,7 +1115,6 @@ struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi)
 		return ERR_PTR(-ENOMEM);
 
 	inode->sbi = sbi;
-	inode->i_ino[0] = sbi->inos++;	/* inode serial number */
 	inode->i_count = 1;
 	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 
-- 
2.47.0.338.g60cca15819-goog

