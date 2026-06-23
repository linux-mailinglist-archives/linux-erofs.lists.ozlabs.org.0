Return-Path: <linux-erofs+bounces-3725-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PCfUAGv0OWpxzQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3725-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 04:50:19 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5975D6B39D0
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 04:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=i0cbo0m3;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3725-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3725-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkqLF2m9rz2y71;
	Tue, 23 Jun 2026 12:50:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782183013;
	cv=none; b=SIAy5I3EwFfEMcqbB37ZI40nhjK25QBoH8q5Dga/Ank8iDasY/GR8+VVuTLaE+El28tO1wYrNxvuhq0U9ztmAbQzCoc+ExWOIbs+J7Z5QpSf9TO0H8b5SkoYFihr1DqYUNUX8t+UnKiC2/1hf8iT7nMf8D9OqWGmcFz/C4Yr+ySNAIONkMepB5LHa/lHmree5G/EPg6VnUkLjcsDqisCzhew6mooXUZTjfqyHa7Da5XOL754sJRYu6yVK05fIwXK3IHhF/33rvhaatcjLYPeGrWAcB5wK3/z3yVsIEpcR6hkjmD3MIa5Xs0tMBXaW3Y5t214HZk1jtqJAKHF/m+CCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782183013; c=relaxed/relaxed;
	bh=lr4xgVO18u2WbaGeP1+M4CIAnONQq7B3nOwFcr50zAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baM23O73GdNynSeqI52dx08f/1wvTv5teEBc0tevrGa78wdTyPrmqyVpFfVzt4YRB7yzHSUoqITa100FJl4Oglbp3kwKUDAgq/9h6b28aFs+YWhxYExFNIoc5IhOoNaFsSFis4bbkzVGUz8vsKItoDiOR63cfcpZiZifekxmDW37HJVYABv1HN0ZW3nvKieHXEKop8BSaQjr9Ix1aN3anfh5yNXdRRDvkAxkTtTUrdr/b/ZxOgzZaGPU9NUoOp5kFsm4mKQ4WDZF6rxrhuIsBijJCHE8stzEYr7LJTLeU4U8swZKfC+jJgt3zxprSGJ1cCseX/Dh8rgq1f/YMYFUyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0cbo0m3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkqLC4cNyz2xwP
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 12:50:10 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-8454c5a280aso261307b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 19:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782183003; x=1782787803; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lr4xgVO18u2WbaGeP1+M4CIAnONQq7B3nOwFcr50zAo=;
        b=i0cbo0m3YyY2eEP83KBgSVenSXZsm2KmHCvWW/jJsWQwLgL9ebVDKzN3FLaWEirE3H
         rPNq058+VazCeW+Gu+ko6nxeHDycd0A8SVtgmuR66xgLmsnyeL0qY5WmX8C5ZsVhqAWn
         CzfnizKzL7UCz9AniEMRiHsM6zOTrp2q5eWnruaopgX6/Hoc/k+yUTBkfdyeQSHVEK2n
         5wKO7C47Wn6FWLBOAFYE7+wzN/KmD2UIA/VASUVuChYNviJNKc6lUjcPT/UN6465tEVS
         27klG59f+Nd9ePtc1FDxQpEXr2YUCjyfB4A0EKUL9oWryballHxj0/rOB8iC6qsMtVAV
         sFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782183003; x=1782787803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr4xgVO18u2WbaGeP1+M4CIAnONQq7B3nOwFcr50zAo=;
        b=IsIbvHcir3Z69rI28jEdE41rjLM/Zev7jPqYg/nfSNByBzlxlS9WwF4Nm/uU/HhifF
         C+DeGW5OaAPrugtcMZD9VQ4whpSSURYKd8wZ8dojRYAdn84PAHEVN7d4P2KOy3pNrbmu
         iuk0B80FBiUBVUwKQECYXN/fnhY7/6bGtQ8zHagdxIqMEYZNIueSWhLpI7QV0PcrlGsE
         leyzNTiZMDqegyrsTMY5RWWt/CKl3Bd9rXEKjJrbL3DG7djR+3YMx25jiKoXe+aEOsIE
         DLl3YhBhKEJEzi0kEVdd4V602oKbYvPAi2Q3NdFi+vsmrlF/CXbr2kH/CZ6nLAd/B4uS
         jUPA==
X-Forwarded-Encrypted: i=1; AFNElJ8xup6xGSWvdvb9AvJrU1JKZ9T65Dmrow3u9Va/Uv7A1rM2kz2WaDtnilOs8SIXW4nY4NK8GOi29tR5WQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwffM96ViNe9aHT63OPd0F29OjY2oTcy5d/eYxCnrSULACSLb5h
	JA8b+GpDyYVdW/MKi+RjY1xVJBD/StBQTKRrmvlQ7Kv/zB1SBVC3O+bN
X-Gm-Gg: AfdE7cmx5UgBNYgBnLadVq/TCN7AIyovsH3FXCz4/kdKVKyKe2ln96YzHNyrNI1CvP8
	QWow/3WAxgTYSbeZYRRmKL5W4IpgU+1EZYOzdg9euP98JqY6x/CM396Q2sbokyyQs3Iquuw6oGS
	2TmeS9UcqXoo1WfXQ+YKikVRIsGPVyUwXLmKmehhehUf/BH7bqpoqodBjK6pqc7e2oOCllf/IS4
	uAOXWvPVJPAutFYI15vxURFK2ar872xo+hAmNxHhqA8tGKb/sPu49dv3As66QZJH6dMLwl4khit
	N3O0ozj/UXwJqf8wg1gVZoTuq8ta1/hw0DbEFhwautHBp5dxWgY+fNfOWvcjwyH344Akz2HjSmP
	cUtcIpnObBKgBwSnq5VlbHJHp+rYEM3WbkDZvA28DCXxTQCi1bPVQgm210qU2w4sTndBQlOAb+c
	n6pazsaqXOj5WGlo+N+ocznIU=
X-Received: by 2002:a05:6a00:1742:b0:842:50fd:4c13 with SMTP id d2e1a72fcca58-84591b50e5emr1566841b3a.4.1782183003157;
        Mon, 22 Jun 2026 19:50:03 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed3212sm9178123b3a.55.2026.06.22.19.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 19:50:02 -0700 (PDT)
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
Subject: erofs: is z_erofs_put_pcluster()'s sbi access in the same UAF window as 1aee05e814d2?
Date: Tue, 23 Jun 2026 10:49:46 +0800
Message-ID: <20260623024946.3420476-1-zhanxusheng@xiaomi.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.ozlabs.org,vger.kernel.org,xiaomi.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3725-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:chao@kernel.org,m:jnhuang95@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng1024@gmail.com,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5975D6B39D0

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

Hi Xiang,

Following the race model established by commit 1aee05e814d2 ("erofs: fix
use-after-free on sbi->sync_decompress") -- i.e. unmount does not drain
the async decompress kworker, and unlocking the output folios lets inode
eviction (truncate_inode_pages waits on the locked folios) and thus the
unmount path proceed to kfree(sbi) -- I'd like to ask about another sbi
access that also happens after the unlock, in the same kworker.

In z_erofs_decompress_pcluster():

	erofs_onlinefolio_end(page_folio(page), err, true);  /* unlock */
	...
	z_erofs_put_pcluster(sbi, pcl, try_free);

and in z_erofs_put_pcluster():

	if (try_free && xa_trylock(&sbi->managed_pslots)) {
		free = __erofs_try_to_release_pcluster(sbi, pcl);
		xa_unlock(&sbi->managed_pslots);
	}

So in the try_free path it dereferences sbi->managed_pslots after the
output folios have been unlocked, which on control-flow alone looks
similar to the UAF fixed by 1aee05e814d2.

What makes me unsure, though, is a difference from the sync_decompress
case: sync_decompress is just a plain sbi member, whereas here
z_erofs_put_pcluster() is still operating on a live pcluster that is
registered in sbi->managed_pslots / the managed cache. So it's not clear
to me whether the pcluster / managed-cache lifetime rules implicitly pin
the filesystem instance and keep sbi valid across this window.

This also seems much harder to hit than the sync_decompress case: it is
conditional (try_free, i.e. non-managed compressed pages, plus the
pcluster refcount reaching zero), the window between the unlock and
put_pcluster is narrow, and unmount still has evict_inodes/put_super work
to do before kfree(sbi) -- which may be why syzbot didn't reach it.

Is there any guarantee that sbi stays valid here after the output folios
are unlocked (e.g. via pcluster / managed-cache lifetime or RCU), or
could unmount race with this path similarly to 1aee05e814d2? I'm asking
rather than sending a patch since I couldn't convince myself either way.

Thanks,
  Zhan Xusheng

