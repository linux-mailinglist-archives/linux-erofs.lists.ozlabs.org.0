Return-Path: <linux-erofs+bounces-2746-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIAyIo3it2lDWwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2746-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:59:25 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A337A2985D6
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:59:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZBtL1h5Kz2xlm;
	Mon, 16 Mar 2026 21:59:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773658762;
	cv=none; b=VCZXw4PSt9LyKg8skAX+FaxGp+B7c6c5uob94s6eA7dU4+82ajBIMcHacUKJxIkMgZdiK45PGSdRa4JnDusk1Z9n1W3K4e/Y4Uy9lxKfhWeIu7or+kuiGqOdXc9/CQyKAP5rPwe8RShhmbigHh2uxc7y0ia3d0WLl49buFvYpvr0jqPBUyDmEg+a3SZ+PIr1sy0ekMvPS7PrcKKKsbfcKPxO1vi1OPUQYGyNU0U/Hbud7JvHQirfLGnuyjLKw7KSBA7LafiBxwzkmadYfE5g4+BayLgTTU+LMFedfxbTQKpiHsFcrSuybKw2xXppz8NcWXh620VSI1aycO35c2xh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773658762; c=relaxed/relaxed;
	bh=zjOddJ/nz+u8a+mjeIahu0rYEzdc4gZqD5383f8b6AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPctkASBix4OLhJIRDqIydLFiCrJkJnWw0jJvM64i3soLIXA4PHoQmB7zN7COmA/pp3QUV6E7J8ycOEACkwTG7C6HYwkxQd0uU4gko1Z5up4z+Iee9bi96IsP8ToLxqc4xtQf245lOLm7j9w2lErYpnZqOILQh8OfDdnytGKtQ+dSQHh0FR/uaNYbsGRRBMgUO5gvI4+PkKZXhcpFjwX6zIKoaUEFM5fHg8l34Tv0orKsBYF6S4IZTfTfNuh6BdOcDxf9Oul3d3ZFL2pGnfOqe2WQmlX5wDTW3zm+0N6k53AgRAbfmyRvNR3lPfIuFEUj7q/XRenlBVpAZbEAtpHOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O2/C4xFm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O2/C4xFm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZBtK3mXqz2xS3
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:59:20 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-35b9fb3f57eso318039a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773658759; x=1774263559; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjOddJ/nz+u8a+mjeIahu0rYEzdc4gZqD5383f8b6AY=;
        b=O2/C4xFm3/mGUl0Fjti1CwCWJnUSxVrvJoYJeAsEiLUp7fdsKx/BLoKEUpkDqpxHWO
         6DEhDiOT0CyH8bjX0lOC40skULolAdXuDlvFAtbfNmB0FBUSkT7M3yQQk5DxtPSJM4hD
         9m8/mC7sjDD7HZ4iWEogs+iCsTn47RYWqRpqd2qSRj1buPPNuG2tnLSRhwE13nif2NJD
         g3D+0Wim1AUs18DADSkraLjXm3OYc8nN/zDckaO5dPhJ2f+/kqnVURTZPQeAXGbRfW9c
         oy9xT7RdNGCQO0AXoHt5YU848KFSe9v0+0ILGVlnkFVJuKiLmihv9PsnTt8uRSc628zr
         6IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658759; x=1774263559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zjOddJ/nz+u8a+mjeIahu0rYEzdc4gZqD5383f8b6AY=;
        b=FN2/Y8JLgebWVOml/aF5UlQ567Gfq7e5S3k/9QGB6Y9uuTDLElJ5hpjm1OQzyIU7Gc
         HfMR+RTfU/7uo14gygJ39cBZLc4itxKFIHUgdY6LYctO/Kpj+TANTvbKOaqGRlHDImyM
         CFbf2wKTWM1K0mNzeoVyPPqVFVsj0nFEAOjx7toXgHv5c+ousfY+FR9+x0tYL1DC2OWG
         a2zTRdZbWc0Av8xPF44s0KnLiqVODPEii5OmUdzbQ1EDjUAa1eX6fU7f6Z91lk44VYWj
         xbBrDNyCPKs87a73yLRy9QTzTGQsjWaeWxDaTVljJmu4GBiWRAqPVqN8lY4dU6BS3tN8
         jYMg==
X-Gm-Message-State: AOJu0YxQAljqOGLNAVZc5d9I6OR1cxU6cAnqpCW4Wp9OLCFuKaovhWry
	ZAFoXHNzpphiCMhUCDk8e98RJUhHpQajjmnJrePYOmlqX+e3j6mPDCCH9Nhmw3T+Yp4=
X-Gm-Gg: ATEYQzy7ASufssBCYZpsn0b96jtLsESZfbauQYjn2XN0dAULSs5uD/BsULmfSH9t6vu
	QgwNxhfR+Ixkxd/4KpALCGIf0HSlVjiTBVzA7KVdQGcH8SYrLr+AaniCtzr9peeNmkdITP6ULEA
	LQ2SZfUq/hXSoM7chKXMbJoR1AM300henPU3w3Uau6EQ4dgO85Vp+CL+sCLX8S8UceajHoKiWy4
	JMZHaaSd41FmNcDTAZ1faCBVo+2hPAiWDQSQtARJ3Wz2dDgy4qLEwHjkRzCq6O+4PBGswFX+Lno
	c6HOFVi9QUWJEb8TXRQ0wEqjmlceUU9EPKAZxLDAASvQH2FVIUvpRwi1zdx8zz7srPq1+KAUN5W
	FU2WSHFdPyG1qUjzBEFLeO8FuMRwcG6ZXNCjpFSEfGdhiIgTaifq64MGLhYx1BmL7de8vwWAC8C
	s1KXE/JmnIbxud1Wy2nHqBG0j+n73XeaCvE/W0gAIcV0oUrorqsgQ=
X-Received: by 2002:a17:90b:1641:b0:356:7b41:d348 with SMTP id 98e67ed59e1d1-35a21fd6c69mr10376776a91.20.1773658758625;
        Mon, 16 Mar 2026 03:59:18 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb7f2basm8265486a12.29.2026.03.16.03.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:59:18 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v3 0/2] erofs-utils: minor cleanups and enhancements
Date: Mon, 16 Mar 2026 16:29:09 +0530
Message-ID: <20260316105911.5571-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306085717.12776-1-nithurshen.dev@gmail.com>
References: <20260306085717.12776-1-nithurshen.dev@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2746-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A337A2985D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series fixes a redundant logic branch in dump.erofs and adds
a warning for unsupported file types in fsck.erofs.

Changes since v2:
 - Removed unrelated patches that were accidentally included in the 
   v2 submission.
 - No changes to the logic of the two patches in this series.

Changes since v1:
 - Rewrapped commit messages to 72 characters per line.

Nithurshen (2):
  erofs-utils: dump: remove redundant conditional branch in filesize
    distribution
  erofs-utils: fsck: add warning for unsupported file types during
    extraction

 dump/main.c | 3 ---
 fsck/main.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.51.0


