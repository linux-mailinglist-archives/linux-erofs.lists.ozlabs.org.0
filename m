Return-Path: <linux-erofs+bounces-3052-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wwSXCB//xmloRQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3052-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2026 23:05:19 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1820034BD8C
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2026 23:05:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjF7R4lRSz2ygY;
	Sat, 28 Mar 2026 09:05:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::735"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774649107;
	cv=none; b=TsrNQ3dg/bHqX4zF2R6yTFM0iPYCFs9w7k1aqRJLaLZD010RQZsvMAlXOBR8ni/KRpnjsASkmYGrLF33HAUyNfW9WyPZhU3be6vc9l86Td0Jiccz8erhYYPB9u8Q71QjPmyAsIbOucn46xXL2Irj5UTD2kddu4kICze4i+5SM+E1EHg0hj27mdZB5RkyYy5P3Sq3QVGlxCo4lvyiVCHfJXOE2O0sMFnwY9V+iL5nX21Banzm4jzog9wi3gTyoKfGr0Tz4lkqHtH9/9YjotJ0HDkUsVZ7mQvljDx4f5PuY+ew4e7rrS4zhZC+h2Xfg67/YcY3m3EFAcbiW+lJC8ayMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774649107; c=relaxed/relaxed;
	bh=3S8EhNAp/M6HE2VsRMXkSr61L034glOOF85HPPP/Kto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBTE4IifJo5eQokKJm2WaE/VkSRYGcrKTb0ucXQqFWOH0EhkD8BU1ch4gl4kie8wEc3Wlbhyp/WkopFqzDhjYWDt7MNWPXs0gzm6BALv5ihvucgzcQLx64htmcqNCa1B32BXMJMpn6ii+qtaYaWCOs1/O+xWkD3yxpEEv+mQG1eRM3/4l/9c1wW9IjoLGXaKTkCGLcr79uqopcrksP8DCstPMeUb2iMam8PQ6C5Y4UXg1q4hRL5WsM9yR9gCyjnxrJ6Gvij0x5ubT5HOe1/ZXtc5RbYHLGmj2BgLSJi7qga5mIYdi2UzukMpH1njUcPoXQx5vzCtbhE+c0o8mcA/Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=X6H/uhj7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=X6H/uhj7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjF7N6zWzz2xMQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 09:05:03 +1100 (AEDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-8cb40149037so301026785a.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2026 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774649101; x=1775253901; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3S8EhNAp/M6HE2VsRMXkSr61L034glOOF85HPPP/Kto=;
        b=X6H/uhj7EdBseIX8Bzeu4DqZ5duRzgd1UrIXGUlfvyS7kweC9M7h0wqK5+Jxo8A0cQ
         DzzYl4lJ6cNgc9a8F1ieEJZ5pRzFbPpAcXZJ3fYuk1ycKU6lk+tCJCNUrXogwMPcbCYD
         73rKudWw6vnKOwB+VG2dshWykZLXLLpRAFvEFfKyv253+Zo/6+EpdhhxCQejuXcLb0I8
         pvapW+EzK/FJlyOJFeQRKmJOA2a349llCpIllerPY6PjvFFX4gD49CmLK2i4uWddDt43
         0TkDdmTokKSEImBLpV9EFzmYjEXKLsvzWcXvOgst4gDQYd4E9jV8mMJ42uraeET4oKRN
         JPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774649101; x=1775253901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S8EhNAp/M6HE2VsRMXkSr61L034glOOF85HPPP/Kto=;
        b=Ct3JSmlqH5ecxNpA6+ejtGu7LjgnklaPOD8b3uakHEE0ERRougNFyDo/dtBZ6fouwg
         nnNZLRWaYZhgvuLxF/sEi2xBn73bOmhXqacjE6GfKKgSkvFuwxRbatI4vn1cCaMIL3Bm
         3hd1suZcJfVH12/zUin1sh8UCvqorncaRLaaY0mImE61xpkAVlQm4L7PZkgcqxiB0/iZ
         tAYnAoZJYKiXpRzWURqiAsE+WJin88KwstxO6SQ2dfMORq3cokL1f6/Lp1KMFxHsazvk
         iu5xEuukG+vn8GY90pdsTXG0eSVZB1/2HO6frkJOuBNs4gx9WKmP9glpVv4fNNlBZ24g
         DNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjqOlvK7u/sLabbx5OmUxSL5l+ES4SFc3z64U3ZuzQ/c1yj+WZtJwX7zFC7hXAt/X6+M5pM/m8880tqw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6e9oYb+4Q48tTu1xDc4UqT7OFzSwzXJGhaa4kUPLbVhdt3xHX
	pEfgps0RKB60XdIxcOL4+08Ne+HyM2OLUHv46q1RQlUWuFcfgwZiTzdpvU1vUfbRIA==
X-Gm-Gg: ATEYQzxEk8R1adakn/cRmw5mISMHBPyClk/8CCTCfJQSDSxmWlftMB/DWrzSw1kTxN2
	nM+yY9BS2qEqwhnVRzEbtXV5RGnGwc77lEMp0ilkLz5PdqhEqehxhCrw8r4UxJV43cRVHvmBsdA
	h9/PhmKmTMzGyOorkjI5Oh0+tTFQLC+uUQwlt98cAKjEoAdcLQj9KNfshA0cbun9RFb/Mi64ho7
	nsb4/0aIU/n6SNQPFlj8o3la/TuOVIJeEurYGEqe/KXBzWbK8fnrucO/UT68kgP436SQt69swy7
	Ly5Qnoxps44zvjYgafpawqeRwresT1/HI8LhytomUgszph0XZhSaFoF/Em5NHcnJeSg9qG1cC7w
	YidLLp7jpAbDBxGS+kusdqwrkWlUYK7jfNW7N+iE0exrNNtjGtVAXuaM7ec9nI5L7Il14u5hW5E
	EKurs69HDPkeZRygqlO2r0oWyGABi8PLaWaEfwNdC137G8DTiTRXCIs/vLodFdA3diZ/Fo/aAYz
	n4p75E=
X-Received: by 2002:a05:620a:2944:b0:8cb:52e0:15e7 with SMTP id af79cd13be357-8d01c621d51mr531573385a.33.1774649100763;
        Fri, 27 Mar 2026 15:05:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb8ebsm31425685a.7.2026.03.27.15.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:05:00 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/2] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Fri, 27 Mar 2026 18:04:31 -0400
Message-ID: <20260327220446.353103-4-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
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
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-3052-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1820034BD8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A very minor update to the v2 patchset[2] posted earlier this week.  The
changelog is below.  The primary reason for posting such a lightly revised
patchset is to drop the "RFC" qualifier as I've had the opportunity to do
additional testing and I'm reasonably happy with the results.  As always,
anyone reading this is welcome, and encouraged, to do any additional
testing they believe might be helpful.

I plan to merge this into lsm/stable-7.0 either later tonight, or sometime
over the weekend, so the patchset has some time in linux-next.  As we're
fairly close to the v7.1 merge window, I may decide to hold this for Linus
until then; let's see how things turn out with linux-next as well as any
additional review comments.

[2] https://lore.kernel.org/linux-security-module/20260323042510.3331778-4-paul@paul-moore.com/

--
CHANGELOG:
v3:
- fix the LSM hook stubs (kernel robot, Ryan Lee)
- fix the lsm_backing_file_cache allocation size (Ryan Lee)
- minor style, simplicity tweaks to the SELinux patch
v2:
- remove the user O_PATH file patch from Amir
- add the backing_file LSM blob and lifecycle hooks
- update the SELinux code to reflect the other changes
v1:
- initial version

--
Paul Moore (2):
      lsm: add backing_file LSM hooks
      selinux: fix overlayfs mmap() and mprotect() access checks

 fs/backing-file.c                 |   18 +-
 fs/erofs/ishare.c                 |   10 +
 fs/file_table.c                   |   21 ++
 fs/fuse/passthrough.c             |    2 
 fs/internal.h                     |    3 
 fs/overlayfs/dir.c                |    2 
 fs/overlayfs/file.c               |    2 
 include/linux/backing-file.h      |    4 
 include/linux/fs.h                |    1 
 include/linux/lsm_audit.h         |    2 
 include/linux/lsm_hook_defs.h     |    5 
 include/linux/lsm_hooks.h         |    1 
 include/linux/security.h          |   22 ++
 security/lsm.h                    |    1 
 security/lsm_init.c               |    9 +
 security/security.c               |  100 +++++++++++
 security/selinux/hooks.c          |  256 +++++++++++++++++++++---------
 security/selinux/include/objsec.h |   17 +
 18 files changed, 389 insertions(+), 87 deletions(-)


