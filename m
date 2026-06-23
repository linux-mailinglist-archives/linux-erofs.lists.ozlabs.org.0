Return-Path: <linux-erofs+bounces-3732-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n6vjCcj/OWqWzwcAu9opvQ
	(envelope-from <linux-erofs+bounces-3732-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 05:38:48 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7A96B3D95
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 05:38:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eXm4+rOd;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3732-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3732-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkrQD1ST3z2y71;
	Tue, 23 Jun 2026 13:38:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782185924;
	cv=none; b=ICbBiJMRh07ItWdJ6ZOc31EvGnYkRjv/dyuTSax9JOLQWRGnL96JpuAUBMb7kL7jkJIVCVTWEpRFdQDi0g+jKXAs1wj8BuwUhQvt2DK5dYb9orItoQxx2vn5ubFrzp922tjS3HTsY3Y3nTepW5BhbnyvZiHg/u9ypU6rdWPKHnizz/aCCPZZaZJjM/NG6NyrI7OMUNKND1BxPs6J2To7KyfqVKSFulyFW7E3iIQRCbPAkReik59UdCF+SUdxqVPq19majCS7+Yy44JRGu1U2hvqxL9cYsYgpYoD2BgXpTxuKt8vsBDTnMFBeVQdiBR+OPYoVmXskQ9DCmq8NDV52RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782185924; c=relaxed/relaxed;
	bh=O9d78UVCpBJjLWE6ysCdQG0jwN+BvnKqjUMmDtzZo9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtRot/wbxXPbp528fJ7f9n42CIHdutJTvYPQJ9Pa8OrUoonPOFsIlKqnhwOiRYPt+QKbcEjCzj0TFfgjcgxup77wencBggKi87VgIeasGbp/ZQ9NdLPIPnk4mBkN5OtZgziypGOGZ9TJDYQ/cFpm1bj3t1S5U0puPLX4YvzJsM5f+7JER3jdamVBRN3oJ6U2dGV5p8iTWEnxFk/SSZpVzWua8mnr1EkZVvD3tzIy60jMnRVBP2uLDWG1X+njrSMsuk2BS1fAE3RRhCSogiLP0gxrfhARqY0Lbp/bvF0VWsqybevkO+b9AMGmmNu66HFVYo8XYxNh9FA/ukwdVYexcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eXm4+rOd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkrQC0k9sz2xwP
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 13:38:42 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-84594492c26so297828b3a.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 20:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782185920; x=1782790720; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9d78UVCpBJjLWE6ysCdQG0jwN+BvnKqjUMmDtzZo9E=;
        b=eXm4+rOdvl5uXxcCfdDKCvZGiUR33Nfze9n3ZfhPYH4isQ5gRzmYvUA18ODJ0ZnLe/
         ql3vJGKGehWlrg8LCdWco75PNjG4+bOB/Q29s7Bj8mPs1FTbU5i/zc/lZ0PULii/59Ev
         7r3f2OTLGKlVJ/HpucwXOLOm/SFISFsb+dY6/lO898eMtvz2iPw/QQ5FjccQOhKs1q+x
         pu0biIuytKe5PJiEE/7CUGgpLm6yYXYltvBhBqmK72wSrNwlNIuy9vf4aBDpzJOzAAlG
         snAZ5+N+YSstVZyICScAZnJyxNOiqhd9C4WN2qCKDV+Rfwo6QqnxWFG5yRCoqKj1ajsI
         N/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782185920; x=1782790720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O9d78UVCpBJjLWE6ysCdQG0jwN+BvnKqjUMmDtzZo9E=;
        b=qZ6fpxSDSnJXXmcaK9oc+U4xtMiR1fpwClJSAJ1TPQ2e/F1DDR5OeaJCk+3USMOB13
         vESSv70Hbrh3Ir+qlTVNlpZHfldLzUz4+XT5Hwjt7sKgt/jXufnQaUNMkv4K1M45TO3R
         pwd3uUtU8o7itgWm4+8lj5y1lIsMJF7QYg9n4BTaorEtG4qeg3mbzdE0yuamCNE4ZvVW
         UeUuxetKabfhyrOL+RHdgZNZ4nr59FQdW57ZOKwbu608bPnFSQBjFnOtA6SpNO0Ijjol
         WdnmC7SEgmlLYiCOqRF3+V8Vh/meM3WIqgxbvNCFhD75yBW2ssVKUu+NCobOWPFujq/H
         /WpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QT8jhiQ0Tfdb5xSIHO9YS8KIdxi599eFrG0wXQBNBqTQ3JZF/y8oMmChI2lBJm3ILXiaZPAIXbokgyg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwDN4cR4/8XSOxOjsVwsa94KFmpXMDgc/kxBs/4woIwlenlzvbu
	Zehr668EQQ7zYqM7n0jDrpiRHzhC68BIourmEwfwh9JrtgNV/iwdeC7R
X-Gm-Gg: AfdE7cmUMVC5HueZJAKq3Zepix2qpL0yFiQMQBGfLTWIIeisLgMRz+f7PaENsLG+020
	XfMFA6voCx+YX/tml/22IDD8XBKX7AMfMJvABOp9x0N85jY/X++qqzFa484N8uRs4v7i5KPxhS4
	WrRdje5NUTC2P2G6p2p4o0PpsJqOx2q3zZ9/kwxWMcQhhMgIDNyTPlP18ixc39nBSI3ENkJI8KW
	vmzrNcDHrI0g/pyVTlLpMnGXYkOtyFJ0YqLfkp9S3O87tAwOgwllD3ez1QzUCg5myroEJpEx4Ho
	YLv6tt90M663GOL55A3xX0Lz7csrBW1SMYROw4JD2UmNTSQG9LphP6+5k85fJESlMAocu3Jftue
	k6PnxcnXkP9pCCKQh5PHYWLb5zVvEASEysCxKKNe80EQQzIQFz12330rNJzn9UZVCPHbkygMHBC
	K/UqsJf9C/Y+Qkj6IR1LVpel8=
X-Received: by 2002:a05:6a00:3d0e:b0:845:4ac9:4289 with SMTP id d2e1a72fcca58-84595235596mr1266683b3a.15.1782185920058;
        Mon, 22 Jun 2026 20:38:40 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e74727sm9042622b3a.39.2026.06.22.20.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 20:38:39 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jianan Huang <jnhuang95@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: Re: erofs: is z_erofs_put_pcluster()'s sbi access in the same UAF window as 1aee05e814d2?
Date: Tue, 23 Jun 2026 11:38:33 +0800
Message-ID: <20260623033833.3440803-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a5230f86-74af-4fab-8806-a118a0cf3a98@linux.alibaba.com>
References: <a5230f86-74af-4fab-8806-a118a0cf3a98@linux.alibaba.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3732-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.ozlabs.org,vger.kernel.org,xiaomi.com];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:chao@kernel.org,m:jnhuang95@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng1024@gmail.com,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB7A96B3D95

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

On 2026/6/23, Gao Xiang wrote:
> In short, I saw some similar report from LLMs, but I think
> erofs_shrinker_unregister() should block this from kfree(sbi)
> by design.

Right, that's the part I'd missed: erofs_shrinker_unregister() drains
sbi->managed_pslots (while (!xa_empty(...)) z_erofs_shrink_scan()) in
->put_super before erofs_sb_free(), so the in-flight pcluster keeps sbi
pinned across z_erofs_put_pcluster(). Thanks for the clarification.

  Zhan Xusheng

