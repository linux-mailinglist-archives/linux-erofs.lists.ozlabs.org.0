Return-Path: <linux-erofs+bounces-3290-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4InbFIlL3mkzqAkAu9opvQ
	(envelope-from <linux-erofs+bounces-3290-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:13:29 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C73FAED9
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:13:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw5pq6BtCz2yVL;
	Wed, 15 Apr 2026 00:13:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776176003;
	cv=none; b=C1IB5mvZFvCN1gar/b6m0jIvDN8Ow9DiFLtzqDe845LQKzkRjRtcB6QCubg6v63qEfscTixi6Me1A9aCPTEPaIMlnMv4FzJHgSNqp48e2+ZSkzeaXbqLBeqySzw9It8aVygzFvp9iT6Ds47sBFCcnjiF8yozh6NV317rWx+JHuV6HU9woQjnmRgNEYCNxWNFq+/O25pdX2Px52+OSetlah+nqs65U/Cvhm5wqMIGeGvLDSmnq8pnKToRf2SqQwqfscokmxp9hbBEdAIYoQzcbrm4UEt7k8sz411dlox4hM/NdgYG1ask76Hb3f87Ae+1Pmk/LvxH8m6rwkug7FL/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776176003; c=relaxed/relaxed;
	bh=B6HGGvv4JORa9tLFxWliP0QTKG797ZkEi9mO8VFTf3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIr40VwQiJ3pfD7iQVXDq1w1OwcjPO/nDjfyHKmCsy2X1J8xpIO2Exn16K8T+d1Q5b3AiJY4ic8dGPZtSj2uFSaYTlHtACVIPO1q84Xhe+YYbJIbsZ7E1ENjJGkZ20TiKGaisS62beUmaV2yV27kRIt8zpyliSiWjHfL5pDdYrcejKa3zhHxB0hdmJyhKXqPG/6D1z90xOtvnx2bQ4NnmZ7TggdoveIQEwL4MeNQs1wNXp8HHyEtIlBCi35vjloER+THFLsvAu/XL3aUljTy6ec4QFcImqwR5YbeGJ+iLamxDe4WNdc07+ptUXoTWcWOMYPoOVGZvEepGE3kccvvAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pNLD9WSG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pNLD9WSG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw5pp0qDzz2ySS
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 00:13:20 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so4678963a91.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 14 Apr 2026 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175999; x=1776780799; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6HGGvv4JORa9tLFxWliP0QTKG797ZkEi9mO8VFTf3E=;
        b=pNLD9WSG9KXgHcihg6e+h/NzMMawfXC3RzaLSERs5zNf3BAcGvCkHvJQ8NTHI+RSWv
         s07bHw1jx1OvjjKvwhCcXStQsInxM1DB2ZpzPdauEx/2MNQEtxr5U6AIvDtUC5fd+0JI
         aWa7HlZd06++KD6/zBF8M76hQ7tV4+qPn2sf8hM93dhSs/Thw0CxbJttbx9Pk0GNg7nX
         bh5ny3VWuVx6HvhUMjZ4tbxU3keu3BIF3g8z0LydZXpomP65qlxO/LGljb27xQjBnJ1Z
         Xrodu9gnTvfy0R/ZpY4mHK1E9SG6WHZ6uGrzAsdo3taUIWRNJXL2+wQWJjM2N0mRCqqC
         JH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175999; x=1776780799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6HGGvv4JORa9tLFxWliP0QTKG797ZkEi9mO8VFTf3E=;
        b=LlHNn5DnsCp5Ga1LL32bf17z48QTZEAt0xa80uung/XXAO3cgqs1qyXBkY+ewu0ebi
         sstxSj4VwLC79Aw4w+IKuj8klE75o9ABdbENy1rRRYCDTxivSZPtiYnRm9uSy8139V1s
         6k0YwoSBLwGC/WM4rNtJMmNw2068/QXU5ebjTJ3OgQwqHmYihUPnYmPt2lqkcDe4INod
         9fM3G+PzmPVvDB+/nLOD85/kghOuBBki1kjI/xTI+vmOlrsMWbA1ElN5PPidns/3IZmN
         BwEFTD839BIHRPrvqdLJJzzkWd6jU1jUAeJygECrsFZU3u+zj/m75v5Ng3b/hdDXOj+d
         KpjQ==
X-Gm-Message-State: AOJu0YyEZN/F9wAZlxQrL9Trm4kOjlx2PO+GQMdwE1rkjhsrZchjWU0j
	SY+cHrH1VozNkOuB4Lg+vUeE7MzdyDBkNIiLY4Lb5D0k8qVLz482gv/B
X-Gm-Gg: AeBDievfHqcLUUAkyz92Zp5eQyX8UQL4Ar/2hq9/LlCrG2CAp7Q9j+/tMB1QETpYoLW
	+Cf4SfO44XITpal7HqFo9hAkjhhVjxhCPEcqdi44P38uOyETBYwFKiLDw4JZVDP9f6QB5jhpCPu
	EWzgePoYXRU8ZpdUdVn7Jb7DHe40Rh5RPYchCn7u7L5USc+7TKgefvuUg7yfYOO2fOvF12xBHOi
	NjP1cc+B1DKho+1+VGN5l3q+BtA50LRH21Yhvv4oVu1FGQDu0pPyxPNLGSdaKY3hbsbNG2nyTa8
	OHkLCm2AqfK9vs8cmayw3M7M+/g/YCofBvfSWPDKO+ETbA7Nud1VrfcnmdCIMzaFZg5w5KlPGxc
	phxqlf4c2n99NGFs4lbgZ/x6CkyTJZ4ptFwtTw2+fS9QZ6lwQR/QwalaguW+tpEBwD+PgI99mwv
	xay8Xnb4OTxBO/D1pjQBqJcfbw0INAYdT7330IhTwlwxO1NKs=
X-Received: by 2002:a17:903:acf:b0:2ae:ce35:2686 with SMTP id d9443c01a7336-2b2d59393fcmr182873835ad.5.1776175998493;
        Tue, 14 Apr 2026 07:13:18 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b3a73747b8sm81197315ad.47.2026.04.14.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:13:17 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH erofs-utils 0/2] tar: fix parsing issues for pax and GNU extensions
Date: Tue, 14 Apr 2026 22:13:11 +0800
Message-ID: <20260414141313.46575-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3290-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 771C73FAED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes two issues in tar parsing:

- An out-of-bounds access when trimming PAX path entries
- Missing NULL pointer checks when handling GNU long name/link records

These issues can be triggered by malformed tar archives and may lead
to crashes. The fixes improve robustness when processing untrusted
inputs.

Zhan Xusheng (2):
  erofs-utils: tar: fix out-of-bounds access when trimming pax path
  erofs-utils: tar: add missing NULL checks for GNU long name/link

 lib/tar.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.43.0


